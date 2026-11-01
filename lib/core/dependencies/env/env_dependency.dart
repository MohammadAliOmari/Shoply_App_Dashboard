import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvDependency {
  static Future<void> initEnvDependency() async {
    await dotenv.load(fileName: ".env");
  }
}
