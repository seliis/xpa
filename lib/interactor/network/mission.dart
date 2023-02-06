import "package:flutter/services.dart";

class InteractorOfMission {
  static Future<String> requestDummyMissionPackageData() async {
    await Future.delayed(const Duration(seconds: 1)); // have to remove before release
    return await rootBundle.loadString("dummy/mission_package_data.json");
  }
}
