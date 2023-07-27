# iOS Side Menu
![pub package](https://img.shields.io/badge/pub-v1.0.0-blue)

A Flutter plugin to use the pure dart code API.

## Usage
https://github.com/RohitKumarMishra/ios_side_menu/assets/14270768/2508f715-7b4a-44a1-aba0-9afbd28fb1f8.mp4?raw=true

Add `ios_side_menu` as a dependency in your project.

You can directly use it inside your home page or wherever you want to show the side menu like below - 
```dart
GlobalKey<IosSideMenuWidgetState> sideMenuState = GlobalKey();

IosSideMenuWidget(
        key: sideMenuState,
        sideMenuWidth: 270,
        sideMenuWidget: Container(
          decoration: BoxDecoration(
          // To Add extra elevation effect in side menu container
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
          child: Container(
            decoration: const BoxDecoration(color: Colors.white),
            height: double.maxFinite,
            width: double.maxFinite,
          ),
        ),
        mainMenuWidget: Scaffold(
          appBar: AppBar(
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
      )
```

## Issues and feedback

All the feedbacks and PR's are welcome.
