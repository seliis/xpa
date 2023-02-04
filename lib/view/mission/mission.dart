import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:xpa/entity/network/mission_package_data_response.dart";
import "package:xpa/presenter/screen/mission.dart";
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
    final asyncMissionPackageDataResponse = ref.watch(asyncMissionPackageDataProvider);

    return asyncMissionPackageDataResponse.when(
      data: (dataList) => SingleChildScrollView(
        child: ExpansionPanelList.radio(
          children: dataList.map(
            (MissionPackageDataResponse data) {
              return ExpansionPanelRadio(
                value: data.id,
                canTapOnHeader: false,
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return Container(
                    padding: const EdgeInsets.all(32),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(data.missionPackageName),
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
                      Text(data.missionPackageInfo),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text("Continue"),
                      ),
                    ],
                  ),
                ),
              );
            },
          ).toList(),
        ),
      ),
      loading: () {
        return Container();
      },
      error: (error, stackTrace) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(error.toString()),
              const SizedBox(
                height: 16,
              ),
              Text(stackTrace.toString()),
            ],
          ),
        );
      },
    );
  }
}
