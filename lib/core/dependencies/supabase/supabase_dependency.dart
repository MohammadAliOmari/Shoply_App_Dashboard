import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseDependency {
  static Future<void> initSupabase() async {
    await Supabase.initialize(
      url: dotenv.env['supabase_url']!,
      publishableKey: dotenv.env['supabass_key']!,
    );
  }
}
