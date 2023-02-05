import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:xpa/presenter/index.dart";
import "package:flutter/material.dart";
import "dart:developer";

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
    final taskListData = ref.watch(asyncTaskListDataProvider);
    final taskDetailData = ref.watch(taskDetailDataProvider);

    Expanded getTaskList() {
      return Expanded(
        child: taskListData.when(
          data: (data) {
            return ListView.separated(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return ElevatedButton(
                  onPressed: () {
                    ref.watch(taskDetailDataProvider.notifier).state = data[index].taskDetail;
                  },
                  style: ElevatedButton.styleFrom(
                    alignment: Alignment.centerLeft,
                    shape: const RoundedRectangleBorder(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 32,
                    ),
                  ),
                  child: Text(data[index].taskName),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
            );
          },
          loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
          error: (error, stackTrace) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    error.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.red,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    stackTrace.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    }

    Expanded getTaskDetail() {
      return Expanded(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int j = 0; j < 10; j++) ...[
                for (int i = 0; i < taskDetailData.length; i++) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                    child: Text(taskDetailData[i]),
                  ),
                ],
              ],
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        title: Text(taskPageArguments.missionPackageName),
      ),
      body: Row(
        children: [
          getTaskList(),
          const VerticalDivider(),
          getTaskDetail(),
        ],
      ),
    );
  }
}
