/// A highly customizable Flutter package that replicates the latest
/// Telegram-style bottom navigation bar with smooth glassmorphic blur
/// effects, animated indicator bubbles, and seamless dark/light mode support.
///
/// ## Quick Start
///
/// ```dart
/// import 'package:telegram_nav_bar/telegram_nav_bar.dart';
///
/// TelegramNavBar(
///   currentIndex: _currentIndex,
///   onTap: (index) => setState(() => _currentIndex = index),
///   items: const [
///     TelegramNavItem(icon: Icons.chat_bubble_outline, label: 'Chats'),
///     TelegramNavItem(icon: Icons.person_outline, label: 'Contacts'),
///     TelegramNavItem(icon: Icons.settings_outlined, label: 'Settings'),
///   ],
/// )
/// ```
library;

// Domain
export 'telegram_nav_bar/domain/models/telegram_nav_item.dart';

// Core
export 'telegram_nav_bar/core/constants/nav_bar_constants.dart';
export 'telegram_nav_bar/core/theme/nav_bar_colors.dart';

// Presentation — Widgets
export 'telegram_nav_bar/presentation/widgets/telegram_nav_bar_widget.dart';
export 'telegram_nav_bar/presentation/widgets/nav_item_widget.dart';
export 'telegram_nav_bar/presentation/widgets/glass_container.dart';

// Presentation — Animations
export 'telegram_nav_bar/presentation/animations/animated_bubble.dart';
