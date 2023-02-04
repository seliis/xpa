class MissionPackageDataResponse {
  const MissionPackageDataResponse({
    required this.id,
    required this.missionPackageName,
    required this.missionPackageInfo,
  });

  final int id;
  final String missionPackageName;
  final String missionPackageInfo;

  factory MissionPackageDataResponse.fromJson(Map<String, dynamic> data) {
    return MissionPackageDataResponse(
      id: data["id"] as int,
      missionPackageName: data["mission_package_name"] as String,
      missionPackageInfo: data["mission_package_info"] as String,
    );
  }
}
