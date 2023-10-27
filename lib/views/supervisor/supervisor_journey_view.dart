import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:get/get.dart';
//@sheet
import '/sheets/supervisors/journeys_sheet.dart';
//@controllers
import '/controllers/journey_controller.dart';

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
            if (journeyController.getSelectedJourneyId == null) ...[
              TextButton.icon(
                onPressed: () => {
                  showBarModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    context: context,
                    builder: (context) => const JourneysSheet(),
                  )
                },
                icon: const Icon(Icons.route_rounded),
                label: const Text('Voyages'),
              ),
            ] else ...[
              TextButton.icon(
                onPressed: () => {journeyController.stopJourney()},
                icon: const Icon(Icons.stop_circle),
                label: const Text('Arrêter le voyage'),
              ),
            ],
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
                onCameraMove: (CameraPosition cameraPosition) => {
                  journeyController.setFingerUsed(true),
                  journeyController.sertZoom(cameraPosition.zoom),
                },
                initialCameraPosition: CameraPosition(
                  target: LatLng(journeyController.getSchoolLat, journeyController.getSchoolLng),
                  zoom: journeyController.getZoom,
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
            //@bus focus
            FloatingActionButton(
              tooltip: 'Autobus',
              child: const Icon(Icons.directions_bus),
              onPressed: () => {
                journeyController.sertZoom(17),
                journeyController.focusOnBus(),
                journeyController.setFingerUsed(false),
              },
            ),
          ],
        ),
      );
    });
  }
}
