import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_web_portfolio/screens/home/home_screen.dart';
import '../config/constant/colors.dart';
import '../screens/about/about_screen.dart';

class NavBar extends StatefulWidget {
  final bool isMobile;
  final bool isDarkMode;
  final VoidCallback onThemeToggle;

  const NavBar({super.key, required this.isMobile, required this.isDarkMode, required this.onThemeToggle});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  String currentPath = "~/"; // Default path
  bool showCursor = true; // Blinking cursor flag

  @override
  void initState() {
    super.initState();
    _startCursorBlinking();
  }

  void _startCursorBlinking() {
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (mounted) {
        setState(() {
          showCursor = !showCursor;
        });
      } else {
        timer.cancel();
      }
    });
  }

  int _selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _navigateTo(BuildContext context, String path) {
    setState(() {
      switch (path) {
        case "":
          currentPath = "~/";
          _selectedIndex = 0;
          break;
        case "about":
          currentPath = "~/about";
          _selectedIndex = 1;
          break;
        case "uses":
          currentPath = "~/uses";
          _selectedIndex = 2;
          break;
        default:
          currentPath = "~/";
          _selectedIndex = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;

    // Define screens here to access the context and props directly
    final List<Widget> screens = [
      HomeScreenUI(isDarkMode: widget.isDarkMode, toggleTheme: widget.onThemeToggle),
      AboutScreenUI(isDarkMode: widget.isDarkMode, toggleTheme: widget.onThemeToggle),
    ];

    return Scaffold(
      body: Column(
        children: [
          // Custom NavBar (at the top)
          Padding(
            padding: EdgeInsets.only(top: isMobile ? 10 : 24, left: isMobile ? 10 : 350, right: isMobile ? 10 : 350),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: AppColors.grey, width: 1),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 2))],
              ),
              child: Row(
                children: [
                  // Left side: File Explorer Style Navigation
                  InkWell(
                    onTap: () => _navigateTo(context, ""), // Navigate to home on logo click
                    borderRadius: BorderRadius.circular(8),
                    child: Row(
                      children: [
                        // Apple Logo
                        Icon(Icons.apple, color: Theme.of(context).colorScheme.primary, size: 24),
                        const SizedBox(width: 8),

                        // Forward Arrow
                        Icon(Icons.arrow_forward, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7), size: 20),
                        const SizedBox(width: 8),

                        // Folder Icon
                        Icon(
                          Icons.folder,
                          color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                          size: 20,
                        ),
                        const SizedBox(width: 8),

                        // Dynamic Path Text
                        RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                            ),
                            children: [
                              TextSpan(text: currentPath),
                              WidgetSpan(
                                child: AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 300),
                                  child:
                                      showCursor
                                          ? Text(
                                            "|",
                                            key: ValueKey<bool>(showCursor),
                                            style: TextStyle(
                                              color:
                                                  Theme.of(context).brightness == Brightness.dark
                                                      ? Colors.white
                                                      : Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                          : const Text(""),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),
                  // Right side menu
                  Row(
                    children: [
                      if (!isMobile) ...[
                        TextButton(
                          onPressed: () => _navigateTo(context, "about"),
                          child: Text(
                            'About Me',
                            style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.bold),
                          ),
                        ),
                        // const SizedBox(width: 24),
                        // TextButton(
                        //   onPressed: () => _navigateTo(context, "uses"),
                        //   child: Text(
                        //     'Uses',
                        //     style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.bold),
                        //   ),
                        // ),
                        // const SizedBox(width: 24),
                      ],

                      // Dark mode toggle
                      IconButton(
                        icon: Icon(
                          widget.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        onPressed: widget.onThemeToggle,
                      ),

                      // Mobile menu button
                      if (isMobile)
                        IconButton(
                          icon: Icon(Icons.menu, color: Theme.of(context).colorScheme.onSurface),
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder:
                                  (context) => MobileMenu(
                                    onThemeToggle: widget.onThemeToggle,
                                    isDarkMode: widget.isDarkMode,
                                    onNavigate: (path) => _navigateTo(context, path),
                                  ),
                            );
                          },
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Add some consistent spacing between navbar and content
          // SizedBox(height: isMobile ? 16 : 24),

          // Screen Content takes remaining space
          Expanded(child: screens[_selectedIndex]),
        ],
      ),
    );
  }
}

// Mobile Menu Bottom Sheet
class MobileMenu extends StatelessWidget {
  final VoidCallback onThemeToggle;
  final bool isDarkMode;
  final Function(String) onNavigate;

  const MobileMenu({super.key, required this.onThemeToggle, required this.isDarkMode, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            onTap: () {
              Navigator.pop(context);
              onNavigate("about");
            },
          ),
          // ListTile(
          //   leading: const Icon(Icons.build),
          //   title: const Text('Uses'),
          //   onTap: () {
          //     Navigator.pop(context);
          //     onNavigate("uses");
          //   },
          // ),
          const Divider(),
          ListTile(
            leading: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            title: Text(isDarkMode ? 'Light Mode' : 'Dark Mode'),
            onTap: () {
              Navigator.pop(context);
              onThemeToggle();
            },
          ),
        ],
      ),
    );
  }
}
