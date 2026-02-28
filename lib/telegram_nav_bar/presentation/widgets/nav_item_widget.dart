import 'package:flutter/widgets.dart';

import '../../../telegram_nav_bar.dart';

/// A single interactive navigation item representing one tab in the
/// [TelegramNavBar].
///
/// Renders an icon (with optional separate [TelegramNavItem.activeIcon]),
/// an animated pill-shaped [AnimatedBubble], and a text label.
class NavItemWidget extends StatelessWidget {
  /// Creates a [NavItemWidget].
  const NavItemWidget({
    super.key,
    required this.item,
    required this.isSelected,
    required this.onTap,
    required this.activeColor,
    required this.inactiveColor,
    required this.animationDuration,
    required this.bubbleColor,
    this.iconSize,
  });

  /// The navigation item data (icon, activeIcon, label).
  final TelegramNavItem item;

  /// Whether this item is currently selected.
  final bool isSelected;

  /// Callback invoked when this item is tapped.
  final VoidCallback onTap;

  /// Color used for the icon and label when active.
  final Color activeColor;

  /// Color used for the icon and label when inactive.
  final Color inactiveColor;

  /// Duration for all selection animations.
  final Duration animationDuration;

  /// Fill color for the animated bubble indicator.
  final Color bubbleColor;

  /// Override the default icon size.
  ///
  /// Defaults to [NavBarConstants.defaultIconSize].
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? activeColor : inactiveColor;
    final resolvedIconSize = iconSize ?? NavBarConstants.defaultIconSize;
    final displayIcon = isSelected ? (item.activeIcon ?? item.icon) : item.icon;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              AnimatedBubble(
                isSelected: isSelected,
                animationDuration: animationDuration,
                color: bubbleColor,
              ),
              AnimatedScale(
                scale: isSelected ? NavBarConstants.activeIconScale : 1.0,
                duration: animationDuration,
                curve: Curves.easeOutBack,
                child: TweenAnimationBuilder<Color?>(
                  tween: ColorTween(begin: inactiveColor, end: color),
                  duration: animationDuration,
                  builder: (context, currentColor, child) {
                    return Icon(
                      displayIcon,
                      color: currentColor,
                      size: resolvedIconSize,
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: NavBarConstants.iconLabelGap),
          AnimatedDefaultTextStyle(
            duration: animationDuration,
            style: TextStyle(
              color: color,
              fontSize: NavBarConstants.defaultLabelFontSize,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
            curve: Curves.easeInOutCubic,
            child: Text(
              item.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
