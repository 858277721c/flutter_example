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

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final Color mainColor = FRes.colors().mainColor;

    return MaterialApp(
      theme: ThemeData(
        primaryColor: mainColor,
        accentColor: mainColor,
        scaffoldBackgroundColor: FRes.colors().bgPage,
        buttonTheme: FButtonThemeData(),
        appBarTheme: FAppBarTheme(),
      ),
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

    final String titleBarPage = (TitleBarPage as Type).toString();
    final String mainPage = (MainPage as Type).toString();
    final String textFieldPage = (TextFieldPage as Type).toString();
    final String systemBarPage = (SystemBarPage as Type).toString();
    final String buttonPage = (ButtonPage as Type).toString();

    return FSafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              children: <Widget>[
                _getButton(titleBarPage, context),
                _getButton(mainPage, context),
                _getButton(textFieldPage, context),
                _getButton(systemBarPage, context),
                _getButton(buttonPage, context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  MaterialButton _getButton(String routeName, BuildContext context) {
    return RaisedButton(
      onPressed: () {
        Navigator.of(context).pushNamed(routeName);
      },
      child: Text(routeName),
    );
  }
}
