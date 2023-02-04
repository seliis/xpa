import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:xpa/presenter/index.dart";
import "package:xpa/entity/index.dart";
import "package:flutter/material.dart";
import "package:xpa/view/index.dart";

class Screen extends ConsumerWidget {
  const Screen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ScreenPage screenPage = ref.watch(screenProvider);

    Widget getScreenPage() {
      switch (screenPage) {
        case ScreenPage.dashboard:
          return const Dashboard();
        case ScreenPage.mission:
          return Mission();
      }
    }

    return Container(
      child: getScreenPage(),
    );
  }
}
