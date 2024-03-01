import 'package:supabase_flutter/supabase_flutter.dart';

class AppConfig {
  // final supaBase = SupabaseClient('https://nbgshrovkhwomrmlfwjc.supabase.co', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5iZ3Nocm92a2h3b21ybWxmd2pjIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTk2MDU0ODMsImV4cCI6MjAxNTE4MTQ4M30.laBr5eTUAoTNBjm4oCidyBaoyLCm1LZOPTWkTUjvcts');

  final supaBaseClient = Supabase.instance.client;

  // final baseUrl = 'https://smartrent.smartcase.co.ug/';
  final baseUrl = 'https://rentest.smartcase.co.ug/';
}
