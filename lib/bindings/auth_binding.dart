import 'package:get/get.dart';

//Bindings dependencies
import '/repositories/auth_repository.dart';
import '/controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRepo>(() => AuthRepo());
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
