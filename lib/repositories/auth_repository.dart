import 'package:get/get.dart';
//Models
import '/models/user.dart';
//Services
import '/services/http_service.dart';

class AuthRepo {
  //@injections
  HttpService? _httpService;

  //@constructor
  AuthRepo() {
    //* Check injection
    _httpService = Get.find<HttpService>();
    //* Inits
    _httpService?.init();
  }

  //? Try do Login
  Future<dynamic> tryPostLogin({
    String? email,
    String? password,
    String? deviceToken,
    String? deviceId,
    String? deviceName,
  }) async {
    try {
      final response = await _httpService?.postData(
        endpoint: '/post/signin/token',
        data: {
          'email': email,
          'password': password,
          'device_token': deviceToken,
          'device_id': deviceId,
          'device_name': deviceName
        },
        related: 'post-signin',
      );
      //Give us a valid user
      return User.fromJson(response?.data);
      //Catch custom exception
    } catch (e) {
      return null;
    }
  }
}
