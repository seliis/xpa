import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter/material.dart";

class Dashboard extends ConsumerWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(
      child: Text("Dashboard"),
    );
  }
}
