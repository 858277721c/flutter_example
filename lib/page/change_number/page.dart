import 'package:flib_core/flib_core.dart';
import 'package:flutter/material.dart';

import 'business.dart';

class ChangeNumberPage extends StatefulWidget {
  @override
  _ChangeNumberPageState createState() => _ChangeNumberPageState();
}

class _ChangeNumberPageState
    extends FBusinessState<ChangeNumberPage, ChangeNumberBusiness> {
  @override
  ChangeNumberBusiness createBusiness() {
    return ChangeNumberBusiness(this);
  }

  @override
  void initState() {
    super.initState();
    business.addTestView.addObserver((value) {
      setState(() {});
    }, this);
  }

  @override
  Widget buildImpl(BuildContext context) {
    print('ChangeNumberPage ${runtimeType} build');
    final List<Widget> list = [];

    list.add(_NumberView());

    list.add(FButton.raised(
      onPressed: () {
        business.toggleTestView();
      },
      child: Text('toggle view'),
    ));

    if (business.addTestView.value) {
      list.add(_TestView());
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

class _NumberView extends StatefulWidget {
  @override
  _NumberViewState createState() => _NumberViewState();
}

class _NumberViewState
    extends FTargetState<_NumberView, _ChangeNumberPageState> {
  @override
  void onTargetState(_ChangeNumberPageState state) {
    state.business.number.addObserver((value) {
      setState(() {});
    }, this);
  }

  @override
  Widget buildImpl(BuildContext context) {
    return FButton.raised(
      padding: EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      onPressed: () {
        targetState.business.changeNumber();
      },
      child: Text(targetState.business.number.value.toString()),
    );
  }
}

class _TestView extends StatefulWidget {
  @override
  _TestViewState createState() => _TestViewState();
}

class _TestViewState extends FTargetState<_TestView, _ChangeNumberPageState> {
  @override
  void onTargetState(_ChangeNumberPageState state) {
    state.business.number.addObserver((value) {
      reBuild();
    }, this);
  }

  @override
  Widget buildImpl(BuildContext context) {
    return Container(
      child: Text('TestView: ${targetState.business.number.value}'),
    );
  }
}
