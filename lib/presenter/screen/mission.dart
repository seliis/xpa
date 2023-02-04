import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:xpa/interactor/index.dart";
import "package:xpa/entity/index.dart";
import "dart:convert";

class AsyncMissionPackageDataNotifier extends AsyncNotifier<List<MissionPackageDataResponse>> {
  Future<List<MissionPackageDataResponse>> _fetchData() async {
    final String response = await InteractorOfMission.requestDummyMissionPackageData();
    //final jsonData = json.decode(response) as List<Map<String, dynamic>>; // why didn't work?
    final jsonData = jsonDecode(response) as List<dynamic>; // why did work?
    //final jsonData = jsonDecode(response); // why didn't work?
    return jsonData.map(
      (data) {
        return MissionPackageDataResponse.fromJson(data);
      },
    ).toList();
  }

  @override
  Future<List<MissionPackageDataResponse>> build() async {
    return _fetchData();
  }
}

final asyncMissionPackageDataProvider = AsyncNotifierProvider<AsyncMissionPackageDataNotifier, List<MissionPackageDataResponse>>(
  () {
    return AsyncMissionPackageDataNotifier();
  },
);
