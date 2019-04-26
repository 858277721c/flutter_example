import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'ext.dart';

class FBGestureDetector extends FChildWidgetBuilder {
  GestureTapDownCallback onTapDown;
  GestureTapUpCallback onTapUp;
  GestureTapCallback onTap;
  GestureTapCancelCallback onTapCancel;

  GestureTapCallback onDoubleTap;

  GestureLongPressCallback onLongPress;
  GestureLongPressUpCallback onLongPressUp;
  GestureLongPressDragStartCallback onLongPressDragStart;
  GestureLongPressDragUpdateCallback onLongPressDragUpdate;
  GestureLongPressDragUpCallback onLongPressDragUp;

  GestureDragDownCallback onVerticalDragDown;
  GestureDragStartCallback onVerticalDragStart;
  GestureDragUpdateCallback onVerticalDragUpdate;
  GestureDragEndCallback onVerticalDragEnd;
  GestureDragCancelCallback onVerticalDragCancel;

  GestureDragDownCallback onHorizontalDragDown;
  GestureDragStartCallback onHorizontalDragStart;
  GestureDragUpdateCallback onHorizontalDragUpdate;
  GestureDragEndCallback onHorizontalDragEnd;
  GestureDragCancelCallback onHorizontalDragCancel;

  GestureForcePressStartCallback onForcePressStart;
  GestureForcePressPeakCallback onForcePressPeak;
  GestureForcePressUpdateCallback onForcePressUpdate;
  GestureForcePressEndCallback onForcePressEnd;

  GestureDragDownCallback onPanDown;
  GestureDragStartCallback onPanStart;
  GestureDragUpdateCallback onPanUpdate;
  GestureDragEndCallback onPanEnd;
  GestureDragCancelCallback onPanCancel;

  GestureScaleStartCallback onScaleStart;
  GestureScaleUpdateCallback onScaleUpdate;
  GestureScaleEndCallback onScaleEnd;

  HitTestBehavior behavior;
  bool excludeFromSemantics = false;
  DragStartBehavior dragStartBehavior = DragStartBehavior.down;

  GestureDetector build() {
    return GestureDetector();
  }
}
