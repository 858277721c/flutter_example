import 'package:flib_lifecycle_ext/flib_lifecycle_ext.dart';

/// 页面业务类
class ChangeNumberBusiness extends FBusiness {
  final FLiveData<int> number = FLiveData(0);
  final FLiveData<bool> addTestView = FLiveData(false);

  /// 改变数字
  void changeNumber() {
    number.value = number.value + 1;
  }

  /// 添加或者移除TestView
  void toggleTestView() {
    addTestView.value = !addTestView.value;
  }
}
