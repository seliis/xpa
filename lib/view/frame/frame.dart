import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter/material.dart";
import "appbar.dart";
import "drawer.dart";
import "screen.dart";

class Frame extends ConsumerWidget {
  const Frame({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      appBar: FrameAppBar(),
      drawer: FrameDrawer(),
      body: Screen(),
    );
  }
}
