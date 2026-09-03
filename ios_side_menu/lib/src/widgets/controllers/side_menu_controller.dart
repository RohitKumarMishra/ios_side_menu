import 'package:flutter/material.dart';

/// Drives the horizontal scroll that reveals or hides the side menu.
class SideMenuController {
  /// Whether the drawer is treated as visible.
  ValueNotifier<bool> isSideMenuVisible = ValueNotifier(false);

  /// Scroll controller attached to the menu [ListView].
  late ScrollController sideMenuScrollController;

  /// Width used to decide snap-open vs snap-closed.
  late double sideMenuWidth;

  /// When true, a programmatic animation is in progress.
  bool shouldAutoScroll = false;

  /// Snaps the drawer open or closed after a user swipe.
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

  /// Scrolls so the drawer is fully visible.
  Future<void> showSideMenu() async {
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

  /// Scrolls so the drawer is fully hidden.
  Future<void> hideSideMenu() async {
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
