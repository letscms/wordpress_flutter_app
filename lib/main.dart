import 'package:flutter/material.dart';
  import 'routes/app_routes.dart';

  void main() {
    runApp(const MainApp());
  }

  class MainApp extends StatelessWidget {
    const MainApp({super.key});

    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        initialRoute: AppRoutes.home,
        routes: AppRoutes.routes,
      );
    }
  }