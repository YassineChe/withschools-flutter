import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:withschools/configs/colors.dart';
import 'package:withschools/sheets/supervisors/show_students_sheet.dart';
import 'package:withschools/widgets/global/avatar_widget.dart';
//@controllers
import '/controllers/journey_controller.dart';
//@widges
import '/widgets/global/no_data_widget.dart';

class JourneysSheet extends StatefulWidget {
  const JourneysSheet({super.key});

  @override
  State<JourneysSheet> createState() => _JourneysSheetState();
}

class _JourneysSheetState extends State<JourneysSheet> {
  //@injections ----------------------------------------------------------------
  final journeyController = Get.find<JourneyController>();
  //----------------------------------------------------------------------------

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      journeyController.getSupervisorJourneys();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return SizedBox(
          height: Get.height * .75,
          child: LoadingOverlay(
            isLoading: journeyController.callbackHelper!.isBusy(related: 'get-journeys').isTrue,
            child: journeyController.journeys!.isNotEmpty
                ? ListView(
                    children: [
                      ...journeyController.journeys!.map(
                        (journey) => Card(
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Theme.of(context).colorScheme.outline,
                            ),
                            borderRadius: const BorderRadius.all(Radius.circular(12)),
                          ),
                          child: Theme(
                            data: Theme.of(context).copyWith(dividerColor: transparent),
                            child: ExpansionTile(
                              leading: SizedBox(
                                height: Get.height,
                                child: const Icon(Icons.route),
                              ),
                              title: Text(
                                journey.name.toString(),
                                style: Theme.of(context).textTheme.headlineSmall,
                              ),
                              subtitle: Text(journey.createdAt.toString()),
                              children: [
                                //@driver
                                ListTile(
                                  leading: AvatarWidget(
                                    elevation: 1,
                                    path: journey.driver?.avatar,
                                  ),
                                  title: Text(journey.driver!.fullName.toString()),
                                  subtitle: const Text('Conducteur'),
                                  trailing: const Icon(Icons.chevron_right),
                                ),
                                //@bus
                                ListTile(
                                  leading: const CircleAvatar(
                                    radius: 25,
                                    child: Icon(
                                      Icons.directions_bus,
                                    ),
                                  ),
                                  title: Text(journey.bus!.brand.toString()),
                                  subtitle: Text(journey.bus!.registrationNumber.toString()),
                                  trailing: const Icon(Icons.chevron_right),
                                ),
                                //@studentsCount
                                ListTile(
                                  onTap: () => {
                                    showBarModalBottomSheet(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.zero,
                                      ),
                                      context: context,
                                      builder: (context) => ShowStudentsSheet(
                                        students: journey.students,
                                      ),
                                    )
                                  },
                                  leading: const CircleAvatar(
                                    radius: 25,
                                    child: Icon(
                                      Icons.groups_2,
                                    ),
                                  ),
                                  title: const Text('Écoliers'),
                                  subtitle: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        for (int i = 0; i < journey.studentsCount!; i++)
                                          if (i < 8)
                                            Align(
                                              widthFactor: .6,
                                              child: AvatarWidget(
                                                elevation: 3,
                                                borderColor: white,
                                                borderWidth: 2,
                                                raduis: 13,
                                                path: journey.students![i].avatar,
                                                viewer: false,
                                              ),
                                            ),
                                        if (journey.studentsCount! > 8)
                                          Align(
                                            widthFactor: .6,
                                            child: CircleAvatar(
                                              radius: 13,
                                              child: FittedBox(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(3),
                                                  child: Text(
                                                    '+${journey.studentsCount! - 8}',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  trailing: const Icon(Icons.chevron_right),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      child: const Text('Commencer le voyage'),
                                      onPressed: () => {
                                        //@get tutors journey
                                        journeyController.getTutorsJourneyPrepareMap(
                                          journeyId: journey.id,
                                        ),
                                        //@close modal
                                        Get.back(),
                                      },
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : NoDataWidget(
                    hint: 'Aucun voyage n\'a été trouvé',
                    subHint: 'Appuyez pour actualiser',
                    onPress: () => journeyController.getSupervisorJourneys(),
                    buttonText: 'Rafraîchir',
                  ),
          ),
        );
      },
    );
  }
}
