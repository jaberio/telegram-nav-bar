import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:telegram_nav_bar/telegram_nav_bar.dart';

void main() {
  const testItems = <TelegramNavItem>[
    TelegramNavItem(icon: Icons.home, label: 'Home'),
    TelegramNavItem(icon: Icons.search, label: 'Search'),
    TelegramNavItem(
      icon: Icons.person_outline,
      activeIcon: Icons.person,
      label: 'Profile',
    ),
  ];

  Widget buildTestWidget({
    required int currentIndex,
    required ValueChanged<int> onTap,
    Color? activeColor,
    Color? inactiveColor,
    Duration? animationDuration,
    bool showTopDivider = true,
    Brightness brightness = Brightness.light,
    Widget? centerButton,
    double centerButtonOffset = 0,
    LiquidGlassStyle? liquidGlassStyle,
  }) {
    return MaterialApp(
      theme: ThemeData(brightness: brightness),
      home: Scaffold(
        bottomNavigationBar: TelegramNavBar(
          items: testItems,
          currentIndex: currentIndex,
          onTap: onTap,
          activeColor: activeColor,
          inactiveColor: inactiveColor,
          animationDuration: animationDuration,
          showTopDivider: showTopDivider,
          centerButton: centerButton,
          centerButtonOffset: centerButtonOffset,
          liquidGlassStyle: liquidGlassStyle,
        ),
      ),
    );
  }

  group('Rendering', () {
    testWidgets('renders all navigation item labels', (tester) async {
      await tester.pumpWidget(buildTestWidget(currentIndex: 0, onTap: (_) {}));

      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Search'), findsOneWidget);
      expect(find.text('Profile'), findsOneWidget);
    });

    testWidgets('renders all navigation item icons', (tester) async {
      await tester.pumpWidget(buildTestWidget(currentIndex: 0, onTap: (_) {}));

      expect(find.byIcon(Icons.home), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byIcon(Icons.person_outline), findsOneWidget);
    });

    testWidgets('renders activeIcon when item is selected', (tester) async {
      await tester.pumpWidget(buildTestWidget(currentIndex: 2, onTap: (_) {}));

      expect(find.byIcon(Icons.person), findsOneWidget);
      expect(find.byIcon(Icons.person_outline), findsNothing);
    });

    testWidgets('renders top divider by default', (tester) async {
      await tester.pumpWidget(buildTestWidget(currentIndex: 0, onTap: (_) {}));

      final dividerFinder = find.byWidgetPredicate(
        (widget) =>
            widget is Container &&
            widget.constraints?.maxHeight == NavBarDefaults.topDividerHeight,
      );
      expect(dividerFinder, findsOneWidget);
    });

    testWidgets('hides top divider when showTopDivider is false',
        (tester) async {
      await tester.pumpWidget(buildTestWidget(
        currentIndex: 0,
        onTap: (_) {},
        showTopDivider: false,
      ));

      final dividerFinder = find.byWidgetPredicate(
        (widget) =>
            widget is Container &&
            widget.constraints?.maxHeight == NavBarDefaults.topDividerHeight,
      );
      expect(dividerFinder, findsNothing);
    });
  });

  group('Interaction', () {
    testWidgets('tapping an item calls onTap with the correct index',
        (tester) async {
      int tappedIndex = -1;

      await tester.pumpWidget(buildTestWidget(
        currentIndex: 0,
        onTap: (index) => tappedIndex = index,
      ));

      await tester.tap(find.text('Search'));
      await tester.pumpAndSettle();
      expect(tappedIndex, 1);

      await tester.tap(find.text('Profile'));
      await tester.pumpAndSettle();
      expect(tappedIndex, 2);
    });
  });

  group('Selection state', () {
    testWidgets('NavItemWidget receives correct isSelected value',
        (tester) async {
      await tester.pumpWidget(buildTestWidget(currentIndex: 0, onTap: (_) {}));

      final widgets =
          tester.widgetList<NavItemWidget>(find.byType(NavItemWidget)).toList();

      expect(widgets[0].isSelected, true);
      expect(widgets[1].isSelected, false);
      expect(widgets[2].isSelected, false);
    });
  });

  group('Customisation', () {
    testWidgets('applies custom active and inactive colors', (tester) async {
      const customActive = Colors.red;
      const customInactive = Colors.green;

      await tester.pumpWidget(buildTestWidget(
        currentIndex: 0,
        onTap: (_) {},
        activeColor: customActive,
        inactiveColor: customInactive,
      ));

      final widgets =
          tester.widgetList<NavItemWidget>(find.byType(NavItemWidget)).toList();

      expect(widgets[0].activeColor, customActive);
      expect(widgets[1].inactiveColor, customInactive);
    });

    testWidgets('applies custom animation duration', (tester) async {
      const customDuration = Duration(milliseconds: 500);

      await tester.pumpWidget(buildTestWidget(
        currentIndex: 0,
        onTap: (_) {},
        animationDuration: customDuration,
      ));

      final widget =
          tester.widget<NavItemWidget>(find.byType(NavItemWidget).first);
      expect(widget.animationDuration, customDuration);
    });

    testWidgets('renders correctly in dark mode', (tester) async {
      await tester.pumpWidget(buildTestWidget(
        currentIndex: 0,
        onTap: (_) {},
        brightness: Brightness.dark,
      ));

      expect(find.text('Home'), findsOneWidget);
      expect(find.byType(GlassContainer), findsOneWidget);
    });
  });

  group('Center button', () {
    testWidgets('renders center button when provided', (tester) async {
      await tester.pumpWidget(buildTestWidget(
        currentIndex: 0,
        onTap: (_) {},
        centerButton: const Icon(Icons.add, key: Key('fab')),
        centerButtonOffset: 20,
      ));

      expect(find.byKey(const Key('fab')), findsOneWidget);
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Profile'), findsOneWidget);
    });
  });

  group('Badges', () {
    testWidgets('renders badge count on item', (tester) async {
      const badgeItems = <TelegramNavItem>[
        TelegramNavItem(icon: Icons.home, label: 'Home', badgeCount: 5),
        TelegramNavItem(icon: Icons.search, label: 'Search'),
      ];

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          bottomNavigationBar: TelegramNavBar(
            items: badgeItems,
            currentIndex: 0,
            onTap: (_) {},
          ),
        ),
      ));

      expect(find.text('5'), findsOneWidget);
    });

    testWidgets('renders badge dot when showBadge is true', (tester) async {
      const badgeItems = <TelegramNavItem>[
        TelegramNavItem(icon: Icons.home, label: 'Home', showBadge: true),
        TelegramNavItem(icon: Icons.search, label: 'Search'),
      ];

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          bottomNavigationBar: TelegramNavBar(
            items: badgeItems,
            currentIndex: 0,
            onTap: (_) {},
          ),
        ),
      ));

      // Badge dot should appear (8x8 container)
      final badgeFinder = find.byWidgetPredicate(
        (widget) =>
            widget is Container &&
            widget.constraints != null &&
            widget.constraints!.maxWidth == 8,
      );
      expect(badgeFinder, findsOneWidget);
    });
  });

  group('TelegramNavItem', () {
    test('equality works correctly', () {
      const a = TelegramNavItem(icon: Icons.home, label: 'Home');
      const b = TelegramNavItem(icon: Icons.home, label: 'Home');
      const c = TelegramNavItem(icon: Icons.search, label: 'Search');

      expect(a, equals(b));
      expect(a, isNot(equals(c)));
      expect(a.hashCode, b.hashCode);
    });

    test('toString returns readable output', () {
      const item = TelegramNavItem(icon: Icons.home, label: 'Home');
      expect(item.toString(), contains('TelegramNavItem'));
      expect(item.toString(), contains('Home'));
    });

    test('hasBadge returns true for badgeCount > 0', () {
      const item =
          TelegramNavItem(icon: Icons.home, label: 'Home', badgeCount: 3);
      expect(item.hasBadge, isTrue);
    });

    test('hasBadge returns true for showBadge', () {
      const item =
          TelegramNavItem(icon: Icons.home, label: 'Home', showBadge: true);
      expect(item.hasBadge, isTrue);
    });

    test('hasBadge returns false by default', () {
      const item = TelegramNavItem(icon: Icons.home, label: 'Home');
      expect(item.hasBadge, isFalse);
    });
  });

  group('Liquid Glass', () {
    testWidgets('renders with LiquidGlassStyle.standard()', (tester) async {
      await tester.pumpWidget(buildTestWidget(
        currentIndex: 0,
        onTap: (_) {},
        liquidGlassStyle: LiquidGlassStyle.standard(),
      ));

      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Search'), findsOneWidget);
      expect(find.text('Profile'), findsOneWidget);
      expect(find.byType(GlassContainer), findsOneWidget);
    });

    testWidgets('hides top divider in liquid glass mode', (tester) async {
      await tester.pumpWidget(buildTestWidget(
        currentIndex: 0,
        onTap: (_) {},
        liquidGlassStyle: LiquidGlassStyle.standard(),
      ));

      final dividerFinder = find.byWidgetPredicate(
        (widget) =>
            widget is Container &&
            widget.constraints?.maxHeight == NavBarDefaults.topDividerHeight,
      );
      expect(dividerFinder, findsNothing);
    });

    testWidgets('passes liquidGlass flag to NavItemWidget', (tester) async {
      await tester.pumpWidget(buildTestWidget(
        currentIndex: 0,
        onTap: (_) {},
        liquidGlassStyle: LiquidGlassStyle.standard(),
      ));

      final widgets =
          tester.widgetList<NavItemWidget>(find.byType(NavItemWidget)).toList();

      expect(widgets[0].liquidGlass, isTrue);
      expect(widgets[1].liquidGlass, isTrue);
    });

    testWidgets('tapping works in liquid glass mode', (tester) async {
      int tappedIndex = -1;

      await tester.pumpWidget(buildTestWidget(
        currentIndex: 0,
        onTap: (index) => tappedIndex = index,
        liquidGlassStyle: LiquidGlassStyle.standard(),
      ));

      await tester.tap(find.text('Search'));
      await tester.pumpAndSettle();
      expect(tappedIndex, 1);
    });

    testWidgets('renders in dark mode with liquid glass', (tester) async {
      await tester.pumpWidget(buildTestWidget(
        currentIndex: 0,
        onTap: (_) {},
        brightness: Brightness.dark,
        liquidGlassStyle: LiquidGlassStyle.standard(),
      ));

      expect(find.text('Home'), findsOneWidget);
      expect(find.byType(GlassContainer), findsOneWidget);
    });

    testWidgets('applies custom tint in liquid glass', (tester) async {
      await tester.pumpWidget(buildTestWidget(
        currentIndex: 1,
        onTap: (_) {},
        liquidGlassStyle: const LiquidGlassStyle(
          tintColor: Colors.purple,
          tintOpacity: 0.1,
          borderColor: Colors.purpleAccent,
        ),
      ));

      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Search'), findsOneWidget);

      final widgets =
          tester.widgetList<NavItemWidget>(find.byType(NavItemWidget)).toList();
      expect(widgets[0].isSelected, false);
      expect(widgets[1].isSelected, true);
    });

    testWidgets('center button works with liquid glass', (tester) async {
      await tester.pumpWidget(buildTestWidget(
        currentIndex: 0,
        onTap: (_) {},
        liquidGlassStyle: LiquidGlassStyle.standard(),
        centerButton: const Icon(Icons.add, key: Key('lg_fab')),
        centerButtonOffset: 20,
      ));

      expect(find.byKey(const Key('lg_fab')), findsOneWidget);
      expect(find.text('Home'), findsOneWidget);
    });
  });

  group('LiquidGlassStyle', () {
    test('standard() creates instance with null overrides', () {
      final style = LiquidGlassStyle.standard();
      expect(style.blurStrength, isNull);
      expect(style.backgroundColor, isNull);
      expect(style.borderColor, isNull);
      expect(style.tintColor, isNull);
    });

    test('custom values are preserved', () {
      const style = LiquidGlassStyle(
        blurStrength: 40,
        tintColor: Colors.blue,
        tintOpacity: 0.2,
        borderWidth: 2.0,
      );
      expect(style.blurStrength, 40);
      expect(style.tintColor, Colors.blue);
      expect(style.tintOpacity, 0.2);
      expect(style.borderWidth, 2.0);
    });
  });
}
