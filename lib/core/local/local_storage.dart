import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorages {
  static LocalStorages? _instance;
  static SharedPreferences? _preferences;

  LocalStorages.init() {
    _instance = this;
  }

  static LocalStorages get instance {
    _instance ??= LocalStorages.init();
    return _instance!;
  }

  Future<SharedPreferences> initSharedPreferences() async {
    return _preferences = await SharedPreferences.getInstance();
  }

  Future<void> setShowOnboarding({required bool isShowOnboarding}) async {
    await _preferences?.setBool('show_onboarding', isShowOnboarding);
  }

  bool? getShowOnboarding() {
    return _preferences?.getBool('show_onboarding') ?? false;
  }

  Future<void> setIsLogin({required bool isLogin}) async {
    await _preferences?.setBool('isLogin', isLogin);
  }

  bool? getIsLogin() {
    return _preferences?.getBool('isLogin') ?? false;
  }

  Future<void> setThemeMode({required ThemeMode themeMode}) async {
    await _preferences?.setString('themeMode', themeMode.name);
  }

  String? getThemeMode() {
    return _preferences?.getString('themeMode');
  }
}
