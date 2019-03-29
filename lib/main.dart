import 'package:flib_core/flib_core.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/page/button_page.dart';
import 'package:my_flutter/page/main_page.dart';
import 'package:my_flutter/page/system_bar.dart';
import 'package:my_flutter/page/text_field.dart';
import 'package:my_flutter/page/title_bar_page.dart';

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
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: FTheme.themeData(),
      routes: {
        (TitleBarPage as Type).toString(): (_) => TitleBarPage(),
        (MainPage as Type).toString(): (_) => MainPage(),
        (TextFieldPage as Type).toString(): (_) => TextFieldPage(),
        (SystemBarPage as Type).toString(): (_) => SystemBarPage(),
        (ButtonPage as Type).toString(): (_) => ButtonPage(),
      },
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends FState<MyHomePage> {
  @override
  void initState() {
    super.initState();
    print('MyHomePage initState');
  }

  @override
  void deactivate() {
    super.deactivate();
    print('MyHomePage deactivate');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('MyHomePage didChangeDependencies');
  }

  @override
  void didUpdateWidget(MyHomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('MyHomePage didUpdateWidget');
  }

  @override
  void dispose() {
    super.dispose();
    print('MyHomePage dispose');
  }

  @override
  void onPause() {
    super.onPause();
    print('MyHomePage onPause');
  }

  @override
  void onResume() {
    super.onResume();
    print('MyHomePage onResume');
  }

  @override
  Widget buildImpl(BuildContext context) {
    print('MyHomePage build');

    final List<Widget> children = [
      _getButton((TitleBarPage).toString(), context),
      _getButton((MainPage).toString(), context),
      _getButton((TextFieldPage).toString(), context),
      _getButton((SystemBarPage).toString(), context),
      _getButton((ButtonPage).toString(), context),
    ];

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
