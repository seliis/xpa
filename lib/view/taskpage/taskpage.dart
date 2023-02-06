import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:xpa/presenter/index.dart";
import "package:flutter/material.dart";
import "package:xpa/entity/index.dart";
import "package:xpa/view/index.dart";

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
    final taskListDataNotifier = ref.watch(asyncTaskListDataProvider.notifier);
    final taskListData = ref.watch(asyncTaskListDataProvider);
    final taskStepDataNotifier = ref.watch(taskStepDataProvider.notifier);
    final taskStepData = ref.watch(taskStepDataProvider);

    Expanded getTaskList() {
      return Expanded(
        child: taskListData.when(
          data: (data) {
            return ListView.separated(
              padding: const EdgeInsets.all(32),
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return ElevatedButton(
                  onPressed: () {
                    taskStepDataNotifier.state = data[index].taskStep;
                    taskListDataNotifier.selectedTask = index;
                  },
                  style: ElevatedButton.styleFrom(
                    alignment: Alignment.centerLeft,
                    shape: const RoundedRectangleBorder(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 32,
                    ),
                    side: taskListDataNotifier.selectedTask == index ? const BorderSide(color: Colors.pink) : null,
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
            return CommonAsyncError(
              error: error,
              stackTrace: stackTrace,
            );
          },
        ),
      );
    }

    Container getTaskStepControl() {
      if (taskListDataNotifier.selectedTask != -1) {
        return Container(
          margin: const EdgeInsets.symmetric(
            vertical: 16,
          ),
          padding: const EdgeInsets.all(32),
          //color: Colors.black12,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Row(
                  children: const [
                    Icon(Icons.commit),
                    SizedBox(width: 4),
                    Text(
                      "Commit",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }
      return Container();
    }

    Expanded getTaskStep() {
      return Expanded(
        child: ListView(
          children: [
            for (final TaskStepData data in taskStepData) ...[
              Container(
                padding: const EdgeInsets.all(32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(data.stepName),
                    Checkbox(
                      onChanged: (bool? value) {},
                      value: false,
                    ),
                  ],
                ),
              ),
            ],
            getTaskStepControl(),
          ],
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
          if (taskListDataNotifier.selectedTask != -1) ...[
            const VerticalDivider(),
            getTaskStep(),
          ],
        ],
      ),
    );
  }
}
