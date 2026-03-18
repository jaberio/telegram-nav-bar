import 'package:flutter/material.dart';
import 'package:telegram_nav_bar/telegram_nav_bar.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
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
        colorSchemeSeed: NavBarDefaults.telegramBlue,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212),
        colorSchemeSeed: NavBarDefaults.telegramBlue,
        useMaterial3: true,
      ),
      home: const DemoSelector(),
    );
  }
}

/// Top-level screen that lets you pick which nav bar style to preview.
class DemoSelector extends StatefulWidget {
  const DemoSelector({super.key});

  @override
  State<DemoSelector> createState() => _DemoSelectorState();
}

class _DemoSelectorState extends State<DemoSelector> {
  final int _selected = 0;

  static const _demos = [
    'Default',
    'Floating',
    'Center FAB',
    'Badges',
    'Liquid Glass',
    'Liquid Glass Tinted',
    'Liquid Glass + FAB',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Telegram Nav Bar Demos')),
      body: ListView.separated(
        padding: const EdgeInsets.all(24),
        itemCount: _demos.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final isSelected = _selected == index;
          return FilledButton.tonal(
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 20),
              backgroundColor:
                  isSelected ? NavBarDefaults.telegramBlue.withAlpha(40) : null,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => _demoScreen(index)),
              );
            },
            child: Text(
              _demos[index],
              style: const TextStyle(fontSize: 16),
            ),
          );
        },
      ),
    );
  }

  Widget _demoScreen(int index) => switch (index) {
        0 => const DefaultDemo(),
        1 => const FloatingDemo(),
        2 => const CenterFabDemo(),
        3 => const BadgesDemo(),
        4 => const LiquidGlassDemo(),
        5 => const LiquidGlassTintedDemo(),
        6 => const LiquidGlassFabDemo(),
        _ => const DefaultDemo(),
      };
}

// ---------------------------------------------------------------------------
// Demo 1: Default Telegram style (edge-to-edge)
// ---------------------------------------------------------------------------

class DefaultDemo extends StatefulWidget {
  const DefaultDemo({super.key});

  @override
  State<DefaultDemo> createState() => _DefaultDemoState();
}

class _DefaultDemoState extends State<DefaultDemo> {
  int _index = 0;

