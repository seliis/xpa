import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:xpa/interactor/index.dart";
import "package:xpa/entity/index.dart";
import "dart:convert";

class AsyncTaskPackageNotifier extends AutoDisposeAsyncNotifier<List<TaskPackage>> {
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
      firstJsonData["task_package_step"],
    );
    final List<StepPackage> stepPackageList = stepData.map(
      (Map<String, dynamic> eachStep) {
        return StepPackage.fromJson(eachStep);
      },
    ).toList();
    setStepPackageProviderState(stepPackageList);
    selectedTask = 0;
  }

  String getSerializedState() {
    return state.whenData(
      (List<TaskPackage> taskPackageList) {
        return jsonEncode(
          taskPackageList.map(
            (TaskPackage taskPackage) {
              return <String, dynamic>{
                "task_package_name": taskPackage.name,
                "task_package_desc": taskPackage.desc,
                "task_package_step": taskPackage.step.map(
                  (StepPackage stepPackage) {
                    return <String, dynamic>{
                      "step_package_name": stepPackage.name,
                      "step_package_desc": stepPackage.desc,
                      "step_package_done": stepPackage.done,
                    };
                  },
                ).toList(),
              };
            },
          ).toList(),
        );
      },
    ).value!;
  }

  void setStepPackageProviderState(List<StepPackage> stepPackageList) {
    final notifier = ref.watch(stepPackageDataProvider.notifier);
    notifier.changeState(stepPackageList);
  }

  void saveCurrentTaskStatus() {
    state.whenData(
      (List<TaskPackage> taskPackageList) async {
        taskPackageList[selectedTask].step = ref.read(stepPackageDataProvider);
        InteractorOfTask.postDummyTaskData(getSerializedState());
      },
    );
  }

  @override
  Future<List<TaskPackage>> build() async {
    return await _fetchData();
  }
}

final asyncTaskPackageDataProvider = AsyncNotifierProvider.autoDispose<AsyncTaskPackageNotifier, List<TaskPackage>>(
  () {
    return AsyncTaskPackageNotifier();
  },
);

class StepPackageNotifier extends StateNotifier<List<StepPackage>> {
  StepPackageNotifier() : super(<StepPackage>[]);

  void changeState(List<StepPackage> stepPackageList) {
    state = stepPackageList;
  }

  void setDone(int targetIndex, bool? changedValue) {
    state = [
      for (int index = 0; index < state.length; index++) ...[
        if (index == targetIndex) ...[
          state[index].copyWith(
            done: changedValue,
          ),
        ] else ...[
          state[index],
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
