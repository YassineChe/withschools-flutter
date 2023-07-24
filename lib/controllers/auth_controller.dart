import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:withschools/helpers/auth_helper.dart';
//@helpers
import '/helpers/callback_helper.dart';
//@repositories
import '/repositories/auth_repository.dart';
//@model
import '/models/user.dart';

class AuthController extends GetxController {
  //@injections [private]
  AuthRepo? _authRepo;
  //@injection [public]
  CallbackHelper? callbackHelper;
  AuthHelper? authHelper;
  //@attributes
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  //@getters
  String get getEmailText => emailTextController.text;
  String get getPasswordText => passwordTextController.text;
  //@formkey
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  AuthController() {
    //injections
    _authRepo = Get.isRegistered<AuthRepo>() ? Get.find<AuthRepo>() : Get.put(AuthRepo());
    callbackHelper = Get.isRegistered<CallbackHelper>() ? Get.find<CallbackHelper>() : Get.put(CallbackHelper());
    //@inits
    emailTextController.text = 'ysn.cheddadi@gmail.com';
    passwordTextController.text = '123456';
  }

  //? On close
  @override
  void onClose() {
    emailTextController.dispose();
    passwordTextController.dispose();
  }

  //? Do login
  Future<dynamic> postLogin({@required email, @required password}) async {
    final user = await _authRepo?.tryPostLogin(
      email: email,
      password: password,
      deviceToken: null,
      deviceId: 'DEVICE_ID',
      deviceName: 'DEVICE_NAME',
    );

    // If the result is instance of User
    // We have to make Prefs and Navigate to Clue!
    if (user is User) {
      await AuthHelper().makePrefes(user).whenComplete(
        () {
          switch (user.guard) {
            case 'supervisor':
              Get.offAndToNamed('/supervisorClueView');
              break;
          }
        },
      );
    }
  }

  //************** VALIDATION EMAIL **************//
  String? validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return 'provideValidEmail'.tr;
    }
    return null;
  }

  //************** VALIDATION EMAIL **************//
  String? validatePassword(String value) {
    if (value.length < 6) {
      return 'passwordMust6'.tr;
    }
    return null;
  }
}
