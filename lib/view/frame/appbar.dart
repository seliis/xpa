import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter/material.dart";

class FrameAppBar extends ConsumerWidget implements PreferredSizeWidget {
  FrameAppBar({super.key});

  final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    padding: const EdgeInsets.symmetric(
      horizontal: 48,
    ),
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
            "KIM AHRI",
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

    ElevatedButton getLogoutButton() {
      return ElevatedButton(
        onPressed: () {},
        style: buttonStyle,
        child: Row(
          children: [
            const Icon(Icons.logout),
            const SizedBox(
              width: 4,
            ),
            Text(
              "LOGOUT",
              style: buttonTextStyle,
            ),
          ],
        ),
      );
    }

    ElevatedButton getSettingButton() {
      return ElevatedButton(
        onPressed: () {},
        style: buttonStyle,
        child: Row(
          children: [
            const Icon(Icons.settings),
            const SizedBox(
              width: 4,
            ),
            Text(
              "SETTINGS",
              style: buttonTextStyle,
            ),
          ],
        ),
      );
    }

    Row getButtons() {
      return Row(
        children: [
          getSettingButton(),
          const SizedBox(
            width: 16,
          ),
          getLogoutButton(),
        ],
      );
    }

    return AppBar(
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
