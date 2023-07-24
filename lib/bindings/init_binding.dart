import 'package:get/get.dart';
//Bindings dependencies
import '/helpers/callback_helper.dart';
import '/services/http_service.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    //Services
    Get.lazyPut<HttpService>(() => HttpService());
    Get.lazyPut<CallbackHelper>(() => CallbackHelper());
  }
}
