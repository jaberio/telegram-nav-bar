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
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Rendering
  // ---------------------------------------------------------------------------

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
      // Profile is not selected → should show outline icon
      expect(find.byIcon(Icons.person_outline), findsOneWidget);
    });

    testWidgets('renders activeIcon when item is selected', (tester) async {
      // currentIndex = 2 → Profile should show filled icon
      await tester.pumpWidget(buildTestWidget(currentIndex: 2, onTap: (_) {}));

      expect(find.byIcon(Icons.person), findsOneWidget);
      // The outline variant should not be displayed
      expect(find.byIcon(Icons.person_outline), findsNothing);
    });

    testWidgets('renders top divider by default', (tester) async {
      await tester.pumpWidget(buildTestWidget(currentIndex: 0, onTap: (_) {}));

      // Find the divider container by its exact height
      final dividerFinder = find.byWidgetPredicate(
        (widget) =>
            widget is Container &&
            widget.constraints?.maxHeight == NavBarConstants.topDividerHeight,
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
            widget.constraints?.maxHeight == NavBarConstants.topDividerHeight,
      );
      expect(dividerFinder, findsNothing);
    });
  });

  // ---------------------------------------------------------------------------
  // Interaction
  // ---------------------------------------------------------------------------

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

  // ---------------------------------------------------------------------------
  // Selection state
  // ---------------------------------------------------------------------------

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

  // ---------------------------------------------------------------------------
  // Customisation
  // ---------------------------------------------------------------------------

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

      // Should still render all items without error
      expect(find.text('Home'), findsOneWidget);
      expect(find.byType(GlassContainer), findsOneWidget);
    });
  });

  // ---------------------------------------------------------------------------
  // Model
  // ---------------------------------------------------------------------------

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
  });
}
