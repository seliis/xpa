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

    Card getStepCard(int stepIndex) {
      final StepPackage stepPackage = stepPackageData[stepIndex];

      Widget getSecondary() {
        switch (stepPackage.overlapCheckLevel) {
          case 0:
            return const SizedBox.shrink();
          case 1:
            return const Icon(Icons.star_border_purple500);
          case 2:
            return const Icon(Icons.hotel_class_outlined);
          default:
            return const SizedBox.shrink();
        }
      }

      // Think: Can be give color tape on left border only with below code.
      // Card(
      //   child: ClipPath(
      //     child: Container(
      //       padding: EdgeInsets.all(16),
      //       decoration: BoxDecoration(
      //         border: Border(
      //           left: BorderSide(color: Colors.greenAccent, width: 5),
      //         ),
      //       ),
      //       child: Text(
      //         'Product Name',
      //         style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      //       ),
      //     ),
      //     clipper: ShapeBorderClipper(
      //         shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.circular(3))),
      //   ),
      // );

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
          ),
          subtitle: Text(
            stepPackage.desc,
          ),
          secondary: getSecondary(),
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
            onPressed: () {},
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

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              taskPageArguments.missionPackageName,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
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
    );
  }
}
