## 0.0.2

* **Fix**: Shortened package description to meet pub.dev constraints.
* **Fix**: Repaired `demo.gif` relative path in README for pub.dev compatibility.
* **Fix**: Resolved dangling library doc comment warning.
* **Chore**: Set up automated pub.dev publishing via GitHub Actions.

## 0.0.1

* **Initial release** of the Telegram-style bottom navigation bar.
* **Feature**: Glassmorphic "Liquid Glass" blur background using `dart:ui` `BackdropFilter`.
* **Feature**: Animated pill-shaped indicator bubble with smooth expand/collapse transitions.
* **Feature**: `activeIcon` support for separate selected/unselected icons.
* **Feature**: Thin top divider line matching Telegram's native look.
* **Feature**: Theme-aware dark and light mode defaults.
* **Feature**: 10+ customization parameters (colors, blur, sizing, border radius, padding, elevation).
* **Feature**: Constructor assertions for item count and index bounds validation.
* **Feature**: Full-width (edge-to-edge) layout by default; optionally configure floating/rounded style.
* **Architecture**: Clean Architecture with `domain`, `core`, and `presentation` layers.
* **Tests**: Comprehensive widget and unit test suite included.
