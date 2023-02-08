class MissionPackage {
  const MissionPackage({
    required this.id,
    required this.name,
    required this.desc,
  });

  final int id;
  final String name;
  final String desc;

  factory MissionPackage.fromJson(Map<String, dynamic> data) {
    return MissionPackage(
      id: data["id"] as int,
      name: data["name"] as String,
      desc: data["desc"] as String,
    );
  }
}
