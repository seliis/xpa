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
              "GLIDEPATH\u2120",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
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
          screenPage.name.toUpperCase(),
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            letterSpacing: 2,
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
            getMenu(ScreenPage.mission),
          ],
        ),
      );
    }

    Row getCompanyName() {
      const FontWeight fontWeight = FontWeight.w500;
      const double fontSize = 12;

      return Row(
        children: const [
          Text(
            "CASCADE",
            style: TextStyle(
              fontWeight: fontWeight,
              fontSize: fontSize,
            ),
          ),
          Text(
            "CLEARANCE\u00A9",
            style: TextStyle(
              fontWeight: fontWeight,
              color: Colors.pink,
              fontSize: fontSize,
            ),
          ),
        ],
      );
    }

    Container getFooter() {
      return Container(
        alignment: Alignment.topLeft,
        margin: margin,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getCompanyName(),
            const Text(
              "2023 Copyright",
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
