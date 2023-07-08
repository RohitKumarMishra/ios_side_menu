import 'package:flutter/material.dart';

class SideMenuController {
  ValueNotifier<bool> isSideMenuVisible = ValueNotifier(false);
  ScrollController sideMenuScrollController =
      ScrollController(initialScrollOffset: 270);
  double sideMenuWidth = 270;
  bool shouldAutoScroll = false;

  // void setUpScrollController(double scrollOffset) {
  //   sideMenuWidth = scrollOffset;
  //   sideMenuScrollController ??=
  //       ScrollController(initialScrollOffset: scrollOffset);
  // }

  void completeSideMenuScroll(Function(bool) onComplete) async {
    if (!shouldAutoScroll) {
      if (sideMenuScrollController.position.pixels < (sideMenuWidth * 0.5)) {
        await showSideMenu();
        onComplete(false);
      } else if (sideMenuScrollController.position.pixels >
          (sideMenuWidth * 0.5)) {
        await hideSideMenu();
        onComplete(true);
      }
    }
  }

  Future showSideMenu() async {
    await Future.delayed(const Duration(milliseconds: 50), () async {
      await sideMenuScrollController.animateTo(
        sideMenuScrollController.position.minScrollExtent,
        duration: const Duration(
          milliseconds: 300,
        ),
        curve: Curves.ease,
      );
    });
  }

  Future hideSideMenu() async {
    await Future.delayed(const Duration(milliseconds: 50), () async {
      await sideMenuScrollController.animateTo(
        sideMenuScrollController.position.maxScrollExtent,
        duration: const Duration(
          milliseconds: 300,
        ),
        curve: Curves.ease,
      );
    });
  }
}
