import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:xpa/presenter/index.dart";
import "package:flutter/material.dart";
import "package:xpa/entity/index.dart";
import "package:xpa/view/index.dart";

class TaskPage extends ConsumerWidget {
  const TaskPage({
    super.key,
    required this.taskPageArguments,
  });

  static const routeName = "taskPage";
  final TaskPageArguments taskPageArguments;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskPackageDataNotifier = ref.watch(asyncTaskPackageDataProvider.notifier);
    final taskPackageData = ref.watch(asyncTaskPackageDataProvider);
    final stepPackageDataNotifier = ref.watch(stepPackageDataProvider.notifier);
    final stepPackageData = ref.watch(stepPackageDataProvider);

    Expanded getTaskList() {
      return Expanded(
        child: taskPackageData.when(
          data: (data) {
            return ListView.separated(
              padding: const EdgeInsets.all(32),
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return ElevatedButton(
                  onPressed: () {
                    stepPackageDataNotifier.state = data[index].step.map((eachStep) {
                      return StepPackage.fromJson(eachStep);
                    }).toList();
                    taskPackageDataNotifier.selectedTask = index;
                  },
                  style: ElevatedButton.styleFrom(
                    alignment: Alignment.centerLeft,
                    shape: const RoundedRectangleBorder(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 32,
                    ),
                    side: taskPackageDataNotifier.selectedTask == index ? const BorderSide(color: Colors.pink) : null,
                  ),
                  child: Text(data[index].name),
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
      if (taskPackageDataNotifier.selectedTask != -1) {
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
            for (final StepPackage data in stepPackageData) ...[
              Container(
                padding: const EdgeInsets.all(32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(data.name),
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
          if (taskPackageDataNotifier.selectedTask != -1) ...[
            const VerticalDivider(),
            getTaskStep(),
          ],
        ],
      ),
    );
  }
}
