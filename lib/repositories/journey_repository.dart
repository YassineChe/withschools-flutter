import 'package:get/get.dart';
import 'package:withschools/models/journey.dart';
import 'package:withschools/services/http_service.dart';

class JourneyRepo {
  //@injections
  HttpService? _httpService;

  //@constructor
  JourneyRepo() {
    //* Check injection
    _httpService = Get.find<HttpService>();
    //* Inits
    _httpService?.init();
  }

  Future<dynamic> tryGetSupervisorJourneys() async {
    try {
      final response = await _httpService?.fetchData(
        endpoint: '/get/supervisor/journeys',
        related: 'get-journeys',
      );

      return (response?.data as List<dynamic>).map((journey) => Journey.fromJson(journey)).toList();
    } catch (e) {
      print(e);
      return null;
    }
  }
}
