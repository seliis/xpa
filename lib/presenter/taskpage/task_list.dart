import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:xpa/interactor/index.dart";
import "package:xpa/entity/index.dart";
import "dart:convert";

class AsyncTaskListNotifier extends AsyncNotifier<List<TaskListData>> {
  Future<List<TaskListData>> _fetchData() async {
    final String response = await InteractorOfTask.requestDummyTaskListData();
    final List<dynamic> jsonData = jsonDecode(response) as List<dynamic>;
    _setInitState(jsonData);
    return jsonData.map(
      (data) {
        return TaskListData.fromJson(data);
      },
    ).toList();
  }

  int selectedTask = -1;

  void _setInitState(List<dynamic> jsonData) {
    ref.watch(taskStepDataProvider.notifier).state = jsonData[0]["task_step"] as List<TaskStepData>;
    selectedTask = 0;
  }

  @override
  Future<List<TaskListData>> build() async {
    return await _fetchData();
  }
}

final asyncTaskListDataProvider = AsyncNotifierProvider<AsyncTaskListNotifier, List<TaskListData>>(
  () {
    return AsyncTaskListNotifier();
  },
);

final taskStepDataProvider = StateProvider<List<TaskStepData>>(
  (ref) {
    return <TaskStepData>[];
  },
);
