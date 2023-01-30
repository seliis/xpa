import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter/material.dart";
import "package:xpa/view/index.dart";

void main() {
  runApp(
    ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: "NanumSquareNeo",
        ),
        home: const Frame(),
      ),
    ),
  );
}
