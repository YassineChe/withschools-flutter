import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CallbackHelper extends GetxController {
  //************ EXPECTED ***************** */
  RxMap<String, String> expecteds = RxMap();

  //@set
  Future setExpected({@required related, status}) async {
    expecteds.update(
      related,
      (value) => status,
      ifAbsent: () => status,
    );
  }

  //get status
  RxBool isBusy({@required related}) {
    return expecteds[related] == 'busy' ? true.obs : false.obs;
  }
}
