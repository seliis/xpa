import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:hive_flutter/hive_flutter.dart";
import "package:flutter/material.dart";
import "package:xpa/router/index.dart";
import "package:xpa/view/index.dart";

void main() async {
  await Hive.initFlutter();

  runApp(
    ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          //fontFamily: "NanumSquareNeo",
        ),
        initialRoute: HomePage.routeName,
        onGenerateRoute: RouteGraph.onGenerateRoute,
      ),
    ),
  );
}
