import "package:flutter/services.dart";

class InteractorOfTask {
  static Future<String> requestDummyTaskData() async {
    await Future.delayed(const Duration(seconds: 1)); // have to remove before release
    return await rootBundle.loadString("dummy/task.json");
  }
}
