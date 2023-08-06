import 'package:get/get.dart';
//@controllers
import '/controllers/supervisor_clue_controller.dart';
import '/controllers/journey_controller.dart';
//@repositories
import '/repositories/geofence_repository.dart';
import '/repositories/journey_repository.dart';
//@services & helpers
import '/helpers/callback_helper.dart';
import '/services/http_service.dart';

class SupervisorClueBinding extends Bindings {
  @override
  void dependencies() {
    //@helpers
    Get.put<CallbackHelper>(CallbackHelper());
    //@repositories
    Get.put<JourneyRepo>(JourneyRepo());
    Get.put<GeofenceRepo>(GeofenceRepo());
    //@controllers
    Get.put<SupervisorClueController>(SupervisorClueController());
    Get.put<JourneyController>(JourneyController());
    //@services
    Get.put<HttpService>(HttpService());
  }
}
