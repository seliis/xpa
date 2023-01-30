import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:xpa/presenter/index.dart";
import "package:xpa/entity/index.dart";
import "package:flutter/material.dart";

class FrameDrawer extends ConsumerWidget {
  const FrameDrawer({super.key});

  final EdgeInsets margin = const EdgeInsets.all(16);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Container getHeader() {
      return Container(
        margin: margin,
        child: Column(
          children: const [
            Text(
              "Aeronaut\u2120",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
            Text(
              "0.0.0",
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 10,
              ),
            ),
          ],
        ),
      );
    }

    TextButton getMenu(ScreenPage screenPage) {
      return TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(16),
        ),
        onPressed: () {
          ref.watch(screenProvider.notifier).state = screenPage;
          Navigator.pop(context);
        },
        child: Text(
          "${screenPage.name[0].toUpperCase()}${screenPage.name.substring(1).toLowerCase()}",
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
      );
    }

    Container getMenuList() {
      return Container(
        alignment: Alignment.topLeft,
        margin: margin,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getMenu(ScreenPage.dashboard),
            getMenu(ScreenPage.assignment),
          ],
        ),
      );
    }

    Container getFooter() {
      return Container(
        alignment: Alignment.topLeft,
        margin: margin,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Paveway\u00A9",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            Text(
              "2023",
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 10,
              ),
            ),
          ],
        ),
      );
    }

    return Drawer(
      child: Column(
        children: [
          getHeader(),
          const Divider(),
          Expanded(
            child: getMenuList(),
          ),
          getFooter(),
        ],
      ),
    );
  }
}
