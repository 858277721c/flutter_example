import 'package:flutter/material.dart';

import 'locale.dart';

typedef OnPressedMenu = Function(int index);

class FDialogMenuView extends StatelessWidget {
  final String title;
  final TextStyle titleTextStyle;
  final VoidCallback onPressedClose;

  final String cancel;
  final TextStyle cancelTextStyle;

  final List<dynamic> menus;
  final TextStyle menusTextStyle;

  final OnPressedMenu onPressedMenu;
  final int selectedIndex;

  FDialogMenuView({
    this.title,
    this.titleTextStyle,
    this.onPressedClose,
    this.cancel = '',
    this.cancelTextStyle,
    this.menus,
    this.menusTextStyle,
    this.onPressedMenu,
    this.selectedIndex = -1,
  }) : assert(menus != null);

  Widget buildTitle(
    BuildContext context,
    ThemeData theme,
    DialogTheme dialogTheme,
  ) {
    final List<Widget> listTitle = [];

    String titleText = title;
    if (titleText == '') {
      titleText = FLibDialogLocale.pleaseSelect(context);
    }

    final TextStyle targetTitleTextStyle = titleTextStyle ??
        dialogTheme.titleTextStyle ??
        theme.textTheme.title ??
        TextStyle(
          fontSize: 16,
          color: Color(0xFF333333),
        );

    Widget widgetTextTitle = DefaultTextStyle(
      style: targetTitleTextStyle,
      child: Text(titleText),
    );

    listTitle.add(Container(
      alignment: Alignment.centerLeft,
      child: widgetTextTitle,
    ));

    if (onPressedClose != null) {
      Widget widgetClose = Container(
        color: Colors.transparent,
        padding: EdgeInsets.only(
          left: 10,
          right: 10,
        ),
        child: Icon(
          Icons.close,
          size: 12,
          color: Color(0xFF8d97a3),
        ),
      );

      widgetClose = GestureDetector(
        child: widgetClose,
        onTap: onPressedClose,
      );

      listTitle.add(Container(
        alignment: Alignment.centerRight,
        child: widgetClose,
      ));
    }

    return Container(
      height: 40,
      width: double.infinity,
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 10),
      child: Stack(
        children: listTitle,
      ),
    );
  }

  Widget buildMenu(
    int index,
    ThemeData theme,
    DialogTheme dialogTheme,
  ) {
    final TextStyle targetMenusTextStyle = menusTextStyle ??
        dialogTheme.contentTextStyle ??
        TextStyle(
          fontSize: 14,
          color: Color(0xFF333333),
        );

    final List<Widget> listMenuRow = [];
    listMenuRow.add(DefaultTextStyle(
      style: targetMenusTextStyle,
      child: Text(menus[index].toString()),
    ));

    listMenuRow.add(Spacer());

    if (index == selectedIndex) {
      listMenuRow.add(Icon(
        Icons.check,
        color: theme.accentColor,
        size: 15,
      ));
    }

    Widget widgetMenu = Row(
      children: listMenuRow,
    );

    widgetMenu = InkWell(
      child: widgetMenu,
      onTap: onPressedMenu == null
          ? null
          : () {
              onPressedMenu(index);
            },
    );

    widgetMenu = wrapPadding(widgetMenu);
    widgetMenu = wrapBottomDivider(widgetMenu);

    return widgetMenu;
  }

  Widget wrapPadding(Widget widget) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 10,
      ),
      child: widget,
    );
  }

  Widget wrapBottomDivider(Widget widget) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        widget,
        buildDivider(EdgeInsets.only(left: 20)),
      ],
    );
  }

  Widget buildDivider(EdgeInsetsGeometry margin) {
    return Container(
      margin: margin,
      color: Color(0xFF999999),
      height: 0.3,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final DialogTheme dialogTheme = DialogTheme.of(context);

    final List<Widget> list = [];

    if (title != null) {
      list.add(buildTitle(context, theme, dialogTheme));
      list.add(buildDivider(null));
    }

    if (menus.length > 0) {
      list.add(ListView.builder(
        itemCount: menus.length,
        itemBuilder: (context, index) {
          return buildMenu(index, theme, dialogTheme);
        },
      ));
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: list,
    );
  }
}
