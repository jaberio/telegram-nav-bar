import 'package:flutter/widgets.dart';

import '../telegram_nav_bar.dart';
import 'nav_bar_defaults.dart';

/// Animated pill-shaped indicator that pops in when selected.
///
/// When [liquidGlass] is true the bubble uses a gradient fill with a subtle
/// border glow instead of a flat color, matching the Liquid Glass aesthetic.
class AnimatedBubble extends StatelessWidget {
  /// Creates an [AnimatedBubble].
  const AnimatedBubble({
    super.key,
    required this.isSelected,
    required this.animationDuration,
    required this.color,
    this.liquidGlass = false,
    this.borderColor,
    this.width,
    this.height,
    this.borderRadius,
  });

  /// Whether the bubble is expanded.
  final bool isSelected;

  /// Duration of the expand/collapse animation.
  final Duration animationDuration;

  /// Fill color of the bubble.
  final Color color;

  /// Enable Liquid Glass gradient & glow style.
  final bool liquidGlass;

  /// Border color when [liquidGlass] is true.
  final Color? borderColor;

  /// Custom bubble width.
  final double? width;

  /// Custom bubble height.
  final double? height;

  /// Custom border radius.
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    final w = width ?? NavBarDefaults.bubbleWidth;
    final h = height ?? NavBarDefaults.bubbleHeight;
    final r = borderRadius ?? NavBarDefaults.bubbleBorderRadius;

    return AnimatedScale(
      scale: isSelected ? 1.0 : 0.0,
      duration: animationDuration,
      curve: liquidGlass ? Curves.easeOutCubic : Curves.easeOutBack,
      child: AnimatedOpacity(
        opacity: isSelected ? 1.0 : 0.0,
        duration: animationDuration,
        curve: Curves.easeOut,
        child: Container(
          width: w,
          height: h,
          decoration: liquidGlass
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(r),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      color,
                      color.withAlpha((color.a * 0.5).round()),
                    ],
                  ),
                  border: borderColor != null
                      ? Border.all(color: borderColor!, width: 0.5)
                      : null,
                  boxShadow: [
                    BoxShadow(
                      color: color.withAlpha((color.a * 0.4).round()),
                      blurRadius: 8,
                      spreadRadius: 0,
                    ),
                  ],
                )
              : BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(r),
                ),
        ),
      ),
    );
  }
}
