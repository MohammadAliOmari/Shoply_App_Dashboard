import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_app_dashboard/features/add_product/view/add_product_screen.dart';
import 'package:shoply_app_dashboard/features/layout/view_model/state.dart';
import 'package:shoply_app_dashboard/features/order/view/order_screen.dart';
import 'package:shoply_app_dashboard/features/sales/view/sales_screen.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutInitState());
  // final _layoutRepo = LayoutRepo();
  int selectedIndex = 0;
  int cartCount = 0;
  int favCount = 0;

  List<Widget> pages = [OrderScreen(), AddProductScreen(), SalesScreen()];
  List<String> appbarTitle = ['Orders', 'Add Products', 'Add Sales'];
  void changeNavBarIndex(int index) {
    selectedIndex = index;
    emit(LayoutChangeNavBarIndexState());
  }

  // Future<void> getCartCount() async {
  //   // final result = await _layoutRepo.getCartCount();
  //   result.fold((_) {}, (cartCount) {
  //     this.cartCount = cartCount;
  //     emit(LayoutChangeCartCountState());
  //   });
  // }

  void decrementCartCount() {
    cartCount--;
    emit(LayoutChangeCartCountState());
  }

  void removeCartCount() {
    cartCount = 0;
    emit(LayoutChangeCartCountState());
  }

  // Future<void> getFavCount() async {
  //   final result = await _layoutRepo.getFavCount();
  //   result.fold((_) {}, (favCount) {
  //     this.favCount = favCount;
  //     emit(LayoutChangeFavCountState());
  //   });
  // }

  // void incrementFavCount() {
  //   favCount++;
  //   emit(LayoutChangeFavCountState());
  // }

  // void decrementFavCount() {
  //   favCount--;
  //   emit(LayoutChangeFavCountState());
  // }

  // Future<void> logout() async {
  //   LocalStorages.instance.setIsLogin(isLogin: false);
  //   LocalStorageUser.instance.clearUserData();
  //   await _layoutRepo.logOut();
  // }
}
