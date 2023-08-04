import 'package:get/get.dart';
import 'package:withschools/models/callback.dart';
import 'package:withschools/services/http_service.dart';

class GeofenceRepo {
  //@injections
  HttpService? _httpService;

  //@constructor
  GeofenceRepo() {
    //* Check injection
    _httpService = Get.find<HttpService>();
    //* Inits
    _httpService?.init();
  }

  Future<dynamic> tryPostGeofenceEntered({String? tutorId}) async {
    try {
      final response = await _httpService?.postData(
        endpoint: '/post/geofence/entered/tutor',
        data: {'tutor_id': tutorId},
        related: 'post-geofence-entered',
      );

      return Callback.fromJson(response?.data);
    } catch (e) {
      return null;
    }
  }
}
