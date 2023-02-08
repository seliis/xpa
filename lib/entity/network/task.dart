class TaskPackage {
  const TaskPackage({
    required this.id,
    required this.name,
    required this.step,
  });

  final int id;
  final String name;
  final List<StepPackage> step;

  factory TaskPackage.fromJson(Map<String, dynamic> data) {
    final List<Map<String, dynamic>> typedStepData = List<Map<String, dynamic>>.from(
      data["step"],
    );

    return TaskPackage(
      id: data["id"] as int,
      name: data["name"] as String,
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
    required this.id,
    required this.name,
    required this.desc,
  });

  final int id;
  final String name;
  final String desc;

  factory StepPackage.fromJson(Map<String, dynamic> data) {
    return StepPackage(
      id: data["id"] as int,
      name: data["name"] as String,
      desc: data["desc"] as String,
    );
  }
}
