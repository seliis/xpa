import "package:hive/hive.dart";

class Database {
  static const _instance = Database._singleInstance();
  const Database._singleInstance();
  factory Database() => _instance;

  static Box<dynamic>? _testBox;

  static Future<Box<dynamic>> get testBox async {
    return _testBox ??= await Hive.openBox("test");
  }

  static void write(Box box, dynamic key, dynamic value) async {
    await box.put(key, value);
  }

  static dynamic read(Box box, dynamic key) {
    return box.get(key);
  }

  static void delete(Box box, dynamic key) async {
    await box.delete(key);
  }

  static Future<int> clear(Box box, dynamic key) async {
    return await box.clear();
  }
}
