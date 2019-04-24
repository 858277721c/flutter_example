import 'package:flib_core/flib_core.dart';
import 'package:flib_lifecycle_ext/flib_lifecycle_ext.dart';
import 'package:flutter/material.dart';

import 'business.dart';

class ChangeNumberPage extends StatefulWidget {
  @override
  _ChangeNumberPageState createState() => _ChangeNumberPageState();
}

class _ChangeNumberPageState extends FState<ChangeNumberPage> {
  final ChangeNumberBusiness business = ChangeNumberBusiness();

  _NumberView numberView;
  _TestView testView;

  @override
  void initState() {
    super.initState();
    this.numberView = _NumberView(business);
    this.testView = _TestView(business);

    business.addTestView.addObserver((value) {
      setState(() {});
    }, this);
  }

  @override
  Widget buildImpl(BuildContext context) {
    print('ChangeNumberPage ${runtimeType} build');
    final List<Widget> list = [];

    list.add(numberView.newWidget());

    list.add(FButton.raised(
      onPressed: () {
        business.toggleTestView();
      },
      child: Text('toggle view'),
    ));

    if (business.addTestView.value) {
      list.add(testView.newWidget());
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

class _NumberView extends FBusinessView<ChangeNumberBusiness> {
  _NumberView(ChangeNumberBusiness business) : super(business) {
    print('ChangeNumberPage ${runtimeType} create----------');
  }

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
    return FButton.raised(
      padding: EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      onPressed: () {
        business.changeNumber();
      },
      child: Text(business.number.value.toString()),
    );
  }
}

class _TestView extends FBusinessView<ChangeNumberBusiness> {
  _TestView(ChangeNumberBusiness business) : super(business) {
    print('ChangeNumberPage ${runtimeType} create----------');
  }

  @override
  void onCreate() {
    print('ChangeNumberPage ${runtimeType} lifecycle onCreate');
    business.number.addObserver((value) {
      print(
          'ChangeNumberPage ${runtimeType} number changed lifecycle:${getLifecycle().getCurrentState()}');
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
