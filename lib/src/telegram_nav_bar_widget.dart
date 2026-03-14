import 'package:flutter/material.dart';

import '../telegram_nav_bar.dart';

/// Telegram-style bottom navigation bar with glassmorphic blur, animated
/// indicators, optional center button (FAB), and badge support.
class TelegramNavBar extends StatelessWidget {
  /// Creates a [TelegramNavBar].
  const TelegramNavBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
    this.backgroundColor,
    this.activeColor,
    this.inactiveColor,
    this.blurStrength,
    this.animationDuration,
    this.height,
    this.bubbleColor,
    this.iconSize,
    this.showTopDivider = true,
    this.topDividerColor,
    this.padding,
    this.margin,
    this.borderRadius,
    this.elevation,
    this.centerButton,
    this.centerButtonOffset = 0,
    this.enableHapticFeedback = true,
  })  : assert(items.length >= 2, 'TelegramNavBar requires at least 2 items'),
        assert(
          currentIndex >= 0 && currentIndex < items.length,
          'currentIndex must be between 0 and items.length - 1',
        );

  /// Navigation items to display.
  final List<TelegramNavItem> items;

  /// Index of the currently selected item.
  final int currentIndex;

  /// Callback when an item is tapped.
  final ValueChanged<int> onTap;

  /// Bar background color. Supports transparency for the glass effect.
  final Color? backgroundColor;

  /// Color for the selected item's icon and label.
  final Color? activeColor;

  /// Color for unselected items.
  final Color? inactiveColor;

  /// Gaussian blur sigma for the glassmorphic backdrop.
  final double? blurStrength;

  /// Duration of selection animations.
  final Duration? animationDuration;

  /// Bar height (excluding safe-area insets).
  final double? height;

  /// Fill color of the active item's pill indicator.
  final Color? bubbleColor;

  /// Icon size for all items.
  final double? iconSize;

  /// Whether to show a thin divider at the top of the bar.
  final bool showTopDivider;

  /// Color of the top divider line.
  final Color? topDividerColor;

  /// Inner padding. Use for floating style (e.g. `EdgeInsets.all(16)`).
  final EdgeInsetsGeometry? padding;

  /// Outer margin around the bar.
  final EdgeInsetsGeometry? margin;

  /// Border radius for floating/rounded style.
  final BorderRadius? borderRadius;

  /// Shadow intensity.
  final double? elevation;

  /// Optional widget placed in the center of the bar (e.g. a FAB).
  /// Items are split evenly on each side of the center button.
  final Widget? centerButton;

  /// How far the [centerButton] extends above the bar (in pixels).
  final double centerButtonOffset;

  /// Whether items trigger haptic feedback on tap.
  final bool enableHapticFeedback;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final bgColor = backgroundColor ??
        (isDark
            ? NavBarDefaults.darkBackground
            : NavBarDefaults.lightBackground);
    final activeClr = activeColor ?? NavBarDefaults.telegramBlue;
    final inactiveClr = inactiveColor ?? NavBarDefaults.inactiveGrey;
    final blur = blurStrength ?? NavBarDefaults.blurStrength;
    final duration = animationDuration ?? NavBarDefaults.animationDuration;
    final barHeight = height ?? NavBarDefaults.barHeight;
    final bubbleClr = bubbleColor ??
        (isDark
            ? NavBarDefaults.activeBubbleDark
            : NavBarDefaults.activeBubbleLight);
    final dividerClr = topDividerColor ??
        (isDark
            ? NavBarDefaults.topDividerDark
            : NavBarDefaults.topDividerLight);
    final shadowAlpha = elevation ?? (isDark ? 0.3 : 0.08);

    final hasCenterBtn = centerButton != null;
    final midIndex = hasCenterBtn ? items.length ~/ 2 : -1;

    Widget buildItem(int index) {
      return Expanded(
        child: NavItemWidget(
          item: items[index],
          isSelected: currentIndex == index,
          onTap: () => onTap(index),
          activeColor: activeClr,
          inactiveColor: inactiveClr,
          animationDuration: duration,
          bubbleColor: bubbleClr,
          iconSize: iconSize,
          enableHapticFeedback: enableHapticFeedback,
        ),
      );
    }

    final rowChildren = <Widget>[];
    if (hasCenterBtn) {
      for (int i = 0; i < midIndex; i++) {
        rowChildren.add(buildItem(i));
      }
      rowChildren.add(const Expanded(child: SizedBox.shrink()));
      for (int i = midIndex; i < items.length; i++) {
        rowChildren.add(buildItem(i));
      }
    } else {
      for (int i = 0; i < items.length; i++) {
        rowChildren.add(buildItem(i));
      }
    }

    Widget barContent = GlassContainer(
      backgroundColor: bgColor,
      blurStrength: blur,
      borderRadius: borderRadius,
      child: Container(
        height: barHeight,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: shadowAlpha),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showTopDivider)
              Container(
                height: NavBarDefaults.topDividerHeight,
                color: dividerClr,
              ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: rowChildren,
              ),
            ),
          ],
        ),
      ),
    );

    if (hasCenterBtn) {
      barContent = Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          barContent,
          Positioned(
            left: 0,
            right: 0,
            top: -centerButtonOffset,
            child: Center(child: centerButton!),
          ),
        ],
      );
    }

    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: padding ?? EdgeInsets.zero,
          child: barContent,
        ),
      ),
    );
  }
}
