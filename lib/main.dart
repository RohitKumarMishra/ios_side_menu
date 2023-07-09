import 'package:flutter/material.dart';
import 'package:ios_side_menu/ios_side_menu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  GlobalKey<IosSideMenuWidgetState> sideMenuState = GlobalKey();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: IosSideMenuWidget(
        key: sideMenuState,
        sideMenuWidth: 270,
        sideMenuWidget: Container(
          // elevation: 20,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.green.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          margin: EdgeInsets.zero,
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(0),
          // ),
          child: Container(
            decoration: const BoxDecoration(color: Colors.white),
            height: double.maxFinite,
            width: double.maxFinite,
          ),
        ),
        mainMenuWidget: Scaffold(
          // backgroundColor: Colors.black,
          appBar: AppBar(
            // backgroundColor: Colors.black,
            title: Text('Side Menu'),
            leading: IconButton(
              onPressed: () {
                if (sideMenuState.currentState!.isSideMenuVisible) {
                  sideMenuState.currentState!.hideSideMenu();
                } else {
                  sideMenuState.currentState!.openSideMenu();
                }
              },
              icon: const Icon(Icons.menu),
            ),
          ),
          body: Container(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            height: double.maxFinite,
            width: double.maxFinite,
          ),
        ),
      ),
    );
  }
}
