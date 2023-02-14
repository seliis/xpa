import "package:xpa/interactor/index.dart";

class InteractorOfTask {
  static Future<String> requestDummyTaskData() async {
    await Future.delayed(const Duration(seconds: 1)); // have to remove before release
    return Database.read(await Database.testBox, "testTask");
  }

  static void postDummyTaskData(String contents) async {
    print(contents);
    Database.write(await Database.testBox, "testTask", contents);
  }
}
