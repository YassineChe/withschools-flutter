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
  Future<dynamic> tryPostGeofenceEnterTutor({int? tutorId, int? journeyId}) async {
    try {
      final response = await _httpService?.postData(
        endpoint: '/post/geofence/enter',
        data: {'tutor_id': tutorId, 'journey_id': journeyId},
        related: 'callback-geofence',
      );

      return Callback.fromJson(response?.data);
    } catch (e) {
      return null;
    }
  }

  //@post genfence dwell tutor
  Future<dynamic> tryPostGeofenceDwellTutor({int? tutorId, int? journeyId}) async {
    try {
      final response = await _httpService?.postData(
        endpoint: '/post/geofence/dwell',
        data: {'tutor_id': tutorId, 'journey_id': journeyId},
        related: 'callback-geofence',
      );

      return Callback.fromJson(response?.data);
    } catch (e) {
      return null;
    }
  }
}
