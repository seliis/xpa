import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:xpa/presenter/index.dart";
import "package:xpa/router/index.dart";
import "package:xpa/entity/index.dart";
import "package:flutter/material.dart";
import "package:xpa/view/index.dart";

class Mission extends ConsumerWidget {
  const Mission({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final missionPackageDataNotifier = ref.watch(asyncMissionPackageDataProvider.notifier);
    final missionPackageData = ref.watch(asyncMissionPackageDataProvider);

    Container getHeader(MissionPackage missionPackage) {
      return Container(
        padding: const EdgeInsets.all(32),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(missionPackage.name),
              ],
            ),
            const Text("0%"),
          ],
        ),
      );
    }

    Container getBody(MissionPackage missionPackage) {
      return Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(32),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(missionPackage.desc),
            ElevatedButton(
              onPressed: () {
                RouteGraph.moveTo(
                  context,
                  TaskPage.routeName,
                  TaskPageArguments(
                    missionPackageName: missionPackage.name,
                  ),
                );
              },
              child: Row(
                children: const [
                  Icon(Icons.arrow_right_alt),
                  SizedBox(width: 4),
                  Text(
                    "CONTINUE",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    ExpansionPanelRadio getExpansionPanelRadio(MissionPackage missionPackage) {
      return ExpansionPanelRadio(
        value: missionPackage.id,
        canTapOnHeader: false,
        headerBuilder: (BuildContext context, bool isExpanded) {
          return getHeader(missionPackage);
        },
        body: getBody(missionPackage),
      );
    }

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(32),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  missionPackageDataNotifier.refreshMissionPackageData();
                },
                child: Row(
                  children: const [
                    Icon(Icons.refresh),
                    SizedBox(width: 4),
                    Text(
                      "REFRESH",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              Text(missionPackageDataNotifier.getAssignedQuantityStateMsg()),
            ],
          ),
        ),
        const Divider(),
        Expanded(
          child: missionPackageData.when(
            data: (dataList) {
              return SingleChildScrollView(
                child: ExpansionPanelList.radio(
                  children: dataList.map(getExpansionPanelRadio).toList(),
                ),
              );
            },
            loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            error: (error, stackTrace) {
              return CommonAsyncError(
                error: error,
                stackTrace: stackTrace,
              );
            },
          ),
        ),
      ],
    );
  }
}
