import "package:hive/hive.dart";

class Database {
  static const _instance = Database._singleInstance();
  const Database._singleInstance();
  factory Database() => _instance;

  static final Box<dynamic>? _testBox;

  static Future<Box<dynamic>> get testBox async {
    return _testBox ?? await Hive.openBox("test");
  }

  static void write(Box box, dynamic key, dynamic value) {
    box.put(key, value);
  }

  static dynamic read(Box box, dynamic key) {
    return box.get(key);
  }

  static void delete(Box box, dynamic key) {
    box.delete(key);
  }

  static void clear(Box box, dynamic key) {
    box.clear();
  }
}
