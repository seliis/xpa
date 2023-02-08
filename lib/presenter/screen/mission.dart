import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:xpa/interactor/index.dart";
import "package:xpa/entity/index.dart";
import "dart:convert";

class AsyncMissionPackageDataNotifier extends AsyncNotifier<List<MissionPackageData>> {
  Future<List<MissionPackageData>> _fetchData() async {
    _jsonDataSize = -1; // for detect loading state in view
    final String response = await InteractorOfMission.requestDummyMissionData();
    //final jsonData = json.decode(response) as List<Map<String, dynamic>>; // why didn't work?
    final List<dynamic> jsonData = jsonDecode(response) as List<dynamic>; // why did work?
    //final jsonData = jsonDecode(response); // why didn't work?
    _jsonDataSize = jsonData.length;
    return jsonData.map(
      (data) {
        return MissionPackageData.fromJson(data);
      },
    ).toList();
  }

  int _jsonDataSize = 0;

  @override
  Future<List<MissionPackageData>> build() async {
    return await _fetchData();
  }

  Future<void> refreshMissionPackageData() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async {
        return await _fetchData();
      },
    );
  }

  String getAssignedQuantityStateMsg() {
    switch (_jsonDataSize) {
      case -1:
        return "Loading...";
      case 0:
        return "Not Assigned Yet";
      default:
        return "$_jsonDataSize Assigned";
    }
  }
}

final asyncMissionPackageDataProvider = AsyncNotifierProvider<AsyncMissionPackageDataNotifier, List<MissionPackageData>>(
  () {
    return AsyncMissionPackageDataNotifier();
  },
);
