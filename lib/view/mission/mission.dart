import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:xpa/entity/network/mission_package_data_response.dart";
import "package:xpa/presenter/screen/mission.dart";
import "package:flutter/material.dart";

class Mission extends ConsumerWidget {
  const Mission({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncMissionPackageDataResponse = ref.watch(asyncMissionPackageDataProvider);

    Container getHeader(MissionPackageDataResponse data) {
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

    Container getBody(MissionPackageDataResponse data) {
      return Container(
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
      );
    }

    ExpansionPanelRadio getExpansionPanelRadio(MissionPackageDataResponse data) {
      return ExpansionPanelRadio(
        value: data.id,
        canTapOnHeader: false,
        headerBuilder: (BuildContext context, bool isExpanded) {
          return getHeader(data);
        },
        body: getBody(data),
      );
    }

    return asyncMissionPackageDataResponse.when(
      data: (dataList) => SingleChildScrollView(
        child: ExpansionPanelList.radio(
          children: dataList.map(getExpansionPanelRadio).toList(),
        ),
      ),
      loading: () {
        return const Center(
          child: Text("Loading..."),
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
