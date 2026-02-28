# Telegram Nav Bar

[![pub package](https://img.shields.io/pub/v/telegram_nav_bar.svg)](https://pub.dev/packages/telegram_nav_bar)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

A production-ready, highly-customizable Flutter package that replicates the latest **Telegram "Liquid Glass"** bottom navigation bar.

Built with **Clean Architecture**, **100% Null Safety**, and **zero external dependencies** — only pure Flutter / `dart:ui`.

## Features ✨

- **Telegram-accurate design** — Full-width translucent glass bar with a thin top divider, matching Telegram's latest Liquid Glass aesthetic
- **Smooth animations** — Fluid icon scaling, color tweening, and pill-shaped bubble indicator
- **Glassmorphic backdrop** — Real `BackdropFilter` blur with configurable intensity
- **Dark & Light mode** — Theme-aware defaults that adapt automatically
- **Active icon support** — Optional separate icon for selected state (like `BottomNavigationBarItem.activeIcon`)
- **Highly customizable** — 10+ parameters for colors, sizing, spacing, border radius, elevation, and more
- **Clean Architecture** — Modular internal structure across `domain`, `core`, and `presentation` layers
- **Zero dependencies** — Pure Flutter, no third-party packages

## Installation 📦

```yaml
dependencies:
  telegram_nav_bar: ^0.0.1
```

```bash
flutter pub get
```

## Quick Start 💻

### Basic (edge-to-edge — Telegram default style)

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
      TelegramNavItem(icon: Icons.call_outlined, activeIcon: Icons.call, label: 'Calls'),
      TelegramNavItem(icon: Icons.settings_outlined, activeIcon: Icons.settings, label: 'Settings'),
    ],
  ),
)
```

### Floating / rounded style

```dart
TelegramNavBar(
  // ...items and callbacks
  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  borderRadius: BorderRadius.circular(32),
  showTopDivider: false,
)
```

## Customization 🎨

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
| `iconSize` | `double?` | `24.0` | Icon size for all items |
| `showTopDivider` | `bool` | `true` | Show thin top divider line |
| `topDividerColor` | `Color?` | Theme-aware | Top divider color |
| `padding` | `EdgeInsetsGeometry?` | `EdgeInsets.zero` | Inner padding (add for floating style) |
| `margin` | `EdgeInsetsGeometry?` | `EdgeInsets.zero` | Outer margin |
| `borderRadius` | `BorderRadius?` | `null` | Rounded corners (for floating style) |
| `elevation` | `double?` | Theme-aware | Shadow intensity |

## Platform Support 🖥️

| Android | iOS | Web | macOS | Windows | Linux |
|---------|-----|-----|-------|---------|-------|
| ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |

## Contribution 🤝

Issues and pull requests are welcomed! Please maintain backwards compatibility and add features via optional parameters without breaking the existing API.

## License 📜

This package is licensed under the [MIT License](LICENSE).
