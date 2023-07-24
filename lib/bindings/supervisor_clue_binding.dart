import 'package:get/get.dart';
import 'package:withschools/helpers/callback_helper.dart';
import 'package:withschools/repositories/journey_repository.dart';
import 'package:withschools/services/http_service.dart';
//@injections
import '/controllers/supervisor_clue_controller.dart';
import '/controllers/journey_controller.dart';

class SupervisorClueBinding extends Bindings {
  @override
  void dependencies() {
    //@helpers
    Get.put<CallbackHelper>(CallbackHelper());
    //@repositories
    Get.put<JourneyRepo>(JourneyRepo());
    //@controllers
    Get.put<SupervisorClueController>(SupervisorClueController());
    Get.put<JourneyController>(JourneyController());
    //@services
    Get.put<HttpService>(HttpService());
  }
}
