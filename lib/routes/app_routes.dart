// lib/routes/app_routes.dart
import 'package:flutter/material.dart';
import 'package:wprestapi/screens/another_screen.dart';
import 'package:wprestapi/screens/home/home_screen.dart';
import 'package:wprestapi/screens/profile_screen.dart';
import 'package:wprestapi/screens/settings_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String another = '/another';

  static Map<String, WidgetBuilder> routes = {
    home: (context) => const HomeScreen(),
    another: (context) => const AnotherScreen(),
    profile: (context) => const ProfileScreen(),
    settings: (context) => const SettingsScreen(),
  };
}