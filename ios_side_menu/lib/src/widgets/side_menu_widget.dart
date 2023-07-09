// ignore_for_file: no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:ios_side_menu/src/widgets/controllers/controller.dart';

typedef SideMenuCallbacks = Function(Function(), Function());

class IosSideMenuWidget extends StatefulWidget {
  const IosSideMenuWidget({
    super.key,
    required this.sideMenuWidget,
    required this.mainMenuWidget,
    this.sideMenuWidth = 270,
  });

  final Widget sideMenuWidget;
  final Widget mainMenuWidget;
  final double? sideMenuWidth;

  @override
  State<IosSideMenuWidget> createState() => IosSideMenuWidgetState();
}

class IosSideMenuWidgetState extends State<IosSideMenuWidget> {
  SideMenuController sideMenuController = SideMenuController();

  bool isSideMenuVisible = false;

  double screenWidth = 0.0;
  double screenHeight = 0.0;

  ///
  @override
  void initState() {
    super.initState();
    initWidgetData();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    ///
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
                              onTap: () {
                                hideSideMenu();
                              },
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
          }),
    );
  }

  ///
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

  ///

  ///
  void initWidgetData() {
    sideMenuController.sideMenuWidth = widget.sideMenuWidth ?? 270;
    sideMenuController.sideMenuScrollController =
        ScrollController(initialScrollOffset: widget.sideMenuWidth ?? 270);
  }

  ///

  ///
}
