import 'package:flib_core/flib_core.dart';
import 'package:flib_lifecycle_ext/flib_lifecycle_ext.dart';
import 'package:flutter/material.dart';

import 'business.dart';

class ChangeNumberPage extends StatefulWidget {
  @override
  _ChangeNumberPageState createState() => _ChangeNumberPageState();
}

class _ChangeNumberPageState extends State<ChangeNumberPage> {
  final _PageView pageView = _PageView(ChangeNumberBusiness());

  @override
  Widget build(BuildContext context) {
    return pageView.newWidget();
  }
}

/// 页面View
class _PageView extends FBusinessView<ChangeNumberBusiness> {
  _PageView(ChangeNumberBusiness business) : super(business);

  _TestView _testView;

  @override
  void onCreate() {
    print('ChangeNumberPage ${runtimeType} lifecycle onCreate');

    _testView = _TestView(business);

    business.number.addObserver((value) {
      reBuild();
    }, this);

    business.addTestView.addObserver((value) {
      reBuild();
    }, this);
  }

  @override
  void onStart() {
    super.onStart();
    print('ChangeNumberPage ${runtimeType} lifecycle onStart');
  }

  @override
  void onStop() {
    super.onStop();
    print('ChangeNumberPage ${runtimeType} lifecycle onStop');
  }

  @override
  void onDestroy() {
    super.onDestroy();
    print('ChangeNumberPage ${runtimeType} lifecycle onDestroy');
  }

  @override
  Widget buildImpl(BuildContext context) {
    print('ChangeNumberPage ${runtimeType} build');
    final List<Widget> list = [];
    list.add(FButton.raised(
      onPressed: () {
        business.toggleTestView();
      },
      child: Text('toggle view'),
    ));

    list.add(FButton.raised(
      padding: EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      onPressed: () {
        business.changeNumber();
      },
      child: Text(business.number.value.toString()),
    ));

    if (business.addTestView.value) {
      list.add(_testView.newWidget());
    }

    return FSafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text((ChangeNumberPage).toString()),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: list,
          ),
        ),
      ),
    ));
  }
}

class _TestView extends FBusinessView<ChangeNumberBusiness> {
  _TestView(ChangeNumberBusiness business) : super(business);

  @override
  void onCreate() {
    print('ChangeNumberPage ${runtimeType} lifecycle onCreate');
    business.number.addObserver((value) {
      reBuild();
    }, this);
  }

  @override
  void onStart() {
    super.onStart();
    print('ChangeNumberPage ${runtimeType} lifecycle onStart');
  }

  @override
  void onStop() {
    super.onStop();
    print('ChangeNumberPage ${runtimeType} lifecycle onStop');
  }

  @override
  void onDestroy() {
    super.onDestroy();
    print('ChangeNumberPage ${runtimeType} lifecycle onDestroy');
  }

  @override
  Widget buildImpl(BuildContext context) {
    print('ChangeNumberPage ${runtimeType} build');
    return Container(
      child: Text('TestView: ${business.number.value}'),
    );
  }
}
