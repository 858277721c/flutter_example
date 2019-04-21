typedef void FLifecycleObserver(FLifecycleEvent event, FLifecycleOwner owner);

abstract class FLifecycle {
  void addObserver(FLifecycleObserver observer);

  void removeObserver(FLifecycleObserver observer);

  FLifecycleState getCurrentState();
}

abstract class FLifecycleOwner {
  FLifecycle getLifecycle();
}

enum FLifecycleState {
  initialized,
  created,
  destroyed,
}

enum FLifecycleEvent {
  onCreate,
  onDestroy,
}
