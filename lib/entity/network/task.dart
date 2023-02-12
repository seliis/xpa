class TaskPackage {
  TaskPackage({
    required this.name,
    required this.desc,
    required this.step,
  });

  final String name;
  final String desc;
  List<StepPackage> step;

  factory TaskPackage.fromJson(Map<String, dynamic> data) {
    final List<Map<String, dynamic>> typedStepData = List<Map<String, dynamic>>.from(
      data["task_package_step"],
    );

    return TaskPackage(
      name: data["task_package_name"] as String,
      desc: data["task_package_desc"] as String,
      step: typedStepData.map(
        (Map<String, dynamic> eachStep) {
          return StepPackage.fromJson(eachStep);
        },
      ).toList(),
    );
  }
}

class StepPackage {
  const StepPackage({
    required this.name,
    required this.desc,
    required this.done,
  });

  final String name;
  final String desc;
  final bool done;

  factory StepPackage.fromJson(Map<String, dynamic> data) {
    return StepPackage(
      name: data["step_package_name"] as String,
      desc: data["step_package_desc"] as String,
      done: data["step_package_done"] as bool,
    );
  }

  StepPackage copyWith({
    String? name,
    String? desc,
    bool? done,
  }) {
    return StepPackage(
      name: name ?? this.name,
      desc: desc ?? this.desc,
      done: done ?? this.done,
    );
  }
}
