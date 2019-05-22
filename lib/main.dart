import 'package:flib_core/flib_core.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/page/button_page.dart';
import 'package:my_flutter/page/change_number/page.dart';
import 'package:my_flutter/page/dialog_page.dart';
import 'package:my_flutter/page/eventbus_page.dart';
import 'package:my_flutter/page/ink_page.dart';
import 'package:my_flutter/page/lifecycle_page.dart';
import 'package:my_flutter/page/main_page.dart';
import 'package:my_flutter/page/new_page.dart';
import 'package:my_flutter/page/stepper_page.dart';
import 'package:my_flutter/page/system_bar_page.dart';
import 'package:my_flutter/page/text_field_page.dart';
import 'package:my_flutter/page/title_bar_page.dart';
import 'package:my_flutter/page/pull_refresh_page.dart';
import 'package:my_flutter/page/listview_page.dart';
import 'package:my_flutter/page/custom_painter.dart';

void main() {
  FRes.getInstance().init(
    colors: FResColors(
      mainColor: Colors.red,
    ),
    titleBar: FResTitleBar(
      backgroundColor: Colors.red,
    ),
  );

  runApp(FSystemUiOverlay(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  static final Map<String, WidgetBuilder> routes = {
    (TitleBarPage).toString(): (_) => TitleBarPage(),
    (MainPage).toString(): (_) => MainPage(),
    (TextFieldPage).toString(): (_) => TextFieldPage(),
    (SystemBarPage).toString(): (_) => SystemBarPage(),
    (ButtonPage).toString(): (_) => ButtonPage(),
    (InkPage).toString(): (_) => InkPage(),
    (StepperPage).toString(): (_) => StepperPage(),
    (DialogPage).toString(): (_) => DialogPage(),
    (LifecyclePage).toString(): (_) => LifecyclePage(),
    (EventBusPage).toString(): (_) => EventBusPage(),
    (ChangeNumberPage).toString(): (_) => ChangeNumberPage(),
    (NewPage).toString(): (_) => NewPage(),
    (PullRefreshPage).toString(): (_) => PullRefreshPage(),
    (ListViewPage).toString(): (_) => ListViewPage(),
    (CustomPainterPage).toString(): (_) => CustomPainterPage(),
  };

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: FTheme.themeData(),
      routes: routes,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [];
    MyApp.routes.forEach((key, value) {
      children.add(_getButton(key, context));
    });

    return FSafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              children: children,
            ),
          ),
        ),
      ),
    );
  }

  Widget _getButton(String routeName, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 5,
        bottom: 5,
      ),
      child: RaisedButton(
        onPressed: () {
          Navigator.of(context).pushNamed(routeName);
        },
        child: Text(routeName),
      ),
    );
  }
}
