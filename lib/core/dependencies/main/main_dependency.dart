import 'package:flutter/material.dart';
import 'package:shoply_app_dashboard/core/dependencies/env/env_dependency.dart';
import 'package:shoply_app_dashboard/core/dependencies/firebase/firebase_dependency.dart';
import 'package:shoply_app_dashboard/core/dependencies/localstorge/localstorge_dependency.dart';
import 'package:shoply_app_dashboard/core/dependencies/supabase/supabase_dependency.dart';

class MainDependency {
  static Future<void> mainInitDependency() async {
    WidgetsFlutterBinding.ensureInitialized();
    await LocalStorageDependency.initLocalStorage();
    await FirebaseDependency.inttFirebaseDependency();
    await EnvDependency.initEnvDependency();
    await SupabaseDependency.initSupabase();
  }
}
