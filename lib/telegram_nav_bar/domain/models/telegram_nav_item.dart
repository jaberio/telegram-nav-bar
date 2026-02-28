import 'package:flutter/widgets.dart';

/// Data model representing a single item in the Telegram navigation bar.
///
/// Each item requires an [icon] and [label]. Optionally, an [activeIcon]
/// can be provided to show a different icon when the item is selected
/// (similar to Flutter's built-in [BottomNavigationBarItem]).
///
/// ```dart
/// const TelegramNavItem(
///   icon: Icons.chat_bubble_outline,
///   activeIcon: Icons.chat_bubble,
///   label: 'Chats',
/// )
/// ```
class TelegramNavItem {
  /// Creates a new [TelegramNavItem].
  ///
  /// The [icon] and [label] parameters are required.
  /// If [activeIcon] is not provided, [icon] is used for both states.
  const TelegramNavItem({
    required this.icon,
    required this.label,
    this.activeIcon,
  });

  /// The icon to display when this item is **inactive**.
  final IconData icon;

  /// The icon to display when this item is **active** / selected.
  ///
  /// Falls back to [icon] when `null`.
  final IconData? activeIcon;

  /// The text label displayed below the icon.
  final String label;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TelegramNavItem &&
        other.icon == icon &&
        other.activeIcon == activeIcon &&
        other.label == label;
  }

  @override
  int get hashCode => Object.hash(icon, activeIcon, label);

  @override
  String toString() =>
      'TelegramNavItem(icon: $icon, activeIcon: $activeIcon, label: $label)';
}
