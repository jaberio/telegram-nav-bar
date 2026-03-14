import 'package:flutter/widgets.dart';

import '../telegram_nav_bar.dart';
import 'nav_bar_defaults.dart';

/// Animated pill-shaped indicator that pops in when selected.
class AnimatedBubble extends StatelessWidget {
  /// Creates an [AnimatedBubble].
  const AnimatedBubble({
    super.key,
    required this.isSelected,
    required this.animationDuration,
    required this.color,
  });

  /// Whether the bubble is expanded.
  final bool isSelected;

  /// Duration of the expand/collapse animation.
  final Duration animationDuration;

  /// Fill color of the bubble.
  final Color color;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: isSelected ? 1.0 : 0.0,
      duration: animationDuration,
      curve: Curves.easeOutBack,
      child: Container(
        width: NavBarDefaults.bubbleWidth,
        height: NavBarDefaults.bubbleHeight,
        decoration: BoxDecoration(
          color: color,
          borderRadius:
              BorderRadius.circular(NavBarDefaults.bubbleBorderRadius),
        ),
      ),
    );
  }
}
