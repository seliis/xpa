import "package:xpa/interactor/index.dart";

class InteractorOfMission {
  static Future<String> requestDummyMissionData() async {
    await Future.delayed(const Duration(seconds: 1)); // have to remove before release
    return await Database.read(await Database.testBox, "testMission");
  }
}
