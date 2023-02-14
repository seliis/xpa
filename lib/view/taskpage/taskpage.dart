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
    final stepPackageDataNotifier = ref.watch(stepPackageDataProvider.notifier);
    final taskPackageData = ref.watch(asyncTaskPackageDataProvider);
    final stepPackageData = ref.watch(stepPackageDataProvider);

    final RoundedRectangleBorder roundedRectangleBorder = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    );

    Expanded getTaskList() {
      return Expanded(
        child: taskPackageData.when(
          data: (List<TaskPackage> taskPackageList) {
            return ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: taskPackageList.length,
              itemBuilder: (BuildContext context, int taskPackageIndex) {
                final TaskPackage taskPackage = taskPackageList[taskPackageIndex];
                return ElevatedButton(
                  onPressed: () {
                    taskPackageDataNotifier.setStepPackageProviderState(taskPackage.step);
                    taskPackageDataNotifier.selectedTask = taskPackageIndex;
                  },
                  style: ElevatedButton.styleFrom(
                    alignment: Alignment.centerLeft,
                    shape: roundedRectangleBorder,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 32,
                    ),
                    side: taskPackageDataNotifier.selectedTask == taskPackageIndex ? const BorderSide(color: Colors.pink) : null,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.star_border,
                            color: Colors.pink,
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                taskPackage.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                taskPackage.desc,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          taskPackageDataNotifier.setDone(taskPackageIndex, !taskPackage.done);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: taskPackage.done ? Colors.lightGreen : Colors.grey,
                          foregroundColor: taskPackage.done ? Colors.black : Colors.grey.shade600,
                        ),
                        child: const Text("Complete"),
                      ),
                    ],
                  ),
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

    Card getStepCard(int stepIndex) {
      final StepPackage stepPackage = stepPackageData[stepIndex];

      return Card(
        margin: const EdgeInsets.all(8),
        shape: roundedRectangleBorder,
        child: CheckboxListTile(
          onChanged: (bool? changedValue) {
            stepPackageDataNotifier.setDone(
              stepIndex,
              changedValue,
            );
          },
          shape: roundedRectangleBorder,
          selected: stepPackage.done,
          value: stepPackage.done,
          title: Text(
            stepPackage.name,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.pink,
            ),
          ),
          subtitle: Text(
            stepPackage.desc,
            style: const TextStyle(
              fontWeight: FontWeight.w300,
              color: Colors.grey,
            ),
            textAlign: TextAlign.justify,
          ),
          secondary: const Icon(
            Icons.warning_amber,
            color: Colors.orange,
          ),
          isThreeLine: true,
          dense: true,
          controlAffinity: ListTileControlAffinity.leading,
        ),
      );
    }

    Expanded getTaskStep() {
      return Expanded(
        child: ListView(
          children: [
            for (int stepIndex = 0; stepIndex < stepPackageData.length; stepIndex++) ...[
              getStepCard(stepIndex)
            ],
          ],
        ),
      );
    }

    Row getControlButtons() {
      return Row(
        children: [
          CCElevatedButtonWithIcon(
            iconData: Icons.save,
            buttonText: "Save",
            onPressed: () async {
              void showSnackBar(String message, MaterialColor materialColor) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(message),
                      backgroundColor: materialColor,
                    ),
                  );
                }
              }

              if (await taskPackageDataNotifier.saveCurrentTaskStatus()) {
                showSnackBar("Task Package Has Been Saved", Colors.lightGreen);
              } else {
                showSnackBar("Task Package Saving Error Occured", Colors.red);
              }
            },
          ),
          const SizedBox(width: 8),
          CCElevatedButtonWithIcon(
            iconData: Icons.commit,
            buttonText: "Commit",
            onPressed: () {},
          ),
        ],
      );
    }

    return WillPopScope(
      onWillPop: () async {
        if (AsyncTaskPackageNotifier.taskPackageSaved) {
          return true;
        } else {
          return await showDialog(
            context: context,
            builder: (BuildContext dialogContext) {
              return AlertDialog(
                title: const Text(
                  "Warning",
                  style: TextStyle(
                    fontWeight: FontWeight.w100,
                    color: Colors.amber,
                  ),
                ),
                content: const Text("Packages are not saved, all changes will discard. Do you want continue to exit?"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(dialogContext, false);
                    },
                    child: const Text("No"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(dialogContext, true);
                    },
                    child: const Text("Yes"),
                  ),
                ],
              );
            },
          ).then(
            (dynamic result) => result,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                taskPageArguments.missionPackageName,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
              getControlButtons(),
            ],
          ),
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
      ),
    );
  }
}
