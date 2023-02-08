// [ TaskPackageList: List<Map<String, dynamic>>
//   { TaskPackage: Map<String, dynamic>
//     "id": 0,
//     "name": "TASK_PACKAGE_NAME",
//     "step": [ StepPackageList: List<Map<String, dynamic>>
//       { StepPackage: Map<String, dynamic>
//         "id": 0,
//         "name": "STEP_PACKAGE_NAME",
//         "desc": "STEP_PACKAGE_DESC"
//       }
//     ]
//   }
// ]

class TaskPackage {
  const TaskPackage({
    required this.id,
    required this.name,
    required this.step,
  });

  final int id;
  final String name;
  final List<dynamic> step;

  factory TaskPackage.fromJson(dynamic data) {
    return TaskPackage(
      id: data["id"] as int,
      name: data["name"] as String,
      step: data["step"].map(
        (step) {
          return StepPackage.fromJson(step);
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

  factory StepPackage.fromJson(dynamic data) {
    return StepPackage(
      id: data["id"] as int,
      name: data["name"] as String,
      desc: data["desc"] as String,
    );
  }
}
