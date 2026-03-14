import 'dart:ui';

import 'package:flutter/widgets.dart';

/// Glassmorphic (frosted-glass) blur background container.
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

  /// The child widget.
  final Widget child;

  /// Gaussian blur sigma.
  final double blurStrength;

  /// Semi-transparent overlay color.
  final Color backgroundColor;

  /// Optional corner radius.
  final BorderRadius? borderRadius;

  /// Optional border decoration.
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
