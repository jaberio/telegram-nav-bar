import 'package:flutter/widgets.dart';

/// Default constants and colors for the Telegram navigation bar.
class NavBarDefaults {
  NavBarDefaults._();

  /// Default animation duration for transitions.
  static const Duration animationDuration = Duration(milliseconds: 250);

  /// Default bar height.
  static const double barHeight = 64.0;

  /// Default icon size.
  static const double iconSize = 24.0;

  /// Default label font size.
  static const double labelFontSize = 12.0;

  /// Bubble indicator width.
  static const double bubbleWidth = 48.0;

  /// Bubble indicator height.
  static const double bubbleHeight = 32.0;

  /// Bubble border radius.
  static const double bubbleBorderRadius = 16.0;

  /// Scale factor for active icon.
  static const double activeIconScale = 1.15;

  /// Scale factor on press down.
  static const double pressedScale = 0.9;

  /// Default blur sigma.
  static const double blurStrength = 20.0;

  /// Gap between icon and label.
  static const double iconLabelGap = 4.0;

  /// Top divider line thickness.
  static const double topDividerHeight = 0.5;

  /// Telegram signature blue.
  static const Color telegramBlue = Color(0xFF2AABEE);

  /// Inactive item grey.
  static const Color inactiveGrey = Color(0xFF8E8E93);

  /// Light mode bar background.
  static const Color lightBackground = Color(0xE6F7F7F7);

  /// Dark mode bar background.
  static const Color darkBackground = Color(0xE6212121);

  /// Light mode bubble color.
  static const Color activeBubbleLight = Color(0x262AABEE);

  /// Dark mode bubble color.
  static const Color activeBubbleDark = Color(0x332AABEE);

  /// Light mode divider color.
  static const Color topDividerLight = Color(0x33000000);

  /// Dark mode divider color.
  static const Color topDividerDark = Color(0x33FFFFFF);

  /// Badge indicator color.
  static const Color badgeColor = Color(0xFFFF3B30);

  // ── Liquid Glass defaults ──

  /// Liquid Glass blur sigma (stronger than default).
  static const double liquidGlassBlur = 30.0;

  /// Liquid Glass bar height.
  static const double liquidGlassBarHeight = 60.0;

  /// Liquid Glass border radius for the floating capsule.
  static const double liquidGlassBorderRadius = 28.0;

  /// Liquid Glass border width.
  static const double liquidGlassBorderWidth = 0.8;

  /// Liquid Glass light mode background.
  static const Color liquidGlassLightBg = Color(0xBBF5F5F7);

  /// Liquid Glass dark mode background.
  static const Color liquidGlassDarkBg = Color(0xBB1C1C1E);

  /// Liquid Glass light mode border color (subtle white glow).
  static const Color liquidGlassBorderLight = Color(0x55FFFFFF);

  /// Liquid Glass dark mode border color.
  static const Color liquidGlassBorderDark = Color(0x33FFFFFF);

  /// Liquid Glass light mode inner highlight gradient top.
  static const Color liquidGlassHighlightLight = Color(0x33FFFFFF);

  /// Liquid Glass dark mode inner highlight gradient top.
  static const Color liquidGlassHighlightDark = Color(0x1AFFFFFF);

  /// Liquid Glass light bubble color.
  static const Color liquidGlassBubbleLight = Color(0x302AABEE);

  /// Liquid Glass dark bubble color.
  static const Color liquidGlassBubbleDark = Color(0x402AABEE);

  /// Liquid Glass animation duration (slightly longer for fluidity).
  static const Duration liquidGlassAnimationDuration =
      Duration(milliseconds: 320);

  /// Liquid Glass default horizontal margin.
  static const double liquidGlassHorizontalMargin = 16.0;

  /// Liquid Glass default bottom margin.
  static const double liquidGlassBottomMargin = 8.0;

  /// Liquid Glass shadow color (light mode).
  static const Color liquidGlassShadowLight = Color(0x1A000000);

  /// Liquid Glass shadow color (dark mode).
  static const Color liquidGlassShadowDark = Color(0x40000000);
}

/// Configuration for the Liquid Glass visual style.
///
/// Apply to [TelegramNavBar.liquidGlassStyle] to enable the new
/// translucent floating capsule look inspired by Telegram's Liquid Glass UI.
class LiquidGlassStyle {
  /// Creates a [LiquidGlassStyle] with fully customizable properties.
  const LiquidGlassStyle({
    this.blurStrength,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.highlightColor,
    this.shadowColor,
    this.shadowBlurRadius,
    this.shadowOffset,
    this.margin,
    this.tintColor,
    this.tintOpacity,
  });

  /// Pre-built Liquid Glass style using the default constants.
  factory LiquidGlassStyle.standard() => const LiquidGlassStyle();

  /// Blur sigma for the frosted glass backdrop.
  final double? blurStrength;

  /// Background fill color of the glass container.
  final Color? backgroundColor;

  /// Border / edge glow color.
  final Color? borderColor;

  /// Border width.
  final double? borderWidth;

  /// Border radius of the floating capsule.
  final BorderRadius? borderRadius;

  /// Inner highlight gradient color (top of the bar).
  final Color? highlightColor;

  /// Drop shadow color.
  final Color? shadowColor;

  /// Drop shadow blur radius.
  final double? shadowBlurRadius;

  /// Drop shadow offset.
  final Offset? shadowOffset;

  /// Outer margin around the capsule.
  final EdgeInsetsGeometry? margin;

  /// Optional color tint blended into the glass surface.
  final Color? tintColor;

  /// Opacity of the [tintColor] blend (0.0 – 1.0).
  final double? tintOpacity;
}
