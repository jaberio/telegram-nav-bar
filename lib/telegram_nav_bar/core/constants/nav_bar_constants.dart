/// Constants used throughout the Telegram navigation bar package.
///
/// All magic numbers and default values are centralized here for
/// consistency and easy customization.
class NavBarConstants {
  /// Prevent instantiation.
  NavBarConstants._();

  // ---------------------------------------------------------------------------
  // Durations
  // ---------------------------------------------------------------------------

  /// Default animation duration for navigation transitions.
  static const Duration defaultAnimationDuration = Duration(milliseconds: 250);

  // ---------------------------------------------------------------------------
  // Sizes
  // ---------------------------------------------------------------------------

  /// Default height of the navigation bar.
  static const double defaultBarHeight = 64.0;

  /// Default icon size for navigation items.
  static const double defaultIconSize = 24.0;

  /// Default font size for item labels.
  static const double defaultLabelFontSize = 12.0;

  /// Width of the active indicator bubble.
  static const double bubbleWidth = 48.0;

  /// Height of the active indicator bubble.
  static const double bubbleHeight = 32.0;

  /// Border radius of the active indicator bubble.
  static const double bubbleBorderRadius = 16.0;

  /// Scale multiplier when an icon is active / selected.
  static const double activeIconScale = 1.15;

  /// Scale multiplier when an icon is pressed.
  static const double pressedIconScale = 0.9;

  /// Default blur strength for the glassmorphic background.
  static const double defaultBlurStrength = 20.0;

  // ---------------------------------------------------------------------------
  // Spacing
  // ---------------------------------------------------------------------------

  /// Gap between icon and label.
  static const double iconLabelGap = 4.0;

  /// Top divider thickness (the thin line at the top of the bar).
  static const double topDividerHeight = 0.5;
}
