import 'package:flutter/material.dart';
import 'package:get/get.dart';
//Color constants
import '/configs/colors.dart';

class SnackbarHelper {
  void errorSnackBar({title, message}) async {
    Get.snackbar(
      title,
      message,
      colorText: white,
      backgroundColor: error,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
    );
  }

  void warningSnackBar({title, message}) async {
    Get.snackbar(
      title,
      message,
      colorText: white,
      backgroundColor: warning,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
    );
  }

  Future<void> successSnackBar({title, message}) async {
    Get.snackbar(
      title,
      message,
      colorText: white,
      backgroundColor: success,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
    );
  }
}
