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
}
