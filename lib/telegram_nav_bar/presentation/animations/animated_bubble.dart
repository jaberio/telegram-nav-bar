import 'package:flutter/widgets.dart';

import '../../../telegram_nav_bar.dart';

/// A widget that animates a pill-shaped indicator bubble based on
/// the selection state of a navigation item.
///
/// When [isSelected] is `true`, the bubble expands to its full size
/// with a smooth [Curves.easeInOutCubic] curve. When deselected it
/// collapses to zero.
class AnimatedBubble extends StatelessWidget {
  /// Creates an [AnimatedBubble].
  const AnimatedBubble({
    super.key,
    required this.isSelected,
    required this.animationDuration,
    required this.color,
  });

  /// Whether the bubble is currently in its expanded (selected) state.
  final bool isSelected;

  /// The duration of the expand / collapse animation.
  final Duration animationDuration;

  /// The fill color of the bubble.
  final Color color;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: animationDuration,
      curve: Curves.easeInOutCubic,
      width: isSelected ? NavBarConstants.bubbleWidth : 0.0,
      height: isSelected ? NavBarConstants.bubbleHeight : 0.0,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(NavBarConstants.bubbleBorderRadius),
      ),
    );
  }
}
