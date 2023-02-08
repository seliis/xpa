import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:xpa/interactor/index.dart";
import "package:xpa/entity/index.dart";
import "dart:convert";

class AsyncMissionPackageDataNotifier extends AsyncNotifier<List<MissionPackage>> {
  Future<List<MissionPackage>> _fetchData() async {
    _jsonDataSize = -1; // for detect loading state in view
    final String response = await InteractorOfMission.requestDummyMissionData();
    final List<Map<String, dynamic>> jsonData = List<Map<String, dynamic>>.from(
      jsonDecode(response),
    );
    _jsonDataSize = jsonData.length;
    return jsonData.map(
      (Map<String, dynamic> data) {
        return MissionPackage.fromJson(data);
      },
    ).toList();
  }

  int _jsonDataSize = 0;

  @override
  Future<List<MissionPackage>> build() async {
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

final asyncMissionPackageDataProvider = AsyncNotifierProvider<AsyncMissionPackageDataNotifier, List<MissionPackage>>(
  () {
    return AsyncMissionPackageDataNotifier();
  },
);
