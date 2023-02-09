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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  missionPackage.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w300,
                    color: Colors.pink,
                    fontSize: 24,
                  ),
                ),
                Text(
                  "[${missionPackage.info.updatedAt}] Updated By ${missionPackage.info.updatedBy}",
                  style: const TextStyle(
                    fontFamily: FontName.jetBrainsMono,
                    fontWeight: FontWeight.w100,
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                Text(
                  "[${missionPackage.info.grantedAt}] Granted By ${missionPackage.info.grantedBy}",
                  style: const TextStyle(
                    fontFamily: FontName.jetBrainsMono,
                    fontWeight: FontWeight.w100,
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
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
            Flexible(
              child: Container(
                alignment: Alignment.centerLeft,
                width: MediaQuery.of(context).size.width * 0.50,
                child: RichText(
                  text: TextSpan(
                    text: missionPackage.desc,
                    style: const TextStyle(
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
            CCElevatedButtonWithIcon(
              iconData: Icons.arrow_right_alt,
              buttonText: "Continue",
              onPressed: () {
                RouteGraph.moveTo(
                  context,
                  TaskPage.routeName,
                  TaskPageArguments(
                    missionPackageName: missionPackage.name,
                  ),
                );
              },
            ),
          ],
        ),
      );
    }

    ExpansionPanelRadio getExpansionPanelRadio(MissionPackage missionPackage, int index) {
      return ExpansionPanelRadio(
        value: index,
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
              CCElevatedButtonWithIcon(
                iconData: Icons.refresh,
                buttonText: "Refresh",
                onPressed: () {
                  missionPackageDataNotifier.refreshMissionPackageData();
                },
              ),
              Text(missionPackageDataNotifier.getAssignedQuantityStateMsg()),
            ],
          ),
        ),
        const Divider(),
        Expanded(
          child: missionPackageData.when(
            data: (List<MissionPackage> dataList) {
              return SingleChildScrollView(
                child: ExpansionPanelList.radio(
                  children: [
                    for (int index = 0; index < dataList.length; index++) ...[
                      getExpansionPanelRadio(dataList[index], index),
                    ],
                  ],
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
