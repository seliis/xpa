import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter/material.dart";

class FrameDrawer extends ConsumerWidget {
  const FrameDrawer({super.key});

  TextButton _getMenu(String menuText) {
    return TextButton(
      onPressed: () {},
      child: Text(menuText),
    );
  }

  Container _getMenuList() {
    return Container(
      child: Column(
        children: [
          _getMenu("Dashboard"),
          _getMenu("Assignment"),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: Column(
        children: [
          _getMenuList(),
        ],
      ),
    );
  }
}
