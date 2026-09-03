# iOS Side Menu
![pub package](https://img.shields.io/pub/v/ios_side_menu.svg)

A Flutter widget that slides an iOS-style side menu over the main screen.
Pure Dart — no native plugins.

![Demo](https://github.com/RohitKumarMishra/ios_side_menu/assets/14270768/93131cec-0ae8-4ff0-bf8f-21f35190d43d)

## Install

```yaml
dependencies:
  ios_side_menu: ^1.1.0
```

## Usage

```dart
import 'package:ios_side_menu/ios_side_menu.dart';

final GlobalKey<IosSideMenuWidgetState> sideMenuState = GlobalKey();

IosSideMenuWidget(
  key: sideMenuState,
  sideMenuWidth: 270,
  sideMenuWidget: const ColoredBox(color: Colors.white),
  mainMenuWidget: Scaffold(
    appBar: AppBar(
      title: const Text('Side Menu'),
      leading: IconButton(
        onPressed: () {
          final IosSideMenuWidgetState? state = sideMenuState.currentState;
          if (state == null) {
            return;
          }
          if (state.isSideMenuVisible) {
            state.hideSideMenu();
          } else {
            state.openSideMenu();
          }
        },
        icon: const Icon(Icons.menu),
      ),
    ),
    body: const ColoredBox(color: Colors.blue),
  ),
);
```

Swipe from the left edge, or call `openSideMenu()` / `hideSideMenu()` on the
state. See `example/` for a runnable app.

## Issues and feedback

Issues and pull requests are welcome:
https://github.com/RohitKumarMishra/ios_side_menu
