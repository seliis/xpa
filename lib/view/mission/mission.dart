import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter/material.dart";

class MissionCard extends ConsumerWidget {
  const MissionCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 24,
        ),
        alignment: Alignment.centerLeft,
        shape: const RoundedRectangleBorder(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "missionName",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
          Text("assignDate"),
        ],
      ),
    );
  }
}

class Mission extends ConsumerWidget {
  const Mission({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Container(
          //color: Colors.pink,
          width: MediaQuery.of(context).size.width * 0.2,
          child: ListView.separated(
            itemCount: 3,
            padding: const EdgeInsets.all(8),
            itemBuilder: (BuildContext context, int index) {
              return MissionCard();
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                height: 8,
              );
            },
          ),
        ),
        Expanded(
          child: Container(),
        ),
      ],
    );
  }
}
