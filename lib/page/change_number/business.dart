import 'package:flib_core/flib_core.dart';
import 'package:flib_live_data/flib_live_data.dart';

/// 页面业务类
class ChangeNumberBusiness extends FBusiness {
  ChangeNumberBusiness(FLifecycleOwner lifecycleOwner) : super(lifecycleOwner);

  final FLiveData<int> number = FLiveData(0);
  final FLiveData<bool> addTestView = FLiveData(false);

  @override
  void onCreate() {}

  /// 改变数字
  void changeNumber() {
    number.value = number.value + 1;
  }

  /// 添加或者移除TestView
  void toggleTestView() {
    addTestView.value = !addTestView.value;
  }
}
