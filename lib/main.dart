import 'package:flutter/material.dart';
import 'package:shoply_app_dashboard/core/dependencies/main/main_dependency.dart';
import 'package:shoply_app_dashboard/core/router/app_pages.dart';
import 'package:shoply_app_dashboard/core/router/app_router.dart';
import 'package:shoply_app_dashboard/core/utils/theme/app_theme.dart';

void main() async {
  await MainDependency.mainInitDependency();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: AppPages.splashScreen,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.themeLight,
    );
  }
}
