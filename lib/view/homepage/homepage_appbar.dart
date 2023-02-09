import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter/material.dart";
import "package:xpa/view/index.dart";

class HomePageAppBar extends ConsumerWidget implements PreferredSizeWidget {
  HomePageAppBar({super.key});

  final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    fixedSize: const Size.fromWidth(160),
  );

  final TextStyle buttonTextStyle = const TextStyle(
    fontWeight: FontWeight.w500,
    letterSpacing: 1,
    fontSize: 10,
  );

  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Column getUserTag() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Grace Mckenzie",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 2,
          ),
          Text(
            "BOEING 777-300ER AIRFRAME MECHANIC",
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 10,
            ),
          ),
        ],
      );
    }

    Row getButtons() {
      return Row(
        children: [
          CCElevatedButtonWithIcon(
            iconData: Icons.settings,
            buttonText: "Settings",
            onPressed: () {},
          ),
          const SizedBox(
            width: 8,
          ),
          CCElevatedButtonWithIcon(
            iconData: Icons.logout,
            buttonText: "Logout",
            onPressed: () {},
          ),
        ],
      );
    }

    return AppBar(
      scrolledUnderElevation: 0.0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          getUserTag(),
          getButtons(),
        ],
      ),
    );
  }
}
