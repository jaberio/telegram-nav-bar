import 'dart:ui';

import 'package:flutter/widgets.dart';

/// Glassmorphic (frosted-glass) blur background container.
///
/// When [highlightColor] is provided, a subtle vertical gradient overlay is
/// drawn from top to transparent, simulating the Liquid Glass inner shine.
class GlassContainer extends StatelessWidget {
  /// Creates a [GlassContainer].
  const GlassContainer({
    super.key,
    required this.child,
    required this.blurStrength,
    required this.backgroundColor,
    this.borderRadius,
    this.border,
    this.highlightColor,
    this.tintColor,
    this.tintOpacity = 0.0,
    this.shadowColor,
    this.shadowBlurRadius,
    this.shadowOffset,
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

  /// Optional inner highlight gradient color (Liquid Glass shine).
  final Color? highlightColor;

  /// Optional tint color blended onto the glass surface.
  final Color? tintColor;

  /// Opacity of [tintColor] (0.0 – 1.0).
  final double tintOpacity;

  /// Optional outer shadow color.
  final Color? shadowColor;

  /// Shadow blur radius.
  final double? shadowBlurRadius;

  /// Shadow offset.
  final Offset? shadowOffset;

  @override
  Widget build(BuildContext context) {
    final hasLiquidEffects =
        highlightColor != null || shadowColor != null || tintColor != null;

    Widget content = Container(
      decoration: BoxDecoration(
        color: _effectiveBackground,
        borderRadius: borderRadius,
        border: border,
        boxShadow: shadowColor != null
            ? [
                BoxShadow(
                  color: shadowColor!,
                  blurRadius: shadowBlurRadius ?? 16,
                  offset: shadowOffset ?? const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: hasLiquidEffects
          ? _LiquidGlassOverlay(
              borderRadius: borderRadius,
              highlightColor: highlightColor,
              child: child,
            )
          : child,
    );

    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurStrength, sigmaY: blurStrength),
        child: content,
      ),
    );
  }

  Color get _effectiveBackground {
    if (tintColor != null && tintOpacity > 0) {
      return Color.lerp(backgroundColor, tintColor, tintOpacity) ??
          backgroundColor;
    }
    return backgroundColor;
  }
}

/// Draws a subtle vertical gradient highlight over the glass surface. 
class _LiquidGlassOverlay extends StatelessWidget {
  const _LiquidGlassOverlay({
    required this.child,
    this.borderRadius,
    this.highlightColor,
  });

  final Widget child;
  final BorderRadius? borderRadius;
  final Color? highlightColor;

  @override
  Widget build(BuildContext context) {
    if (highlightColor == null) return child;

    return Stack(
      children: [
        child,
        Positioned.fill(
          child: IgnorePointer(
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    highlightColor!,
                    highlightColor!.withAlpha(0),
                  ],
                  stops: const [0.0, 0.5],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
