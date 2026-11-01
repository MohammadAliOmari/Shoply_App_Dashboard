import 'package:shoply_app_dashboard/core/local/local_storage.dart';

class LocalStorageDependency {
  static Future<void> initLocalStorage() async {
    await LocalStorages.instance.initSharedPreferences();
  }
}
