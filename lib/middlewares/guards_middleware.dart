import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class GuardsMiddleware extends GetMiddleware {
  //* ATTRIBUTES **************************************************************/
  final box = GetStorage();
  //***************************************************************************/

  @override
  RouteSettings? redirect(String? route) {
    //? Check if manager is connected!
    if (box.hasData('token') && box.read('guard') == 'tutor') {
      return const RouteSettings(name: '/tutorClueView');
    }

    if (box.hasData('token') && box.read('guard') == 'supervisor') {
      return const RouteSettings(name: '/supervisorClueView');
    }

    return null;
  }
}
