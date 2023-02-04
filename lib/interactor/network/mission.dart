import "package:flutter/services.dart";

class InteractorOfMission {
  static Future<String> requestDummyMissionPackageData() async {
    return await rootBundle.loadString("dummy/mission_package_data.json");
  }
}
