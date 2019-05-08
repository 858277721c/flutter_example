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

abstract class FPullRefresh {
  FPullRefreshState get state;

  FPullRefreshDirection get refreshDirection;

  void addStateChangeCallback(FPullRefreshStateChangeCallback callback);

  void removeStateChangeCallback(FPullRefreshStateChangeCallback callback);

  void startRefresh();

  void stopRefresh({dynamic result});
}
