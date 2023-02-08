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
    _setInitState(jsonData[0]);
    return jsonData.map(
      (Map<String, dynamic> eachTask) {
        return TaskPackage.fromJson(eachTask);
      },
    ).toList();
  }

  int selectedTask = -1;

  void _setInitState(Map<String, dynamic> firstJsonData) {
    final List<Map<String, dynamic>> stepData = List<Map<String, dynamic>>.from(
      firstJsonData["step"],
    );
    final List<StepPackage> stepPackageList = stepData.map(
      (Map<String, dynamic> eachStep) {
        return StepPackage.fromJson(eachStep);
      },
    ).toList();
    setStepPackageProviderState(stepPackageList);
    selectedTask = 0;
  }

  void setStepPackageProviderState(List<StepPackage> stepPackageList) {
    ref.watch(stepPackageDataProvider.notifier).changeState(stepPackageList);
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

  // void changeState(List<Map<String, dynamic>> typedStepData) {
  //   state = typedStepData.map((Map<String, dynamic> eachStep) {
  //     return StepPackage.fromJson(eachStep);
  //   }).toList();
  // }

  void changeState(List<StepPackage> stepPackageList) {
    state = stepPackageList;
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
