import 'dart:async';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:withschools/helpers/callback_helper.dart';
import 'package:withschools/models/journey.dart';
import 'package:withschools/repositories/journey_repository.dart';

class JourneyController extends GetxController {
  //@injections [private]
  JourneyRepo? _journeyRepo;
  //@injections [public]
  CallbackHelper? callbackHelper;
  //@instances
  Completer<GoogleMapController> googleMapController = Completer();
  //@obx
  List<Journey>? journeys;

  //@constructors
  JourneyController() {
    _journeyRepo = Get.find<JourneyRepo>();
    callbackHelper = Get.find<CallbackHelper>();
    //@inits
    journeys = List<Journey>.empty();
  }

  Future<dynamic> getSupervisorJourneys() async {
    final response = await _journeyRepo?.tryGetSupervisorJourneys();

    if (response is List<Journey>) {
      journeys = response;
    }
  }
}
