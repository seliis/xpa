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
            "Ahri Kim",
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 16,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            "Mechanic",
            style: TextStyle(
              fontWeight: FontWeight.w700,
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
            Text("Logout"),
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
