import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:xpa/interactor/index.dart";
import "package:xpa/entity/index.dart";
import "dart:convert";

class AsyncTaskListNotifier extends AsyncNotifier<List<TaskPackage>> {
  Future<List<TaskPackage>> _fetchData() async {
    final String response = await InteractorOfTask.requestDummyTaskData();
    final jsonData = json.decode(response);
    _setInitState(jsonData);
    final typedJsonData = List<Map<String, dynamic>>.from(jsonData);
    return typedJsonData.map(
      (data) {
        return TaskPackage.fromJson(data);
      },
    ).toList();
  }

  int selectedTask = -1;

  void _setInitState(List<dynamic> jsonData) {
    final Map<String, dynamic> firstTask = Map<String, dynamic>.from(jsonData[0]);
    final stepList = List<Map<String, dynamic>>.from(firstTask["step"]);
    final List<StepPackage> stepPackage = stepList.map((eachStep) {
      return StepPackage.fromJson(eachStep);
    }).toList();
    ref.watch(stepPackageDataProvider.notifier).state = stepPackage;
    selectedTask = 0;
  }

  @override
  Future<List<TaskPackage>> build() async {
    return await _fetchData();
  }
}

final asyncTaskPackageDataProvider = AsyncNotifierProvider<AsyncTaskListNotifier, List<TaskPackage>>(
  () {
    return AsyncTaskListNotifier();
  },
);

final stepPackageDataProvider = StateProvider<List<StepPackage>>(
  (ref) {
    return <StepPackage>[];
  },
);
