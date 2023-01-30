import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:xpa/entity/index.dart";

final screenProvider = StateProvider<ScreenPage>(
  (ref) {
    return ScreenPage.dashboard;
  },
);
