import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ios_side_menu/ios_side_menu.dart';

void main() {
  testWidgets('builds an IosSideMenuWidget', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: IosSideMenuWidget(
          sideMenuWidget: ColoredBox(color: Colors.white),
          mainMenuWidget: Scaffold(body: Text('main')),
        ),
      ),
    );

    expect(find.text('main'), findsOneWidget);
  });
}
