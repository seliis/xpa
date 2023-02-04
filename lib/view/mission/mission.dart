import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter/material.dart";

class Mission extends ConsumerWidget {
  Mission({super.key});

  final List<Map<String, dynamic>> _dummyData = List.generate(
    1,
    (int index) {
      return {
        "index": index,
      };
    },
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: ExpansionPanelList.radio(
        children: _dummyData.map(
          (Map<String, dynamic> data) {
            return ExpansionPanelRadio(
              value: data["index"],
              canTapOnHeader: false,
              headerBuilder: (BuildContext context, bool isExpanded) {
                return Container(
                  padding: const EdgeInsets.all(32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: const [
                          Text("MISSION_PACKAGE_NAME"),
                        ],
                      ),
                      const Text("100%"),
                    ],
                  ),
                );
              },
              body: Container(
                color: Colors.black26,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("MISSION_PACKAGE_INFO"),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text("CONTINUE"),
                    ),
                  ],
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
