import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:xpa/interactor/index.dart";
import "package:xpa/entity/index.dart";
import "dart:convert";

class AsyncTaskPackageNotifier extends AsyncNotifier<List<TaskPackage>> {
  Future<List<TaskPackage>> _fetchData() async {
    final String response = await InteractorOfTask.requestDummyTaskData();
    final List<Map<String, dynamic>> jsonData = List<Map<String, dynamic>>.from(
      jsonDecode(response),
    );
    _setInitState(jsonData);
    return jsonData.map(
      (Map<String, dynamic> eachTask) {
        return TaskPackage.fromJson(eachTask);
      },
    ).toList();
  }

  int selectedTask = -1;

  void _setInitState(List<Map<String, dynamic>> jsonData) {
    setStepPackageProviderState(jsonData[0]["step"]);
    selectedTask = 0;
  }

  void setStepPackageProviderState(List<dynamic> stepData) {
    final List<Map<String, dynamic>> typedStepData = List<Map<String, dynamic>>.from(stepData);
    ref.watch(stepPackageDataProvider.notifier).changeState(typedStepData);
  }

  @override
  Future<List<TaskPackage>> build() async {
    return await _fetchData();
  }
}

final asyncTaskPackageDataProvider = AsyncNotifierProvider<AsyncTaskPackageNotifier, List<TaskPackage>>(
  () {
    return AsyncTaskPackageNotifier();
  },
);

class StepPackageNotifier extends StateNotifier<List<StepPackage>> {
  StepPackageNotifier() : super(<StepPackage>[]);

  void changeState(List<Map<String, dynamic>> typedStepData) {
    state = typedStepData.map((Map<String, dynamic> eachStep) {
      return StepPackage.fromJson(eachStep);
    }).toList();
  }

  void setDone(int index, bool? changedValue) {
    state = [
      for (final StepPackage step in state) ...[
        if (step.id == index) ...[
          step.copyWith(
            done: changedValue,
          ),
        ] else ...[
          step,
        ],
      ],
    ];
  }
}

final stepPackageDataProvider = StateNotifierProvider<StepPackageNotifier, List<StepPackage>>(
  (ref) {
    return StepPackageNotifier();
  },
);
