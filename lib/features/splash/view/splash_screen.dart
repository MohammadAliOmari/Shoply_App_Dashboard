import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app_dashboard/core/router/app_pages.dart';
import 'package:shoply_app_dashboard/core/utils/images/app_images.dart';
import 'package:shoply_app_dashboard/features/splash/view_model/cubit.dart';
import 'package:shoply_app_dashboard/features/splash/view_model/state.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (context) => SplashCubit()..goNextPage(),
      child: Scaffold(
        body: BlocListener<SplashCubit, SplashState>(
          listener: (context, state) {
            debugPrint('Splash state received: $state');

            if (state is SplashLoginPageState) {
              log(state.toString());
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppPages.loginScreen,
                (route) => false,
              );
            } else if (state is SplashHomePageState) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppPages.layoutScreen,
                (route) => false,
              );
            }
          },
          child: Center(
            child: Image(
              image: AssetImage(AppImages.shoplyLogo),
              height: 350,
              width: 350,
              color: theme.primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
