import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
//@helpers
import '/helpers/auth_helper.dart';
import '/helpers/snackbar_helper.dart';
//@models
import '/models/callback.dart';
//@configs
import '/configs/constants.dart';
//@services
import '/helpers/callback_helper.dart';

class HttpService {
  //@instances [private]
  Dio? _dio;
  //@instance [public]
  CallbackHelper? callbackHelper;

  HttpService() {
    //@check dependencies [callbackhelper]
    callbackHelper = Get.find<CallbackHelper>();
  }

  //? Post data API
  Future<Response> postData({
    @required endpoint,
    @required var data,
    @required related,
  }) async {
    return await _dio!.post(
      endpoint ?? '',
      data: data,
      options: Options(extra: {'related': related}),
    );
  }

  //? Fetch data API
  Future<Response> fetchData({
    @required endpoint,
    @required related,
    var data,
  }) async {
    return await _dio!.get(
      endpoint ?? '',
      queryParameters: data,
      options: Options(extra: {'related': related}),
    );
  }

  Future<Response> download({@required endpoint, var data}) async {
    return _dio!.download(endpoint, '', queryParameters: data);
  }

  //@edit data
  Future<Response> editData({
    @required endpoint,
    var data,
    @required related,
  }) async {
    return _dio!.put(
      endpoint ?? '',
      data: data,
      options: Options(extra: {'related': related}),
    );
  }

  //@patch data
  Future<Response> patchData({
    @required endpoint,
    var data,
    @required related,
  }) async {
    return _dio!.patch(
      endpoint ?? '',
      data: data,
      options: Options(extra: {'related': related}),
    );
  }

  //@delete data
  Future<Response> deleteData({
    @required endpoint,
    var data,
    @required related,
  }) async {
    return _dio!.delete(
      endpoint ?? '',
      data: data,
      options: Options(extra: {'related': related}),
    );
  }

  //@patch avatar
  Future<Response> patchAvatar({
    @required endpoint,
    var file,
    @required related,
  }) async {
    //Prepare filename
    String fileName = file.path.split('/').last;

    //Prepare formData
    FormData formData = FormData.fromMap({
      "avatar": await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),
    });

    return _dio!.post(
      endpoint ?? '',
      data: formData,
      options: Options(extra: {'related': related}),
    );
  }

  void init() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseApiUrl,
        headers: {
          'Accept': 'Content-Type: application/json',
          'Authorization': 'Bearer ${AuthHelper().getToken()}',
        },
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );
    _dio?.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          //@let's unit status
          callbackHelper?.setExpected(
            related: options.extra['related'],
            status: 'busy',
          );
          //@continue
          handler.next(options);
        },
        onResponse: (response, handler) {
          //@ Let's unit status
          callbackHelper?.setExpected(
            related: response.requestOptions.extra['related'],
            status: 'finished',
          );
          //@continue
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          switch (e.response?.statusCode) {
            case 422:
              final callback = Callback.fromJson(e.response?.data);
              SnackbarHelper().errorSnackBar(
                title: callback.message.toString(),
                message: callback.subMessage![0].toString(),
              );
              break;

            case 404:
              SnackbarHelper().errorSnackBar(
                title: 'Erreur',
                message: 'Content not found. Please try again later.',
              );
              break;

            case 503:
              SnackbarHelper().errorSnackBar(
                title: 'Erreur',
                message: 'Service Unavailable. Please try again later..',
              );
              break;

            case 401:
              SnackbarHelper().errorSnackBar(
                title: 'Erreur',
                message: 'Unauthorized. Please check your credentials and try again.',
              );

              //@remove any preferences and send user to login
              AuthHelper().logout().whenComplete(() => Get.offAllNamed('/loginView'));

              handler.reject;

              break;

            default:
              print(e.toString());

              SnackbarHelper().errorSnackBar(
                title: 'Erreur',
                message: 'Oops! Something went wrong. Please try again later or contact support for assistance.',
              );
              break;
          }

          //Why we throwing an exception here?
          //the answer is isBusy (exist in all controllers) doesn't stop spining
          //The solution was to throwing an regular exception if Dio has an error
          //Then methods -> repository will execute next instruction of the me of method
          //So allow related function to toggle isBusy.
          //@ Incase error's remove the related
          callbackHelper?.setExpected(
            related: e.requestOptions.extra['related'],
            status: 'finished',
          );

          throw Exception();
        },
      ),
    );
  }
}
