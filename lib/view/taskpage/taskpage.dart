import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:xpa/presenter/index.dart";
import "package:flutter/material.dart";
import "package:xpa/entity/index.dart";
import "package:xpa/view/index.dart";
import "tasklist.dart";

class TaskPage extends ConsumerWidget {
  const TaskPage({
    super.key,
    required this.taskPageArguments,
  });

  static const routeName = "taskPage";
  final TaskPageArguments taskPageArguments;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskPackageListData = ref.watch(taskPackageListProvider);
    final stepPackageListData = ref.watch(stepPackageListProvider);
    final taskPackageListNotifier = ref.watch(taskPackageListProvider.notifier);
    final stepPackageListNotifier = ref.watch(stepPackageListProvider.notifier);

    final RoundedRectangleBorder roundedRectangleBorder = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    );

    Card getStepCard(int stepIndex) {
      final StepPackage stepPackage = stepPackageListData[stepIndex];

      return Card(
        margin: const EdgeInsets.all(8),
        shape: roundedRectangleBorder,
        child: CheckboxListTile(
          onChanged: (bool? changedValue) {
            stepPackageListNotifier.setDone(
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
            for (int stepIndex = 0; stepIndex < stepPackageListData.length; stepIndex++) ...[
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

              if (await taskPackageListNotifier.saveCurrentTaskStatus()) {
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
          ref.read(selectedTaskPackageIndexProvider.notifier).state = -1;
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
            (dynamic doPop) {
              if (doPop) ref.read(selectedTaskPackageIndexProvider.notifier).state = -1;
              return doPop;
            },
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
            const Expanded(
              child: TaskList(),
            ),
            if (ref.watch(selectedTaskPackageIndexProvider) != -1) ...[
              const VerticalDivider(),
              getTaskStep(),
            ],
          ],
        ),
      ),
    );
  }
}
