import 'package:flutter/material.dart';
import 'package:shoply_app_dashboard/core/model/order/response_order.dart';
import 'package:shoply_app_dashboard/core/router/app_pages.dart';
import 'package:shoply_app_dashboard/features/layout/view/layout_screen.dart';
import 'package:shoply_app_dashboard/features/login/view/login_screen.dart';
import 'package:shoply_app_dashboard/features/order_details/view/order_details_screen.dart';
import 'package:shoply_app_dashboard/features/splash/view/splash_screen.dart';

class AppRouter {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppPages.splashScreen:
        return MaterialPageRoute(
          builder: (context) {
            return SplashScreen();
          },
        );
      case AppPages.layoutScreen:
        return MaterialPageRoute(builder: (context) => LayoutScreen());

      case AppPages.loginScreen:
        return MaterialPageRoute(
          builder: (context) {
            return const LoginScreen();
          },
        );
      case AppPages.orderDetailsScreen:
        return MaterialPageRoute(
          builder: (context) {
            final arguments = settings.arguments as Map<String, dynamic>;
            final order = arguments['order'] as OrderResponse;
            return OrderDetailsScreen(order: order);
          },
        );
    }
    return null;
  }
}
