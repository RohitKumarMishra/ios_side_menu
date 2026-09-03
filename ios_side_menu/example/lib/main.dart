import 'package:flutter/material.dart';
import 'package:ios_side_menu/ios_side_menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<IosSideMenuWidgetState> _sideMenuState = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ios_side_menu example',
      home: IosSideMenuWidget(
        key: _sideMenuState,
        sideMenuWidth: 270,
        sideMenuWidget: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 48),
          child: const Text('Menu'),
        ),
        mainMenuWidget: Scaffold(
          appBar: AppBar(
            title: const Text('ios_side_menu example'),
            leading: IconButton(
              onPressed: () {
                final IosSideMenuWidgetState? state =
                    _sideMenuState.currentState;
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
          body: const ColoredBox(
            color: Colors.blue,
            child: SizedBox.expand(),
          ),
        ),
      ),
    );
  }
}
