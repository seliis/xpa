import "package:hive/hive.dart";

class Database {
  static const _instance = Database._singleInstance();
  const Database._singleInstance();
  factory Database() => _instance;

  static final Box testBox = Hive.box("test");

  static void saveData(Box box, dynamic key, dynamic value) {
    box.put(key, value);
  }
}
