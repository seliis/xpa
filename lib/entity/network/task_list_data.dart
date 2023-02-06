class TaskListData {
  const TaskListData({
    required this.id,
    required this.taskName,
    required this.taskStep,
  });

  final int id;
  final String taskName;
  final List<TaskStepData> taskStep;

  factory TaskListData.fromJson(Map<String, dynamic> data) {
    return TaskListData(
      id: data["id"] as int,
      taskName: data["task_name"] as String,
      taskStep: <TaskStepData>[
        for (final Map<String, dynamic> stepData in data["task_step"]) ...[
          TaskStepData.fromJson(stepData),
        ],
      ],
    );
  }
}

class TaskStepData {
  const TaskStepData({
    required this.stepNumber,
    required this.stepName,
    required this.stepDescription,
  });

  final int stepNumber;
  final String stepName;
  final String stepDescription;

  factory TaskStepData.fromJson(Map<String, dynamic> data) {
    return TaskStepData(
      stepNumber: data["step_number"] as int,
      stepName: data["step_name"] as String,
      stepDescription: data["step_description"] as String,
    );
  }
}
