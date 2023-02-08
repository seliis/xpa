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
    required this.done,
    required this.overlapCheckLevel,
  });

  final int id;
  final String name;
  final String desc;
  final bool done;
  final int overlapCheckLevel;

  factory StepPackage.fromJson(Map<String, dynamic> data) {
    return StepPackage(
      id: data["id"] as int,
      name: data["name"] as String,
      desc: data["desc"] as String,
      done: data["done"] as bool,
      overlapCheckLevel: data["overlap_check_level"] as int,
    );
  }

  StepPackage copyWith({
    int? id,
    String? name,
    String? desc,
    bool? done,
    int? overlapCheckLevel,
  }) {
    return StepPackage(
      id: id ?? this.id,
      name: name ?? this.name,
      desc: desc ?? this.desc,
      done: done ?? this.done,
      overlapCheckLevel: overlapCheckLevel ?? this.overlapCheckLevel,
    );
  }
}
