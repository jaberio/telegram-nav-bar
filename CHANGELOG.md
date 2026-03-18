## 0.2.1

* **Docs**: Updated README demo GIFs layout.

## 0.2.0

* **Feature**: Liquid Glass mode — translucent floating capsule style inspired by Telegram's Liquid Glass UI.
* **Feature**: `LiquidGlassStyle` configuration class with full customization: blur, tint, border glow, highlight gradient, shadow, and margin.
* **Feature**: `GlassContainer` now supports inner highlight gradient, tint color blending, and configurable drop shadow.
* **Feature**: `AnimatedBubble` supports gradient fill, border glow, and opacity fade in Liquid Glass mode.
* **Example**: Added 3 new demos — Liquid Glass, Liquid Glass Tinted, and Liquid Glass + FAB.
* **Tests**: Added 9 new tests covering Liquid Glass rendering, interaction, dark mode, tinting, and style properties.

## 0.1.0

* **Breaking**: Simplified folder structure — replaced deep `core/domain/presentation` layers with flat `lib/src/`.
* **Breaking**: Merged `NavBarConstants` and `NavBarColors` into unified `NavBarDefaults`.
* **Feature**: Center button (FAB) support — split items around a floating center widget with configurable offset.
* **Feature**: Badge support — `badgeCount` (numeric) and `showBadge` (dot) on `TelegramNavItem`.
* **Feature**: Press animation — items scale down on tap with smooth spring-back.
* **Feature**: Haptic feedback on item tap (configurable via `enableHapticFeedback`).
* **Feature**: Improved bubble animation — bouncy pop-in using `Curves.easeOutBack` scale transition.
* **Chore**: Cleaned up excessive doc comments and removed boilerplate.
* **Example**: Added 4 demo screens — Default, Floating, Center FAB, and Badges.

## 0.0.2

* **Fix**: Shortened package description to meet pub.dev constraints.
* **Fix**: Repaired `demo.gif` relative path in README for pub.dev compatibility.
* **Fix**: Resolved dangling library doc comment warning.
* **Chore**: Set up automated pub.dev publishing via GitHub Actions.

## 0.0.1

* **Initial release** of the Telegram-style bottom navigation bar.
