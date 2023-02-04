import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter/material.dart";

class TaskPage extends ConsumerWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text("TaskPage"),
      ),
    );
  }
}
