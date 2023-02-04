import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter/material.dart";
import "homepage_appbar.dart";
import "homepage_drawer.dart";
import "homepage_screen.dart";

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: HomePageAppBar(),
      drawer: const HomePageDrawer(),
      body: const HomePageScreen(),
    );
  }
}
