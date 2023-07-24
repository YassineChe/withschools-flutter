import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SupervisorClueController extends GetxController {
  //clue view global key!
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  var tabIndex = 0;

  void changeTabIndex(int index) {
    tabIndex = index;
    update();
  }
}
