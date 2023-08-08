import 'package:get/get.dart';
//@models
import '/models/mqtt.dart';
//@services
import '/services/http_service.dart';

class MqttRepo {
  //@injections
  HttpService? _httpService;

  //@constructor
  MqttRepo() {
    //@injections
    _httpService = Get.find<HttpService>();
    //@inits
    _httpService?.init();
  }

  //@post geofence enter tutor
  Future<dynamic> tryGetSupervisorMqtt() async {
    try {
      final response = await _httpService?.fetchData(
        endpoint: '/get/supervisor/mqtt',
        related: 'get-mqtt',
      );

      return Mqtt.fromJson(response?.data);
    } catch (e) {
      return null;
    }
  }
}
