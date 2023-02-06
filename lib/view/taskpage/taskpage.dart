import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:xpa/presenter/index.dart";
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
    final taskListDataNotifier = ref.watch(asyncTaskListDataProvider.notifier);
    final taskListData = ref.watch(asyncTaskListDataProvider);
    final taskDetailDataNotifier = ref.watch(taskDetailDataProvider.notifier);
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
                    taskDetailDataNotifier.state = data[index].taskDetail;
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

    Container getTaskDetailControl() {
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

    Expanded getTaskDetail() {
      return Expanded(
        child: ListView(
          children: [
            for (final data in taskDetailData) ...[
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                ),
                child: Text(data),
              ),
            ],
            getTaskDetailControl(),
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
            getTaskDetail(),
          ],
        ],
      ),
    );
  }
}
