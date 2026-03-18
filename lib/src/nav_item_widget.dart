import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../telegram_nav_bar.dart';

/// A single interactive navigation item with press animation and badge support.
class NavItemWidget extends StatefulWidget {
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
    this.enableHapticFeedback = true,
    this.liquidGlass = false,
    this.bubbleBorderColor,
  });

  /// The navigation item data.
  final TelegramNavItem item;

  /// Whether this item is currently selected.
  final bool isSelected;

  /// Callback when tapped.
  final VoidCallback onTap;

  /// Color when active.
  final Color activeColor;

  /// Color when inactive.
  final Color inactiveColor;

  /// Duration for selection animations.
  final Duration animationDuration;

  /// Bubble indicator color.
  final Color bubbleColor;

  /// Override icon size.
  final double? iconSize;

  /// Whether to trigger haptic feedback.
  final bool enableHapticFeedback;

  /// Whether the item uses Liquid Glass styling.
  final bool liquidGlass;

  /// Border color for the Liquid Glass bubble.
  final Color? bubbleBorderColor;

  @override
  State<NavItemWidget> createState() => _NavItemWidgetState();
}

class _NavItemWidgetState extends State<NavItemWidget> {
  bool _pressed = false;

  void _onTapDown(TapDownDetails _) => setState(() => _pressed = true);

  void _onTapUp(TapUpDetails _) {
    setState(() => _pressed = false);
    if (widget.enableHapticFeedback) HapticFeedback.selectionClick();
    widget.onTap();
  }

  void _onTapCancel() => setState(() => _pressed = false);

  @override
  Widget build(BuildContext context) {
    final color = widget.isSelected ? widget.activeColor : widget.inactiveColor;
    final iconSize = widget.iconSize ?? NavBarDefaults.iconSize;
    final displayIcon = widget.isSelected
        ? (widget.item.activeIcon ?? widget.item.icon)
        : widget.item.icon;

    final pressCurve =
        widget.liquidGlass ? Curves.easeOutCubic : Curves.easeOutCubic;
    final selectionCurve =
        widget.liquidGlass ? Curves.easeOutCubic : Curves.easeOutBack;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      behavior: HitTestBehavior.opaque,
      child: AnimatedScale(
        scale: _pressed ? NavBarDefaults.pressedScale : 1.0,
        duration: const Duration(milliseconds: 100),
        curve: pressCurve,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                AnimatedBubble(
                  isSelected: widget.isSelected,
                  animationDuration: widget.animationDuration,
                  color: widget.bubbleColor,
                  liquidGlass: widget.liquidGlass,
                  borderColor: widget.bubbleBorderColor,
                ),
                AnimatedScale(
                  scale: widget.isSelected
                      ? NavBarDefaults.activeIconScale
                      : 1.0,
                  duration: widget.animationDuration,
                  curve: selectionCurve,
                  child: TweenAnimationBuilder<Color?>(
                    tween: ColorTween(
                      begin: widget.inactiveColor,
                      end: color,
                    ),
                    duration: widget.animationDuration,
                    builder: (context, currentColor, _) {
                      return Icon(
                        displayIcon,
                        color: currentColor,
                        size: iconSize,
                      );
                    },
                  ),
                ),
                if (widget.item.hasBadge)
                  Positioned(
                    top: -4,
                    right: -8,
                    child: _BadgeIndicator(count: widget.item.badgeCount),
                  ),
              ],
            ),
            const SizedBox(height: NavBarDefaults.iconLabelGap),
            AnimatedDefaultTextStyle(
              duration: widget.animationDuration,
              curve: Curves.easeInOutCubic,
              style: TextStyle(
                color: color,
                fontSize: NavBarDefaults.labelFontSize,
                fontWeight:
                    widget.isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
              child: Text(
                widget.item.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BadgeIndicator extends StatelessWidget {
  const _BadgeIndicator({this.count});

  final int? count;

  @override
  Widget build(BuildContext context) {
    final hasCount = count != null && count! > 0;
    final label = hasCount ? (count! > 99 ? '99+' : '$count') : '';

    return Container(
      padding: hasCount
          ? const EdgeInsets.symmetric(horizontal: 5, vertical: 1)
          : EdgeInsets.zero,
      constraints: hasCount
          ? const BoxConstraints(minWidth: 16, minHeight: 16)
          : const BoxConstraints.tightFor(width: 8, height: 8),
      decoration: BoxDecoration(
        color: NavBarDefaults.badgeColor,
        borderRadius: BorderRadius.circular(hasCount ? 8 : 4),
      ),
      child: hasCount
          ? Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            )
          : null,
    );
  }
}
