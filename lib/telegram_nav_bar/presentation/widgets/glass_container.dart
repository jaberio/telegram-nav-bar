import 'dart:ui';

import 'package:flutter/widgets.dart';

/// A widget that applies a glassmorphic (frosted-glass) blur effect to
/// its background content.
///
/// This is the core visual building block for Telegram's "Liquid Glass"
/// design language. It uses [BackdropFilter] with a Gaussian blur and
/// overlays a semi-transparent [backgroundColor].
class GlassContainer extends StatelessWidget {
  /// Creates a [GlassContainer].
  const GlassContainer({
    super.key,
    required this.child,
    required this.blurStrength,
    required this.backgroundColor,
    this.borderRadius,
    this.border,
  });

  /// The widget below this widget in the tree.
  final Widget child;

  /// The Gaussian blur sigma applied to the backdrop.
  final double blurStrength;

  /// The semi-transparent color overlaid on the blurred content.
  final Color backgroundColor;

  /// Optional border radius to clip the glass effect.
  ///
  /// When provided the [BackdropFilter] will be clipped to rounded
  /// corners, preventing the blur from bleeding beyond the bar shape.
  final BorderRadius? borderRadius;

  /// Optional border to draw around the container for a subtle glass
  /// edge highlight.
  final Border? border;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurStrength, sigmaY: blurStrength),
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: borderRadius,
            border: border,
          ),
          child: child,
        ),
      ),
    );
  }
}
