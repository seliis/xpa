import "package:flutter/material.dart";
import "package:xpa/view/index.dart";

class NavigateGraph {
  static const String homePage = "homePage";
  static const String taskPage = "taskPage";

  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case taskPage:
        return MaterialPageRoute(builder: (BuildContext context) => const TaskPage());
      case homePage:
        return MaterialPageRoute(builder: (BuildContext context) => const HomePage());
      default:
        return MaterialPageRoute(builder: (BuildContext context) => const HomePage());
    }
  }

  static void moveTo(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
  }

  static void changeTo(BuildContext context, String routeName) {
    Navigator.pushNamedAndRemoveUntil(context, routeName, (route) => false);
  }
}
