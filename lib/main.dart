import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter/material.dart";
import "package:xpa/router/index.dart";

void main() {
  runApp(
    ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          fontFamily: "NanumSquareNeo",
        ),
        initialRoute: NavigateGraph.homePage,
        onGenerateRoute: NavigateGraph.onGenerateRoute,
      ),
    ),
  );
}
