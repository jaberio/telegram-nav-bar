# Telegram Nav Bar

[![pub package](https://img.shields.io/pub/v/telegram_nav_bar.svg)](https://pub.dev/packages/telegram_nav_bar)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

A production-ready Flutter package that replicates the **Telegram "Liquid Glass"** bottom navigation bar — with glassmorphic blur, animated indicators, center FAB support, and badges.

**Zero external dependencies** — pure Flutter / `dart:ui`.

<p align="center">
  <img src="doc/demo.gif" width="250" alt="Telegram Nav Bar Demo">
</p>

## Features

- Telegram-accurate glassmorphic design with `BackdropFilter` blur
- Bouncy bubble indicator and icon scale animations
- Press-down feedback animation with haptic feedback
- Center button (FAB) support with configurable offset
- Badge support — numeric counts and indicator dots
- Active icon variants per item
- Dark & Light mode auto-detection
- Floating / rounded bar style option
- 15+ customization parameters
- Zero dependencies

## Installation

```yaml
dependencies:
  telegram_nav_bar: ^0.2.0
```

```bash
flutter pub get
```

## Quick Start

### Default (edge-to-edge)

```dart
import 'package:telegram_nav_bar/telegram_nav_bar.dart';

Scaffold(
  body: _pages[_currentIndex],
  bottomNavigationBar: TelegramNavBar(
    currentIndex: _currentIndex,
    onTap: (index) => setState(() => _currentIndex = index),
    items: const [
      TelegramNavItem(icon: Icons.chat_bubble_outline, activeIcon: Icons.chat_bubble, label: 'Chats'),
      TelegramNavItem(icon: Icons.person_outline, activeIcon: Icons.person, label: 'Contacts'),
      TelegramNavItem(icon: Icons.settings_outlined, activeIcon: Icons.settings, label: 'Settings'),
    ],
  ),
)
```

### Floating / rounded

```dart
TelegramNavBar(
  // ...items and callbacks
  margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
  borderRadius: BorderRadius.circular(32),
  showTopDivider: false,
)
```

### Center FAB button

```dart
TelegramNavBar(
  // ...items (even count recommended, split evenly around center)
  centerButton: FloatingActionButton(
    onPressed: () {},
    child: Icon(Icons.add),
  ),
  centerButtonOffset: 24,
)
```

### With badges

```dart
const items = [
  TelegramNavItem(icon: Icons.chat_bubble_outline, label: 'Chats', badgeCount: 12),
  TelegramNavItem(icon: Icons.person_outline, label: 'Contacts', showBadge: true),
  TelegramNavItem(icon: Icons.settings_outlined, label: 'Settings'),
];
```

## Customization

| Parameter | Type | Default | Description |
|---|---|---|---|
| `items` | `List<TelegramNavItem>` | **required** | Navigation items (min 2) |
| `currentIndex` | `int` | **required** | Selected item index |
| `onTap` | `ValueChanged<int>` | **required** | Tap callback |
| `backgroundColor` | `Color?` | Theme-aware | Bar background (supports transparency) |
| `activeColor` | `Color?` | Telegram Blue | Selected item color |
| `inactiveColor` | `Color?` | Grey | Unselected item color |
| `blurStrength` | `double?` | `20.0` | Gaussian blur sigma |
| `animationDuration` | `Duration?` | `250ms` | Selection animation duration |
| `height` | `double?` | `64.0` | Bar height |
| `bubbleColor` | `Color?` | Theme-aware | Active indicator fill color |
| `iconSize` | `double?` | `24.0` | Icon size |
| `showTopDivider` | `bool` | `true` | Show thin top divider line |
| `topDividerColor` | `Color?` | Theme-aware | Top divider color |
| `padding` | `EdgeInsetsGeometry?` | `EdgeInsets.zero` | Inner padding (for floating style) |
| `margin` | `EdgeInsetsGeometry?` | `EdgeInsets.zero` | Outer margin |
| `borderRadius` | `BorderRadius?` | `null` | Rounded corners (for floating style) |
| `elevation` | `double?` | Theme-aware | Shadow intensity |
| `centerButton` | `Widget?` | `null` | Center widget (FAB) between items |
| `centerButtonOffset` | `double` | `0` | How far center button extends above bar |
| `enableHapticFeedback` | `bool` | `true` | Haptic feedback on tap |

### TelegramNavItem

| Parameter | Type | Default | Description |
|---|---|---|---|
| `icon` | `IconData` | **required** | Inactive icon |
| `label` | `String` | **required** | Text label |
| `activeIcon` | `IconData?` | `null` | Icon when selected |
| `badgeCount` | `int?` | `null` | Numeric badge (shows count) |
| `showBadge` | `bool` | `false` | Show badge dot |

## Platform Support

| Android | iOS | Web | macOS | Windows | Linux |
|---------|-----|-----|-------|---------|-------|
| ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |

## License

[MIT License](LICENSE)
