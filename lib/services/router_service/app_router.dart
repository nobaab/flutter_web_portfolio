import 'package:flutter/material.dart';
import '../../screens/about/about_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case AboutScreenUI.id:
        return MaterialPageRoute(
          builder:
              (_) => AboutScreenUI(
                isDarkMode: true,
                toggleTheme: () {
                  // Implement your theme toggle logic here
                },
              ),
        );
      default:
        return null;
    }
  }
}
