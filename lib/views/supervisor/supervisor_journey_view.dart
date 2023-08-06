import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:withschools/controllers/journey_controller.dart';
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
    final journeyController = Get.find<JourneyController>();
    //--------------------------------------------------------------------------

    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Voyage'),
          actions: [
            TextButton.icon(
              onPressed: () => {journeyController.setStartJourney(true)},
              icon: Icon(Icons.done),
              label: Text('cc'),
            )
          ],
        ),
        body: LoadingOverlay(
          isLoading: journeyController.callbackHelper!.isBusy(related: 'get-tutors').isTrue,
          child: Stack(
            children: [
              GoogleMap(
                markers: journeyController.markers.values.toSet(),
                circles: journeyController.circles.values.toSet(),
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                mapToolbarEnabled: false,
                initialCameraPosition: const CameraPosition(
                  target: LatLng(34.996454, -5.908670),
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
    });
  }
}
