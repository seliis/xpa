import "package:flutter/material.dart";
import "package:xpa/entity/index.dart";
import "package:xpa/view/index.dart";

class RouteGraph {
  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case TaskPage.routeName:
        return MaterialPageRoute(
          builder: (BuildContext context) => TaskPage(
            taskPageArguments: routeSettings.arguments as TaskPageArguments,
          ),
        );
      case HomePage.routeName:
        return MaterialPageRoute(builder: (BuildContext context) => const HomePage());
      default:
        return MaterialPageRoute(builder: (BuildContext context) => const HomePage());
    }
  }

  static void moveTo(BuildContext context, String routeName, [Object? arguments]) {
    Navigator.pushNamed(
      context,
      routeName,
      arguments: arguments,
    );
  }

  static void changeTo(BuildContext context, String routeName, [Object? arguments]) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      routeName,
      arguments: arguments,
      (route) => false,
    );
  }
}
