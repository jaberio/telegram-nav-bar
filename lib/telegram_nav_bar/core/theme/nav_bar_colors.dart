import 'package:flutter/widgets.dart';

/// Default color palette for the Telegram-style navigation bar.
///
/// These colors are carefully matched to Telegram's latest "Liquid Glass"
/// design language.
class NavBarColors {
  /// Prevent instantiation.
  NavBarColors._();

  /// Telegram's signature blue color used for active items.
  static const Color telegramBlue = Color(0xFF2AABEE);

  /// Default inactive color for icons and labels.
  static const Color inactiveGrey = Color(0xFF8E8E93);

  /// Default light-mode bar background (semi-transparent white).
  static const Color lightBackground = Color(0xE6F7F7F7);

  /// Default dark-mode bar background (semi-transparent dark).
  static const Color darkBackground = Color(0xE6212121);

  /// Active bubble indicator color for light mode.
  static const Color activeBubbleLight = Color(0x262AABEE);

  /// Active bubble indicator color for dark mode.
  static const Color activeBubbleDark = Color(0x332AABEE);

  /// Top divider color for light mode.
  static const Color topDividerLight = Color(0x33000000);

  /// Top divider color for dark mode.
  static const Color topDividerDark = Color(0x33FFFFFF);
}
