import 'package:get/get.dart';
import 'package:withschools/models/callback.dart';
import 'package:withschools/repositories/geofence_repository.dart';

class GeofenceController extends GetxController {
  //@injections [private]
  GeofenceRepo? _geofenceRepo;

  //@constructor
  GeofenceController() {
    _geofenceRepo = Get.find<GeofenceRepo>();
  }

  //@post geofence intered
  //? Do login
  Future<dynamic> postGeofenceIntered({String? tutorId}) async {
    final response = await _geofenceRepo?.tryPostGeofenceEntered(
      tutorId: tutorId,
    );

    if (response is Callback) {
      //DONE
    }
  }
}
