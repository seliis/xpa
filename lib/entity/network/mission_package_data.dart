class MissionPackageData {
  const MissionPackageData({
    required this.id,
    required this.missionPackageName,
    required this.missionPackageInfo,
  });

  final int id;
  final String missionPackageName;
  final MissionPackageInfo missionPackageInfo;

  factory MissionPackageData.fromJson(Map<String, dynamic> data) {
    return MissionPackageData(
      id: data["id"] as int,
      missionPackageName: data["mission_package_name"] as String,
      missionPackageInfo: MissionPackageInfo(
        description: data["mission_package_info"]["description"],
      ),
    );
  }
}

class MissionPackageInfo {
  const MissionPackageInfo({
    required this.description,
  });

  final String description;
}
