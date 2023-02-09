class MissionPackage {
  const MissionPackage({
    required this.uuid,
    required this.name,
    required this.desc,
    required this.info,
  });

  final String uuid;
  final String name;
  final String desc;
  final MissionPackageInfo info;

  factory MissionPackage.fromJson(Map<String, dynamic> data) {
    return MissionPackage(
      uuid: data["mission_package_uuid"] as String,
      name: data["mission_package_name"] as String,
      desc: data["mission_package_desc"] as String,
      info: MissionPackageInfo.fromJson(data["mission_package_info"]),
    );
  }
}

class MissionPackageInfo {
  const MissionPackageInfo({
    required this.updatedBy,
    required this.updatedAt,
    required this.grantedBy,
    required this.grantedAt,
  });

  final String updatedBy;
  final String updatedAt;
  final String grantedBy;
  final String grantedAt;

  factory MissionPackageInfo.fromJson(Map<String, dynamic> data) {
    return MissionPackageInfo(
      updatedBy: data["updated_by"] as String,
      updatedAt: data["updated_at"] as String,
      grantedBy: data["granted_by"] as String,
      grantedAt: data["granted_at"] as String,
    );
  }
}
