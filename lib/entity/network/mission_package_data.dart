class MissionPackageData {
  const MissionPackageData({
    required this.id,
    required this.name,
    required this.desc,
  });

  final int id;
  final String name;
  final String desc;

  factory MissionPackageData.fromJson(Map<String, dynamic> data) {
    return MissionPackageData(
      id: data["id"] as int,
      name: data["name"] as String,
      desc: data["desc"] as String,
    );
  }
}
