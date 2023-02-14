import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:xpa/presenter/index.dart";
import "package:xpa/entity/index.dart";
import "package:flutter/material.dart";
import "package:xpa/view/index.dart";

class TaskList extends ConsumerWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskPackageListData = ref.watch(taskPackageListProvider);
    final taskPackageListNotifier = ref.watch(taskPackageListProvider.notifier);

    Widget showData(List<TaskPackage> taskPackageList) {
      Widget itemBuilder(BuildContext packageContext, int packageIndex) {
        final TaskPackage taskPackage = taskPackageList[packageIndex];

        Widget getLeftSection() {
          return Row(
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
          );
        }

        Widget getRightSection() {
          return ElevatedButton(
            onPressed: () {
              taskPackageListNotifier.setDone(packageIndex, !taskPackage.done);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: taskPackage.done ? Colors.lightGreen : Colors.grey,
              foregroundColor: taskPackage.done ? Colors.black : Colors.grey.shade600,
            ),
            child: const Text("Complete"),
          );
        }

        return ElevatedButton(
          onPressed: () {
            taskPackageListNotifier.setStepPackageProviderState(taskPackage.step);
            ref.read(selectedTaskPackageIndexProvider.notifier).state = packageIndex;
          },
          style: ElevatedButton.styleFrom(
            alignment: Alignment.centerLeft,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 32,
            ),
            side: ref.watch(selectedTaskPackageIndexProvider) == packageIndex ? const BorderSide(color: Colors.pink) : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              getLeftSection(),
              getRightSection(),
            ],
          ),
        );
      }

      return ListView.separated(
        itemCount: taskPackageList.length,
        itemBuilder: itemBuilder,
        separatorBuilder: (eachContext, eachIndex) {
          return const Divider();
        },
      );
    }

    Widget showError(Object error, StackTrace stackTrace) {
      return CommonAsyncError(error: error, stackTrace: stackTrace);
    }

    Widget showLoading() {
      return const Center(child: CircularProgressIndicator());
    }

    return taskPackageListData.when(
      data: showData,
      error: showError,
      loading: showLoading,
    );
  }
}
