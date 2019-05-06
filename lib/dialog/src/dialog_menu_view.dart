import 'package:flutter/material.dart';

import 'locale.dart';

typedef OnClickMenu = Function(int index);

class FDialogMenuView extends StatelessWidget {
  final String title;
  final TextStyle titleTextStyle;
  final VoidCallback onClickClose;

  final String cancel;
  final TextStyle cancelTextStyle;

  final List<dynamic> menus;
  final TextStyle menusTextStyle;

  final OnClickMenu onClickMenu;
  final int selectedIndex;

  FDialogMenuView({
    this.title,
    this.titleTextStyle,
    this.onClickClose,
    this.cancel = '',
    this.cancelTextStyle,
    this.menus,
    this.menusTextStyle,
    this.onClickMenu,
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

    if (onClickClose != null) {
      Widget widgetClose = Container(
        color: Colors.transparent,
        padding: EdgeInsets.only(
          left: 10,
          right: 10,
        ),
        height: double.infinity,
        child: Icon(
          Icons.close,
          size: 20,
          color: Color(0xFF8d97a3),
        ),
      );

      widgetClose = GestureDetector(
        child: widgetClose,
        onTap: onClickClose,
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
    final List<Widget> listMenuRow = [];

    final TextStyle targetMenusTextStyle = menusTextStyle ??
        dialogTheme.contentTextStyle ??
        TextStyle(
          fontSize: 14,
          color: Color(0xFF333333),
        );

    listMenuRow.add(DefaultTextStyle(
      style: targetMenusTextStyle,
      child: Text(menus[index].toString()),
    ));

    listMenuRow.add(Spacer());

    if (index == selectedIndex) {
      listMenuRow.add(Icon(
        Icons.check,
        color: theme.accentColor,
        size: 20,
      ));
    }

    Widget widgetMenu = Row(
      children: listMenuRow,
    );

    widgetMenu = wrapMenuHeight(widgetMenu);
    widgetMenu = wrapMenuPadding(widgetMenu);

    widgetMenu = InkWell(
      child: widgetMenu,
      onTap: onClickMenu == null
          ? null
          : () {
              onClickMenu(index);
            },
    );

    widgetMenu = wrapMenuBottomDivider(widgetMenu);
    return widgetMenu;
  }

  Widget wrapMenuHeight(Widget widget) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 40),
      child: widget,
    );
  }

  Widget wrapMenuPadding(Widget widget) {
    return Padding(
      padding: EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      child: widget,
    );
  }

  Widget wrapMenuBottomDivider(Widget widget) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        widget,
        buildDivider(EdgeInsets.only(left: 10)),
      ],
    );
  }

  Widget buildDivider(EdgeInsetsGeometry margin) {
    return Container(
      margin: margin,
      width: double.infinity,
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
      Widget widgetMenus = ListView.builder(
        shrinkWrap: true,
        itemCount: menus.length,
        itemBuilder: (context, index) {
          return buildMenu(index, theme, dialogTheme);
        },
      );

      list.add(widgetMenus);
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: list,
    );
  }
}
