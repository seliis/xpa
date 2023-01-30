import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter/material.dart";

class FrameAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const FrameAppBar({super.key});

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
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 2,
          ),
          Text(
            "BOEING 777-300ER AIRFRAME MECHANIC",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 10,
            ),
          ),
        ],
      );
    }

    ElevatedButton getLogoutButton() {
      return ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(),
        ),
        child: Row(
          children: const [
            Icon(Icons.logout),
            SizedBox(
              width: 4,
            ),
            Text(
              "LOGOUT",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                letterSpacing: 4,
                fontSize: 10,
              ),
            ),
          ],
        ),
      );
    }

    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          getUserTag(),
          getLogoutButton(),
        ],
      ),
    );
  }
}
