import 'package:flutter/material.dart';

class FDialog {
  final GlobalKey<_InternalWidgetState> _globalKey = GlobalKey();

  /// 触摸到非内容区域是否关闭窗口
  final bool dismissOnTouchOutside;

  /// 窗口关闭监听
  VoidCallback onDismissListener;

  FDialog({
    this.dismissOnTouchOutside = true,
  });

  Widget _widget;
  bool _isShowing = false;

  bool get isShowing => _isShowing;

  Widget _widgetBuilder(BuildContext context) {
    return _InternalWidget(
      builder: (context) {
        if (dismissOnTouchOutside) {
          return _widget;
        }

        return Container(
          color: Colors.transparent,
          child: _widget,
          width: double.infinity,
          height: double.infinity,
        );
      },
      key: _globalKey,
    );
  }

  _InternalWidgetState checkState() {
    _InternalWidgetState state = _globalKey.currentState;
    if (state != null && state.mounted) {
      return state;
    }
    return null;
  }

  /// 显示窗口
  void show({
    @required BuildContext context,
    @required Widget widget,
  }) {
    if (_isShowing) {
      return;
    }

    assert(context != null);
    assert(widget != null);

    _isShowing = true;
    _widget = widget;
    showDialog(context: context, builder: _widgetBuilder).whenComplete(() {
      _isShowing = false;
      _widget = null;

      if (onDismissListener != null) {
        onDismissListener();
      }
    });
  }

  /// 关闭窗口
  void dismiss() {
    final _InternalWidgetState state = checkState();
    if (state != null && _isShowing) {
      _isShowing = false;
      Navigator.of(state.context).pop();
    }
  }
}

class _InternalWidget extends StatefulWidget {
  final WidgetBuilder builder;

  _InternalWidget({this.builder, Key key})
      : assert(builder != null),
        super(key: key);

  @override
  _InternalWidgetState createState() => _InternalWidgetState();
}

class _InternalWidgetState extends State<_InternalWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.builder(context);
  }
}
