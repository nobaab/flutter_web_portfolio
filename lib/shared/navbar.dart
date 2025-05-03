import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_web_portfolio/screens/home/home_screen.dart';
import 'package:flutter_web_portfolio/screens/about/about_screen.dart';
import 'package:flutter_web_portfolio/screens/projects/projects_screen.dart';
import '../config/constant/colors.dart';

class NavBar extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onThemeToggle;

  const NavBar({super.key, required this.isDarkMode, required this.onThemeToggle});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;
  String currentPath = "~/";
  bool showCursor = true;
  late final ScrollController _scrollController;
  late final Timer _cursorTimer;
  double navbarOpacity = 1.0;

  @override
  void initState() {
    super.initState();
    _scrollController =
        ScrollController()..addListener(() {
          final newOpacity = _scrollController.offset > 50 ? 0.9 : 1.0;
          if (navbarOpacity != newOpacity) {
            setState(() => navbarOpacity = newOpacity);
          }
        });
    _cursorTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (!mounted) {
        timer.cancel();
      } else {
        setState(() => showCursor = !showCursor);
      }
    });
  }

  @override
  void dispose() {
    _cursorTimer.cancel(); // Cancel the periodic timer to avoid leaks
    _scrollController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          currentPath = "~/";
          break;
        case 1:
          currentPath = "~/about";
          break;
        case 2:
          currentPath = "~/projects";
          break;
        default:
          currentPath = "~/";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 800;
    final List<Widget> screens = [
      HomeScreenUI(isDarkMode: widget.isDarkMode, toggleTheme: widget.onThemeToggle),
      AboutScreenUI(isDarkMode: widget.isDarkMode, toggleTheme: widget.onThemeToggle),
      ProjectScreenUI(isDarkMode: widget.isDarkMode, toggleTheme: widget.onThemeToggle),
    ];

    return Scaffold(
      drawer: isMobile ? Drawer(child: _buildDrawerMenu(context)) : null,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Center(
                child: Container(constraints: const BoxConstraints(maxWidth: 768), child: _buildNavBar(context, isMobile)),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 768,
              minHeight: MediaQuery.of(context).size.height - 60 - MediaQuery.of(context).padding.top,
            ),
            child: Padding(padding: EdgeInsets.symmetric(horizontal: isMobile ? 10 : 0), child: screens[_selectedIndex]),
          ),
        ),
      ),
    );
  }

  Widget _buildNavBar(BuildContext context, bool isMobile) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withValues(alpha: navbarOpacity),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.grey, width: 1),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 2))],
      ),
      child: Row(
        children: [
          _buildLogo(context),
          const Spacer(),
          if (!isMobile) _buildDesktopMenu(),
          IconButton(
            icon: Icon(
              widget.isDarkMode ? Icons.light_mode : Icons.dark_mode,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            onPressed: widget.onThemeToggle,
          ),
          if (isMobile)
            Builder(
              builder:
                  (ctx) => IconButton(
                    icon: Icon(Icons.menu, color: Theme.of(context).colorScheme.onSurface),
                    onPressed: () => Scaffold.of(ctx).openDrawer(),
                  ),
            ),
        ],
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    return InkWell(
      onTap: () => _onItemTapped(0),
      borderRadius: BorderRadius.circular(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.apple, color: Theme.of(context).colorScheme.primary, size: 24),
          const SizedBox(width: 8),
          Icon(Icons.arrow_forward, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7), size: 20),
          const SizedBox(width: 8),
          Icon(Icons.folder, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black, size: 20),
          const SizedBox(width: 8),
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
                              '|',
                              key: ValueKey<bool>(showCursor),
                              style: TextStyle(
                                color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                            : const Text(''),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopMenu() {
    return Row(children: [_navTextButton('Home', 0), _navTextButton('About', 1), _navTextButton('Projects', 2)]);
  }

  Widget _navTextButton(String label, int index) {
    return TextButton(
      onPressed: () => _onItemTapped(index),
      child: Text(label, style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildDrawerMenu(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // TODO: Could extract ListTiles to a reusable model for scalability
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
              _onItemTapped(0);
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            onTap: () {
              Navigator.pop(context);
              _onItemTapped(1);
            },
          ),
          ListTile(
            leading: const Icon(Icons.build),
            title: const Text('Projects'),
            onTap: () {
              Navigator.pop(context);
              _onItemTapped(2);
            },
          ),
          const Divider(),
          ListTile(
            leading: Icon(widget.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            title: Text(widget.isDarkMode ? 'Light Mode' : 'Dark Mode'),
            onTap: () {
              Navigator.pop(context);
              widget.onThemeToggle();
            },
          ),
        ],
      ),
    );
  }
}
