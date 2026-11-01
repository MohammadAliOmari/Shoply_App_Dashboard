import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app_dashboard/core/local/local_storage.dart';
import 'package:shoply_app_dashboard/features/splash/view_model/state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitState());

  Future<void> goNextPage() async {
    bool? isLogin = LocalStorages.instance.getIsLogin();

    await Future.delayed(Duration(seconds: 1)).then((_) async {
      if (isLogin ?? false) {
        emit(SplashHomePageState());
      } else {
        emit(SplashLoginPageState());
      }
    });
  }
}
