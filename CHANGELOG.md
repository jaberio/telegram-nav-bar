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
