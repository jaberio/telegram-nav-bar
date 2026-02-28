import 'package:flutter/material.dart';

import '../../../telegram_nav_bar.dart';

/// The main Telegram-style bottom navigation bar widget.
///
/// Replicates the latest Telegram "Liquid Glass" bottom navigation bar
/// with a translucent glass background, smooth blur effect, a thin top
/// divider, and animated pill-shaped selection indicators.
///
/// ## Usage
///
/// Place it as the `bottomNavigationBar` of a [Scaffold] or position it
/// at the bottom of a [Stack]:
///
/// ```dart
/// Scaffold(
///   body: _pages[_currentIndex],
///   bottomNavigationBar: TelegramNavBar(
///     currentIndex: _currentIndex,
///     onTap: (index) => setState(() => _currentIndex = index),
///     items: const [
///       TelegramNavItem(icon: Icons.chat_bubble_outline, label: 'Chats'),
///       TelegramNavItem(icon: Icons.person_outline, label: 'Contacts'),
///       TelegramNavItem(icon: Icons.settings_outlined, label: 'Settings'),
///     ],
///   ),
/// )
/// ```
class TelegramNavBar extends StatelessWidget {
  /// Creates a [TelegramNavBar].
  ///
  /// The [items] list must contain at least 2 items.
  /// The [currentIndex] must be a valid index into [items].
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
  })  : assert(items.length >= 2, 'TelegramNavBar requires at least 2 items'),
        assert(
          currentIndex >= 0 && currentIndex < items.length,
          'currentIndex must be between 0 and items.length - 1',
        );

  /// The list of navigation items to display.
  final List<TelegramNavItem> items;

  /// The index of the currently selected item.
  final int currentIndex;

  /// Callback invoked when an item is tapped, providing the new index.
  final ValueChanged<int> onTap;

  /// The bar's background color. Supports transparency for the glass effect.
  ///
  /// Defaults to a theme-aware color based on brightness.
  final Color? backgroundColor;

  /// Color used for the selected item's icon and label.
  ///
  /// Defaults to [NavBarColors.telegramBlue].
  final Color? activeColor;

  /// Color used for unselected items' icon and label.
  ///
  /// Defaults to [NavBarColors.inactiveGrey].
  final Color? inactiveColor;

  /// The Gaussian blur sigma for the glassmorphic backdrop.
  ///
  /// Defaults to [NavBarConstants.defaultBlurStrength].
  final double? blurStrength;

  /// Duration of item selection animations.
  ///
  /// Defaults to [NavBarConstants.defaultAnimationDuration].
  final Duration? animationDuration;

  /// Height of the navigation bar (excluding safe-area insets).
  ///
  /// Defaults to [NavBarConstants.defaultBarHeight].
  final double? height;

  /// Fill color of the active item's pill indicator bubble.
  ///
  /// When `null`, a theme-aware default is chosen automatically.
  final Color? bubbleColor;

  /// Override the default icon size for all items.
  final double? iconSize;

  /// Whether to render a thin divider line at the top of the bar.
  ///
  /// Defaults to `true`, matching Telegram's native design.
  final bool showTopDivider;

  /// Color of the top divider line.
  ///
  /// When `null`, a theme-aware default is chosen automatically.
  final Color? topDividerColor;

  /// Outer padding around the bar. Set to [EdgeInsets.zero] for
  /// edge-to-edge appearance (default Telegram style) or add padding
  /// for a floating look.
  final EdgeInsetsGeometry? padding;

  /// Outer margin around the bar.
  final EdgeInsetsGeometry? margin;

  /// Border radius of the bar container.
  ///
  /// Defaults to `null` (rectangular / edge-to-edge). Set a value for
  /// a floating, rounded bar style.
  final BorderRadius? borderRadius;

  /// Elevation / shadow intensity. Defaults to a subtle shadow.
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Resolve all nullable properties with sensible defaults.
    final resolvedBgColor = backgroundColor ??
        (isDark ? NavBarColors.darkBackground : NavBarColors.lightBackground);
    final resolvedActiveColor = activeColor ?? NavBarColors.telegramBlue;
    final resolvedInactiveColor = inactiveColor ?? NavBarColors.inactiveGrey;
    final resolvedBlur = blurStrength ?? NavBarConstants.defaultBlurStrength;
    final resolvedDuration =
        animationDuration ?? NavBarConstants.defaultAnimationDuration;
    final resolvedHeight = height ?? NavBarConstants.defaultBarHeight;
    final resolvedBubbleColor = bubbleColor ??
        (isDark
            ? NavBarColors.activeBubbleDark
            : NavBarColors.activeBubbleLight);
    final resolvedDividerColor = topDividerColor ??
        (isDark ? NavBarColors.topDividerDark : NavBarColors.topDividerLight);
    final resolvedElevation = elevation ?? (isDark ? 0.3 : 0.08);

    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: padding ?? EdgeInsets.zero,
          child: GlassContainer(
            backgroundColor: resolvedBgColor,
            blurStrength: resolvedBlur,
            borderRadius: borderRadius,
            child: Container(
              height: resolvedHeight,
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: resolvedElevation),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Top divider line
                  if (showTopDivider)
                    Container(
                      height: NavBarConstants.topDividerHeight,
                      color: resolvedDividerColor,
                    ),

                  // Navigation items row
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(items.length, (index) {
                        return Expanded(
                          child: NavItemWidget(
                            item: items[index],
                            isSelected: currentIndex == index,
                            onTap: () => onTap(index),
                            activeColor: resolvedActiveColor,
                            inactiveColor: resolvedInactiveColor,
                            animationDuration: resolvedDuration,
                            bubbleColor: resolvedBubbleColor,
                            iconSize: iconSize,
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
