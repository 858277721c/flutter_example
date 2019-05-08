import 'dart:async';

import 'pull_refresh.dart';

class FSimplePullRefresh implements FPullRefresh {
  FPullRefreshState _state = FPullRefreshState.idle;
  FPullRefreshDirection _refreshDirection = FPullRefreshDirection.none;

  final List<FPullRefreshStateChangeCallback> _listStateChangeCallback = [];

  Timer _stopRefreshTimer;

  @override
  FPullRefreshState get state => _state;

  @override
  FPullRefreshDirection get refreshDirection => _refreshDirection;

  @override
  void addStateChangeCallback(FPullRefreshStateChangeCallback callback) {
    if (callback == null || _listStateChangeCallback.contains(callback)) {
      return;
    }
    _listStateChangeCallback.add(callback);
  }

  @override
  void removeStateChangeCallback(FPullRefreshStateChangeCallback callback) {
    _listStateChangeCallback.remove(callback);
  }

  void _notifyStateChangeCallback(FPullRefreshState state) {
    if (_listStateChangeCallback.isEmpty) {
      return;
    }

    final List<FPullRefreshStateChangeCallback> listCopy =
        List.from(_listStateChangeCallback);

    listCopy.forEach((item) {
      item(state);
    });
  }

  void _setState(FPullRefreshState state) {
    assert(state != null);

    final FPullRefreshState old = _state;
    if (old == state) {
      return;
    }

    assert(_refreshDirection != FPullRefreshDirection.none);

    _state = state;

    if (_stopRefreshTimer != null) {
      _stopRefreshTimer.cancel();
      _stopRefreshTimer = null;
    }
    if (state == FPullRefreshState.refreshResult) {
      _stopRefreshTimer = Timer(Duration(milliseconds: 600), () {
        stopRefresh();
      });
    }

    _notifyStateChangeCallback(state);
  }

  void _setDirection(FPullRefreshDirection direction) {
    assert(direction != null);

    if (_refreshDirection == FPullRefreshDirection.none) {
      _refreshDirection = direction;
    } else {
      if (direction == FPullRefreshDirection.none) {
        _refreshDirection = direction;
      }
    }
  }

  void _updateUIByState() {}

  @override
  void startRefresh() {
    if (_state == FPullRefreshState.idle) {
      _setDirection(FPullRefreshDirection.top);
      _setState(FPullRefreshState.refresh);
      _updateUIByState();
    }
  }

  @override
  void stopRefresh({dynamic result}) {
    if (result != null) {
      if (_state == FPullRefreshState.refresh) {
        _setState(FPullRefreshState.refreshResult);
      }
    } else {
      if (_state == FPullRefreshState.refresh ||
          _state == FPullRefreshState.refreshResult) {
        _setState(FPullRefreshState.refreshFinish);
        _updateUIByState();
      }
    }
  }
}
