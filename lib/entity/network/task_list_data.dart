class TaskListData {
  const TaskListData({
    required this.id,
    required this.taskName,
    required this.taskDetail,
  });

  final int id;
  final String taskName;
  final List<dynamic> taskDetail;

  factory TaskListData.fromJson(Map<String, dynamic> data) {
    return TaskListData(
      id: data["id"] as int,
      taskName: data["task_name"] as String,
      taskDetail: data["task_detail"] as List<dynamic>,
    );
  }
}
