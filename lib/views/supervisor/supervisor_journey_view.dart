import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:withschools/controllers/journey_controller.dart';
import 'package:withschools/controllers/supervisor_clue_controller.dart';
import 'package:withschools/sheets/supervisors/journeys_sheet.dart';

class SupervisorJourneyView extends StatefulWidget {
  const SupervisorJourneyView({super.key});

  @override
  State<SupervisorJourneyView> createState() => _SupervisorJourneyViewState();
}

class _SupervisorJourneyViewState extends State<SupervisorJourneyView> {
  @override
  Widget build(BuildContext context) {
    //@injections --------------------------------------------------------------
    final JourneyController journeyController =
        Get.isRegistered<JourneyController>() ? Get.find<JourneyController>() : Get.put(JourneyController());

    final SupervisorClueController supervisorClueController =
        Get.isRegistered<SupervisorClueController>() ? Get.find<SupervisorClueController>() : Get.put(SupervisorClueController());
    //--------------------------------------------------------------------------

    return Scaffold(
      appBar: AppBar(
        title: const Text('Voyage'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            myLocationButtonEnabled: false,
            initialCameraPosition: const CameraPosition(
              target: LatLng(34.9943171, -5.9092857),
              zoom: 15,
            ),
            onMapCreated: (GoogleMapController controller) {
              if (!journeyController.googleMapController.isCompleted) {
                journeyController.googleMapController.complete(controller);
              }
            },
          )
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            tooltip: 'Voyages',
            child: const Icon(Icons.route),
            onPressed: () {
              showBarModalBottomSheet(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                context: context,
                builder: (context) => const JourneysSheet(),
              );
            },
          )
        ],
      ),
    );
  }
}
