import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:xpa/interactor/index.dart";
import "package:xpa/entity/index.dart";
import "dart:convert";

class AsyncMissionPackageDataNotifier extends AsyncNotifier<List<MissionPackageData>> {
  Future<List<MissionPackageData>> _fetchData() async {
    final String response = await InteractorOfMission.requestDummyMissionPackageData();
    //final jsonData = json.decode(response) as List<Map<String, dynamic>>; // why didn't work?
    final jsonData = jsonDecode(response) as List<dynamic>; // why did work?
    //final jsonData = jsonDecode(response); // why didn't work?
    assignedMissionCount = jsonData.length;
    return jsonData.map(
      (data) {
        return MissionPackageData.fromJson(data);
      },
    ).toList();
  }

  static int assignedMissionCount = 0;

  @override
  Future<List<MissionPackageData>> build() async {
    return _fetchData();
  }

  Future<void> refreshMissionPackageData() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return _fetchData();
    });
  }

  int getAssignedMissionCount() {
    return assignedMissionCount;
  }
}

final asyncMissionPackageDataProvider = AsyncNotifierProvider<AsyncMissionPackageDataNotifier, List<MissionPackageData>>(
  () {
    return AsyncMissionPackageDataNotifier();
  },
);
