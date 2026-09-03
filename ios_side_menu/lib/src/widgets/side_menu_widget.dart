// ignore_for_file: no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:ios_side_menu/src/widgets/controllers/controller.dart';

/// Callback that receives open and hide functions for the side menu.
typedef SideMenuCallbacks = Function(Function() open, Function() hide);

/// An iOS-style horizontally sliding side menu.
///
/// Place [sideMenuWidget] beside [mainMenuWidget]. Users can swipe from the
/// left edge or call [IosSideMenuWidgetState.openSideMenu] /
/// [IosSideMenuWidgetState.hideSideMenu] through a [GlobalKey].
class IosSideMenuWidget extends StatefulWidget {
  /// Creates an iOS-style sliding side menu.
  const IosSideMenuWidget({
    super.key,
    required this.sideMenuWidget,
    required this.mainMenuWidget,
    this.sideMenuWidth = 270,
  });

  /// Content shown in the sliding drawer.
  final Widget sideMenuWidget;

  /// Content shown as the main screen.
  final Widget mainMenuWidget;

  /// Width of the drawer. Defaults to 270.
  final double? sideMenuWidth;

  @override
  State<IosSideMenuWidget> createState() => IosSideMenuWidgetState();
}

/// State for [IosSideMenuWidget].
///
/// Keep a [GlobalKey] of this type to open or hide the menu from a parent.
class IosSideMenuWidgetState extends State<IosSideMenuWidget> {
  /// Controller that drives the horizontal scroll animation.
  SideMenuController sideMenuController = SideMenuController();

  /// Whether the drawer is currently visible.
  bool isSideMenuVisible = false;

  /// Latest layout width of the host.
  double screenWidth = 0.0;

  /// Latest layout height of the host.
  double screenHeight = 0.0;

  @override
  void initState() {
    super.initState();
    initWidgetData();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return ScrollConfiguration(
      behavior: const MaterialScrollBehavior().copyWith(
        overscroll: false,
        physics: const ClampingScrollPhysics(),
        scrollbars: false,
      ),
      child: ValueListenableBuilder(
        valueListenable: sideMenuController.isSideMenuVisible,
        builder: (context, value, child) {
          return NotificationListener<ScrollNotification>(
            onNotification: (scrollNotification) {
              if (scrollNotification is ScrollEndNotification) {
                if (scrollNotification.depth == 0) {
                  sideMenuController.completeSideMenuScroll((shouldHide) {
                    isSideMenuVisible = !shouldHide;

                    sideMenuController.isSideMenuVisible.value = !shouldHide;
                  });
                }
              }
              return true;
            },
            child: ListView(
              scrollDirection: Axis.horizontal,
              controller: sideMenuController.sideMenuScrollController,
              children: [
                SizedBox(
                  width: widget.sideMenuWidth ?? 270,
                  height: screenHeight,
                  child: widget.sideMenuWidget,
                ),
                Stack(
                  children: [
                    Stack(
                      children: [
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onHorizontalDragUpdate: (details) {},
                          child: SizedBox(
                            width: screenWidth,
                            height: screenHeight,
                            child: widget.mainMenuWidget,
                          ),
                        ),
                        if (isSideMenuVisible)
                          GestureDetector(
                            onTap: hideSideMenu,
                            child: SizedBox(
                              width: screenWidth,
                              height: screenHeight,
                              child: Container(
                                color: Colors.black54,
                              ),
                            ),
                          ),
                      ],
                    ),
                    Container(
                      height: double.maxFinite,
                      width: 25,
                      color: Colors.transparent,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Animates the drawer into view.
  void openSideMenu() {
    sideMenuController.shouldAutoScroll = true;
    sideMenuController.sideMenuScrollController
        .animateTo(
      sideMenuController.sideMenuScrollController.position.minScrollExtent,
      duration: const Duration(
        milliseconds: 300,
      ),
      curve: Curves.ease,
    )
        .then((value) {
      isSideMenuVisible = true;

      sideMenuController.isSideMenuVisible.value =
          !sideMenuController.isSideMenuVisible.value;
      sideMenuController.shouldAutoScroll = false;
    });
  }

  /// Animates the drawer out of view.
  void hideSideMenu() {
    sideMenuController.shouldAutoScroll = true;
    sideMenuController.sideMenuScrollController
        .animateTo(
      sideMenuController.sideMenuScrollController.position.maxScrollExtent,
      duration: const Duration(
        milliseconds: 300,
      ),
      curve: Curves.ease,
    )
        .then((value) {
      isSideMenuVisible = false;

      sideMenuController.isSideMenuVisible.value =
          !sideMenuController.isSideMenuVisible.value;
      sideMenuController.shouldAutoScroll = false;
    });
  }

  /// Sets drawer width and the initial closed scroll offset.
  void initWidgetData() {
    sideMenuController.sideMenuWidth = widget.sideMenuWidth ?? 270;
    sideMenuController.sideMenuScrollController =
        ScrollController(initialScrollOffset: widget.sideMenuWidth ?? 270);
  }
}
