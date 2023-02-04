import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter/material.dart";

class TaskPageArguments {
  const TaskPageArguments({
    required this.missionPackageName,
  });

  final String missionPackageName;
}

class TaskPage extends ConsumerWidget {
  const TaskPage({
    super.key,
    required this.taskPageArguments,
  });

  static const routeName = "taskPage";
  final TaskPageArguments taskPageArguments;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(taskPageArguments.missionPackageName),
      ),
      body: const Center(
        child: Text("TaskPage"),
      ),
    );
  }
}
