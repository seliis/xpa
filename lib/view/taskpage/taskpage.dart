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
          data: (List<TaskPackage> data) {
            return ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return ElevatedButton(
                  onPressed: () {
                    taskPackageDataNotifier.setStepPackageProviderState(data[index].step);
                    taskPackageDataNotifier.selectedTask = index;
                  },
                  style: ElevatedButton.styleFrom(
                    alignment: Alignment.centerLeft,
                    shape: roundedRectangleBorder,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 32,
                    ),
                    side: taskPackageDataNotifier.selectedTask == index ? const BorderSide(color: Colors.pink) : null,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data[index].name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        data[index].desc,
                        style: const TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 12,
                          color: Colors.white,
                        ),
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
            Icons.warning_amber_rounded,
            color: Colors.amber,
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
            onPressed: () {
              taskPackageDataNotifier.saveCurrentTaskStatus();
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
        return await showDialog(
          context: context,
          builder: (BuildContext dialogContext) {
            return AlertDialog(
              title: const Text("Do you want exit?"),
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
