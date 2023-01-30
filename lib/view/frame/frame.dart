import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter/material.dart";
import "drawer.dart";

class Frame extends ConsumerWidget {
  const Frame({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      drawer: FrameDrawer(),
    );
  }
}
