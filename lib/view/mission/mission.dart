import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:xpa/presenter/screen/mission.dart";
import "package:xpa/router/index.dart";
import "package:xpa/entity/index.dart";
import "package:flutter/material.dart";
import "package:xpa/view/index.dart";

class Mission extends ConsumerWidget {
  const Mission({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final missionPackageDataProvider = ref.watch(asyncMissionPackageDataProvider);
    final missionPackageDataNotifier = ref.watch(asyncMissionPackageDataProvider.notifier);

    Container getHeader(MissionPackageData data) {
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
    }

    Container getBody(MissionPackageData data) {
      return Container(
        color: Colors.black26,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(32),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(data.missionPackageInfo.description),
            ElevatedButton(
              onPressed: () {
                NavigateGraph.moveTo(
                  context,
                  TaskPage.routeName,
                  TaskPageArguments(
                    missionPackageName: data.missionPackageName,
                  ),
                );
              },
              child: const Text("Continue"),
            ),
          ],
        ),
      );
    }

    ExpansionPanelRadio getExpansionPanelRadio(MissionPackageData data) {
      return ExpansionPanelRadio(
        value: data.id,
        canTapOnHeader: false,
        headerBuilder: (BuildContext context, bool isExpanded) {
          return getHeader(data);
        },
        body: getBody(data),
      );
    }

    return missionPackageDataProvider.when(
      data: (dataList) => Column(
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
                  child: const Text("Refresh"),
                ),
                Text("${dataList.length.toString()} Assigned Missions"),
              ],
            ),
          ),
          SingleChildScrollView(
            child: ExpansionPanelList.radio(
              children: dataList.map(getExpansionPanelRadio).toList(),
            ),
          ),
        ],
      ),
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
      error: (error, stackTrace) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                error.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.red,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                stackTrace.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
