// ignore_for_file: avoid_print

import "package:hive_flutter/hive_flutter.dart";
import "package:flutter_test/flutter_test.dart";
import "package:xpa/interactor/index.dart";

void main() async {
  Hive.init("test/database/hive/");

  test("Write and Read", () async {
    final Box<dynamic> testBox = await Database.testBox;
    Database.write(testBox, "testKey", "testValue");
    final dynamic data = Database.read(testBox, "testKey");
    print("$data (${data.runtimeType})");
  });
}
