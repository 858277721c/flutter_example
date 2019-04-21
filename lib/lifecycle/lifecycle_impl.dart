import 'package:my_flutter/lifecycle/lifecycle.dart';

class SimpleLifecycle implements FLifecycle {
  final List<_ObserverWrapper> _listObserver = [];
  FLifecycleState _state = FLifecycleState.initialized;

  bool _syncing = false;
  bool _needResync = false;

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

    final bool willResync = _checkWillResync();
    _listObserver.add(wrapper);
    if (willResync) {
      // 不做任何处理
    } else {
      _sync();
    }
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

    final bool willResync = _checkWillResync();
    if (willResync) {
      // 不做任何处理
    } else {
      _sync();
    }
  }

  void _sync() {
    _syncing = true;
    while (!_isSynced()) {
      _needResync = false;

      for (_ObserverWrapper item in _listObserver) {
        final bool synced = item.sync(
          getLifecycle: () => this,
          isCancel: () => _needResync,
        );

        if (_needResync || !synced) {
          break;
        }
      }
    }
    _needResync = false;
    _syncing = false;
  }

  bool _checkWillResync() {
    if (_syncing) {
      _needResync = true;
      return true;
    }
    return false;
  }

  bool _isSynced() {
    if (_listObserver.isEmpty) {
      return true;
    }

    final List<_ObserverWrapper> listCopy =
        List.from(_listObserver, growable: false);

    for (int i = listCopy.length - 1; i >= 0; i--) {
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

typedef FLifecycle _getLifecycle();
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
    _getLifecycle getLifecycle,
    _isCancel isCancel,
  }) {
    assert(getLifecycle != null);

    while (true) {
      final FLifecycleState outState = getLifecycle().getCurrentState();
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
      observer(nextEvent, getLifecycle());
      this.state = nextState;
    }
    return true;
  }
}
