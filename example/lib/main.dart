import 'package:flutter/material.dart';
import 'package:telegram_nav_bar/telegram_nav_bar.dart';

void main() {
  runApp(const ExampleApp());
}

/// Root application widget.
class ExampleApp extends StatelessWidget {
  /// Creates the [ExampleApp].
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Telegram Nav Bar Example',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF0F0F0),
        colorSchemeSeed: NavBarColors.telegramBlue,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212),
        colorSchemeSeed: NavBarColors.telegramBlue,
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

/// Main screen hosting the [TelegramNavBar] and page content.
class MainScreen extends StatefulWidget {
  /// Creates the [MainScreen].
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  static const _items = <TelegramNavItem>[
    TelegramNavItem(
      icon: Icons.chat_bubble_outline,
      activeIcon: Icons.chat_bubble,
      label: 'Chats',
    ),
    TelegramNavItem(
      icon: Icons.person_outline,
      activeIcon: Icons.person,
      label: 'Contacts',
    ),
    TelegramNavItem(
      icon: Icons.call_outlined,
      activeIcon: Icons.call,
      label: 'Calls',
    ),
    TelegramNavItem(
      icon: Icons.settings_outlined,
      activeIcon: Icons.settings,
      label: 'Settings',
    ),
  ];

  static const _pages = <Widget>[
    _DemoPage(
      title: 'Chats',
      icon: Icons.chat_bubble_outline,
      color: NavBarColors.telegramBlue,
    ),
    _DemoPage(
      title: 'Contacts',
      icon: Icons.person_outline,
      color: Colors.blueAccent,
    ),
    _DemoPage(
      title: 'Calls',
      icon: Icons.call_outlined,
      color: Colors.green,
    ),
    _DemoPage(
      title: 'Settings',
      icon: Icons.settings_outlined,
      color: Colors.orange,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Option A: use as bottomNavigationBar directly
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: TelegramNavBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: _items,
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Demo page used to populate each tab with scrollable content.
// ---------------------------------------------------------------------------

class _DemoPage extends StatelessWidget {
  const _DemoPage({
    required this.title,
    required this.icon,
    required this.color,
  });

  final String title;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 80, bottom: 100, left: 16, right: 16),
      itemCount: 20,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Column(
              children: [
                Icon(icon, size: 80, color: color),
                const SizedBox(height: 16),
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Scroll down to see the glassmorphic effect!',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          );
        }
        return Container(
          height: 80,
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: color.withAlpha((255 * (0.1 + (index % 5) * 0.05)).toInt()),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              'Item $index',
              style: TextStyle(color: color, fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }
}
