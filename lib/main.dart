import 'package:flutter/material.dart';
import 'shared/navbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'services/router_service/app_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp(appRouter: AppRouter()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.appRouter});
  final AppRouter appRouter;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Create text theme with Inter font
    final interTextTheme = GoogleFonts.interTextTheme();

    // Custom dark mode color - #272C35
    final customDarkColor = const Color(0xFF272C35);

    // Light theme with pure white background
    final lightTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue, brightness: Brightness.light),
      textTheme: interTextTheme,
      primaryTextTheme: interTextTheme,
    );

    // Dark theme with Inter font and custom background color
    final darkTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: customDarkColor,
      // Create a dark color scheme using the custom dark color
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: Colors.blueAccent,
        onPrimary: Colors.white,
        secondary: Colors.lightBlueAccent,
        onSecondary: Colors.white,
        error: Colors.redAccent,
        onError: Colors.white,
        surface: customDarkColor.lighten(5), // Slightly lighter for surface elements
        onSurface: Colors.white,
      ),
      // Apply Inter to the entire text theme
      textTheme: interTextTheme,
      primaryTextTheme: interTextTheme,
    );

    return MaterialApp(
      builder:
          (context, child) => ResponsiveBreakpoints.builder(
            breakpoints: [
              const Breakpoint(start: 0, end: 450, name: MOBILE),
              const Breakpoint(start: 451, end: 800, name: TABLET),
              const Breakpoint(start: 801, end: 1920, name: DESKTOP),
              const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
            ],
            child: child!,
          ),
      theme: lightTheme,
      title: "Mozammel Hoshen Chowdhury | Software Engineer",
      darkTheme: darkTheme,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: NavBar(isMobile: false, isDarkMode: isDarkMode, onThemeToggle: toggleTheme),
      //home: HomeScreenUI(isDarkMode: isDarkMode, toggleTheme: toggleTheme),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter().onGenerateRoute,
    );
  }
}

// Extension to lighten and darken colors
extension ColorExtension on Color {
  Color lighten([int percent = 10]) {
    assert(1 <= percent && percent <= 100);
    final p = percent / 100;
    return Color.fromARGB(
      alpha,
      red + ((255 - red) * p).round(),
      green + ((255 - green) * p).round(),
      blue + ((255 - blue) * p).round(),
    );
  }

  Color darken([int percent = 10]) {
    assert(1 <= percent && percent <= 100);
    final p = percent / 100;
    return Color.fromARGB(alpha, (red * (1 - p)).round(), (green * (1 - p)).round(), (blue * (1 - p)).round());
  }
}
