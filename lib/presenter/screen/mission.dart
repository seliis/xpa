import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:xpa/interactor/index.dart";
import "package:xpa/entity/index.dart";
import "dart:convert";
import "dart:developer";

class AsyncMissionPackageDataNotifier extends AsyncNotifier<List<MissionPackageDataResponse>> {
  Future<List<MissionPackageDataResponse>> _fetchData() async {
    final String response = await InteractorOfMission.requestDummyMissionPackageData();
    //final jsonData = jsonDecode(response) as List<Map<String, dynamic>>;
    final jsonData = jsonDecode(response) as List<dynamic>;
    //final jsonData = jsonDecode(response);
    log(jsonData.runtimeType.toString());
    final newList = jsonData.map((data) {
      log(data.runtimeType.toString());
      data.forEach((key, value) {
        log("$key: $value");
      });
      return MissionPackageDataResponse.fromJson(data);
    }).toList();
    return newList;
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
