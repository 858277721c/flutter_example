import 'package:my_flutter/lifecycle/lifecycle.dart';

class SimpleLifecycle implements FLifecycle {
  final FLifecycleOwner _lifecycleOwner;
  final List<_ObserverWrapper> _listObserver = [];
  FLifecycleState _state = FLifecycleState.initialized;

  bool _handlingEvent = false;
  bool _newEventOccurred = false;

  SimpleLifecycle(FLifecycleOwner lifecycleOwner)
      : assert(lifecycleOwner != null),
        this._lifecycleOwner = lifecycleOwner;

  @override
  void addObserver(FLifecycleObserver observer) {
    if (_state == FLifecycleState.destroyed) {
      return;
    }

    assert(observer != null);
    for (_ObserverWrapper item in _listObserver) {
      if (item.observer == observer) {
        return;
      }
    }

    final _ObserverWrapper wrapper = _ObserverWrapper(
      observer: observer,
      state: FLifecycleState.initialized,
    );

    wrapper.sync(
      getState: getCurrentState,
      getLifecycleOwner: () => _lifecycleOwner,
    );

    _listObserver.add(wrapper);
  }

  @override
  void removeObserver(FLifecycleObserver observer) {
    final int index = _listObserver.indexWhere((item) {
      return item.observer == observer;
    });

    if (index >= 0) {
      _listObserver.removeAt(index);
    }
  }

  @override
  FLifecycleState getCurrentState() {
    return _state;
  }

  void handleLifecycleEvent(FLifecycleEvent event) {
    assert(event != null);

    final FLifecycleState next = _getStateAfter(event);
    _moveToState(next);
  }

  void _moveToState(FLifecycleState next) {
    if (_state == next) {
      return;
    }

    if (_state == FLifecycleState.destroyed) {
      return;
    }

    _state = next;

    if (_handlingEvent) {
      _newEventOccurred = true;
      return;
    }

    _handlingEvent = true;
    _sync();
    _handlingEvent = false;
  }

  void _sync() {
    while (!_isSynced()) {
      _newEventOccurred = false;

      for (_ObserverWrapper item in _listObserver) {
        final bool synced = item.sync(
          getState: getCurrentState,
          getLifecycleOwner: () => _lifecycleOwner,
          isCancel: () => _newEventOccurred,
        );

        if (!synced) {
          break;
        }
      }
    }
    _newEventOccurred = false;
  }

  bool _isSynced() {
    if (_listObserver.isEmpty) {
      return true;
    }

    final List<_ObserverWrapper> listCopy =
        List.from(_listObserver, growable: false);

    for (int i = listCopy.length - 1; i >= 0; i++) {
      final _ObserverWrapper item = listCopy[i];
      if (item.state != _state) {
        return false;
      }
    }

    return true;
  }
}

FLifecycleState _getStateAfter(FLifecycleEvent event) {
  switch (event) {
    case FLifecycleEvent.onCreate:
      return FLifecycleState.created;
    case FLifecycleEvent.onDestroy:
      return FLifecycleState.destroyed;
    default:
      throw Exception('Unexpected event value ${event}');
  }
}

FLifecycleEvent _highEvent(FLifecycleState state) {
  switch (state) {
    case FLifecycleState.initialized:
      return FLifecycleEvent.onCreate;
    case FLifecycleState.created:
      return FLifecycleEvent.onDestroy;
    case FLifecycleState.destroyed:
      throw Exception('destroyed state doesn\'t have a high event');
    default:
      throw Exception('Unexpected state value ${state}');
  }
}

FLifecycleEvent _lowEvent(FLifecycleState state) {
  throw Exception('Unexpected state value ${state}');
}

typedef FLifecycleState _getState();
typedef FLifecycleOwner _getLifecycleOwner();
typedef bool _isCancel();

class _ObserverWrapper {
  final FLifecycleObserver observer;
  FLifecycleState state;

  _ObserverWrapper({
    this.observer,
    this.state,
  })  : assert(observer != null),
        assert(state == FLifecycleState.initialized ||
            state == FLifecycleState.destroyed);

  bool sync({
    _getState getState,
    _getLifecycleOwner getLifecycleOwner,
    _isCancel isCancel,
  }) {
    assert(getState != null);
    assert(getLifecycleOwner != null);

    while (true) {
      final FLifecycleState outState = getState();
      if (this.state == outState) {
        break;
      }

      if (isCancel != null && isCancel()) {
        return false;
      }

      final FLifecycleEvent nextEvent = this.state.index < outState.index
          ? _highEvent(state)
          : _lowEvent(state);

      final FLifecycleState nextState = _getStateAfter(nextEvent);
      observer(nextEvent, getLifecycleOwner());
      this.state = nextState;
    }
    return true;
  }
}
