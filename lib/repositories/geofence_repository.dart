import 'package:get/get.dart';
//@models
import '/models/callback.dart';
//@services
import '/services/http_service.dart';

class GeofenceRepo {
  //@injections
  HttpService? _httpService;

  //@constructor
  GeofenceRepo() {
    //@injections
    _httpService = Get.find<HttpService>();
    //@inits
    _httpService?.init();
  }

  //@post geofence enter tutor
  Future<dynamic> tryPostGeofenceEnterTutor({String? tutorId}) async {
    try {
      final response = await _httpService?.postData(
        endpoint: '/post/geofence/enter/tutor',
        data: {'tutor_id': tutorId},
        related: 'post-geofence-entered',
      );

      return Callback.fromJson(response?.data);
    } catch (e) {
      return null;
    }
  }

  //@post genfence dwell tutor
  Future<dynamic> tryPostGeofenceDwellTutor({String? tutorId}) async {
    try {
      final response = await _httpService?.postData(
        endpoint: '/post/geofence/dwell/tutor',
        data: {'tutor_id': tutorId},
        related: 'post-geofence-dwell',
      );

      return Callback.fromJson(response?.data);
    } catch (e) {
      return null;
    }
  }
}
