import 'dart:async';

import 'package:flutter/material.dart';

typedef FPullRefreshStateChangeCallback = void Function(
    FPullRefreshState state);

enum FPullRefreshState {
  /// 空闲
  idle,

  /// 下拉刷新，还未达到可以刷新的条件
  pullRefresh,

  /// 松开刷新，已经达到可以刷新的条件
  releaseRefresh,

  /// 刷新中
  refresh,

  /// 展示刷新结果，用于扩展刷新成功和失败
  refreshResult,

  /// 刷新结束，如果未做任何操作，在动画结束后，回到[FPullRefreshState.idle]状态
  refreshFinish,
}

enum FPullRefreshDirection {
  none,
  top,
  bottom,
}

abstract class FPullRefreshController {
  FPullRefreshState get state;

  FPullRefreshDirection get refreshDirection;

  void addStateChangeCallback(FPullRefreshStateChangeCallback callback);

  void removeStateChangeCallback(FPullRefreshStateChangeCallback callback);

  void startRefresh();

  void stopRefresh({dynamic result});
}

abstract class FPullRefreshIndicator {
  Widget build(FPullRefreshController controller);
}

class FSimplePullRefreshController implements FPullRefreshController {
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
