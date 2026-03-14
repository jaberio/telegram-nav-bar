import 'package:flutter/widgets.dart';

/// Data model for a single navigation item.
class TelegramNavItem {
  /// Creates a [TelegramNavItem].
  const TelegramNavItem({
    required this.icon,
    required this.label,
    this.activeIcon,
    this.badgeCount,
    this.showBadge = false,
  });

  /// Icon shown when inactive.
  final IconData icon;

  /// Icon shown when selected. Falls back to [icon].
  final IconData? activeIcon;

  /// Text label below the icon.
  final String label;

  /// Numeric badge count. Shows a numbered badge when > 0.
  final int? badgeCount;

  /// Whether to show a badge dot (no number).
  final bool showBadge;

  /// Whether this item has any badge (count or dot).
  bool get hasBadge => showBadge || (badgeCount != null && badgeCount! > 0);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TelegramNavItem &&
        other.icon == icon &&
        other.activeIcon == activeIcon &&
        other.label == label &&
        other.badgeCount == badgeCount &&
        other.showBadge == showBadge;
  }

  @override
  int get hashCode =>
      Object.hash(icon, activeIcon, label, badgeCount, showBadge);

  @override
  String toString() => 'TelegramNavItem(icon: $icon, label: $label)';
}