  static const _items = [
    TelegramNavItem(
        icon: Icons.chat_bubble_outline,
        activeIcon: Icons.chat_bubble,
        label: 'Chats'),
    TelegramNavItem(
        icon: Icons.person_outline,
        activeIcon: Icons.person,
        label: 'Contacts'),
    TelegramNavItem(
        icon: Icons.call_outlined, activeIcon: Icons.call, label: 'Calls'),
    TelegramNavItem(
        icon: Icons.settings_outlined,
        activeIcon: Icons.settings,
        label: 'Settings'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Default Style')),
      body: _PageContent(label: _items[_index].label),
      bottomNavigationBar: TelegramNavBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        items: _items,
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Demo 2: Floating / rounded style
// ---------------------------------------------------------------------------

class FloatingDemo extends StatefulWidget {
  const FloatingDemo({super.key});

  @override
  State<FloatingDemo> createState() => _FloatingDemoState();
}

class _FloatingDemoState extends State<FloatingDemo> {
  int _index = 0;

  static const _items = [
    TelegramNavItem(
        icon: Icons.home_outlined, activeIcon: Icons.home, label: 'Home'),
    TelegramNavItem(icon: Icons.search, label: 'Search'),
    TelegramNavItem(
        icon: Icons.favorite_outline,
        activeIcon: Icons.favorite,
        label: 'Favorites'),
    TelegramNavItem(
        icon: Icons.person_outline, activeIcon: Icons.person, label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Floating Style')),
      body: _PageContent(label: _items[_index].label),
      bottomNavigationBar: TelegramNavBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        items: _items,
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        borderRadius: BorderRadius.circular(32),
        showTopDivider: false,
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Demo 3: Center FAB button
// ---------------------------------------------------------------------------

class CenterFabDemo extends StatefulWidget {
  const CenterFabDemo({super.key});

  @override
  State<CenterFabDemo> createState() => _CenterFabDemoState();
}

class _CenterFabDemoState extends State<CenterFabDemo> {
  int _index = 0;

  static const _items = [
    TelegramNavItem(
        icon: Icons.chat_bubble_outline,
        activeIcon: Icons.chat_bubble,
        label: 'Chats'),
    TelegramNavItem(icon: Icons.search, label: 'Search'),
    TelegramNavItem(
        icon: Icons.call_outlined, activeIcon: Icons.call, label: 'Calls'),
    TelegramNavItem(
        icon: Icons.settings_outlined,
        activeIcon: Icons.settings,
        label: 'Settings'),
  ];

  void _onFabTap() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('FAB tapped!'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Center FAB')),
      body: _PageContent(label: _items[_index].label),
      bottomNavigationBar: TelegramNavBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        items: _items,
        centerButton: GestureDetector(
          onTap: _onFabTap,
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: NavBarDefaults.telegramBlue,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: NavBarDefaults.telegramBlue.withAlpha(80),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(Icons.add, color: Colors.white, size: 28),
          ),
        ),
        centerButtonOffset: 24,
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Demo 4: With badges
// ---------------------------------------------------------------------------

class BadgesDemo extends StatefulWidget {
  const BadgesDemo({super.key});

  @override
  State<BadgesDemo> createState() => _BadgesDemoState();
}

class _BadgesDemoState extends State<BadgesDemo> {
  int _index = 0;

  static const _items = [
    TelegramNavItem(
      icon: Icons.chat_bubble_outline,
      activeIcon: Icons.chat_bubble,
      label: 'Chats',
      badgeCount: 12,
    ),
    TelegramNavItem(
      icon: Icons.person_outline,
      activeIcon: Icons.person,
      label: 'Contacts',
      showBadge: true,
    ),
    TelegramNavItem(
      icon: Icons.call_outlined,
      activeIcon: Icons.call,
      label: 'Calls',
      badgeCount: 3,
    ),
    TelegramNavItem(
      icon: Icons.settings_outlined,
      activeIcon: Icons.settings,
      label: 'Settings',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('With Badges')),
      body: _PageContent(label: _items[_index].label),
      bottomNavigationBar: TelegramNavBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        items: _items,
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Demo 5: Liquid Glass (standard)
// ---------------------------------------------------------------------------

class LiquidGlassDemo extends StatefulWidget {
  const LiquidGlassDemo({super.key});

  @override
  State<LiquidGlassDemo> createState() => _LiquidGlassDemoState();
}

class _LiquidGlassDemoState extends State<LiquidGlassDemo> {
  int _index = 0;

  static const _items = [
    TelegramNavItem(
      icon: Icons.chat_bubble_outline,
      activeIcon: Icons.chat_bubble,
      label: 'Chats',
      badgeCount: 5,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Liquid Glass')),
      body: _PageContent(label: _items[_index].label),
      bottomNavigationBar: TelegramNavBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        items: _items,
        liquidGlassStyle: LiquidGlassStyle.standard(),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Demo 6: Liquid Glass with custom tint
// ---------------------------------------------------------------------------

class LiquidGlassTintedDemo extends StatefulWidget {
  const LiquidGlassTintedDemo({super.key});

  @override
  State<LiquidGlassTintedDemo> createState() => _LiquidGlassTintedDemoState();
}

class _LiquidGlassTintedDemoState extends State<LiquidGlassTintedDemo> {
  int _index = 0;

  static const _items = [
    TelegramNavItem(
      icon: Icons.home_outlined,
      activeIcon: Icons.home,
      label: 'Home',
    ),
    TelegramNavItem(
      icon: Icons.explore_outlined,
      activeIcon: Icons.explore,
      label: 'Explore',
    ),
    TelegramNavItem(
      icon: Icons.bookmark_outline,
      activeIcon: Icons.bookmark,
      label: 'Saved',
      showBadge: true,
    ),
    TelegramNavItem(
      icon: Icons.person_outline,
      activeIcon: Icons.person,
      label: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Liquid Glass Tinted')),
      body: _PageContent(label: _items[_index].label),
      bottomNavigationBar: TelegramNavBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        items: _items,
        liquidGlassStyle: const LiquidGlassStyle(
          tintColor: Color(0xFF2AABEE),
          tintOpacity: 0.08,
          borderColor: Color(0x442AABEE),
          shadowBlurRadius: 24,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Demo 7: Liquid Glass + Center FAB
// ---------------------------------------------------------------------------

class LiquidGlassFabDemo extends StatefulWidget {
  const LiquidGlassFabDemo({super.key});

  @override
  State<LiquidGlassFabDemo> createState() => _LiquidGlassFabDemoState();
}

class _LiquidGlassFabDemoState extends State<LiquidGlassFabDemo> {
  int _index = 0;

  static const _items = [
    TelegramNavItem(
      icon: Icons.chat_bubble_outline,
      activeIcon: Icons.chat_bubble,
      label: 'Chats',
      badgeCount: 8,
    ),
    TelegramNavItem(
      icon: Icons.search,
      label: 'Search',
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

  void _onFabTap() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('FAB tapped!'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Liquid Glass + FAB')),
      body: _PageContent(label: _items[_index].label),
      bottomNavigationBar: TelegramNavBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        items: _items,
        liquidGlassStyle: LiquidGlassStyle.standard(),
        centerButton: GestureDetector(
          onTap: _onFabTap,
          child: Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: NavBarDefaults.telegramBlue,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: NavBarDefaults.telegramBlue.withAlpha(100),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(Icons.edit, color: Colors.white, size: 24),
          ),
        ),
        centerButtonOffset: 22,
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Shared page content
// ---------------------------------------------------------------------------

class _PageContent extends StatelessWidget {
  const _PageContent({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 24, bottom: 100, left: 16, right: 16),
      itemCount: 20,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Center(
              child: Text(
                label,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: NavBarDefaults.telegramBlue,
                    ),
              ),
            ),
          );
        }
        return Container(
          height: 72,
          margin: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            color: NavBarDefaults.telegramBlue
                .withAlpha((255 * (0.05 + (index % 5) * 0.03)).toInt()),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              'Item $index',
              style: TextStyle(
                color: NavBarDefaults.telegramBlue,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      },
    );
  }
}
