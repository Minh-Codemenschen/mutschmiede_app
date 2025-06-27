// ignore_for_file: prefer_collection_literals, avoid_print, file_names, non_constant_identifier_names

import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mutschmiede/constants/AppConstants.dart';

import 'Api.dart';
import 'CustomDio.dart';

class ApiManager {
  Dio dio = CustomDio().client;

  Future<bool> checkInternet() async {
    try {
      final result = await InternetAddress.lookup('mutschmiede.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on Exception {
      return false;
    }
  }

  loginApi(voucherno, firebase_token) async {
    try {
      var res = await checkInternet();
      Response? response;
      if (res) {
        Map<String, String> queryparam = Map();
        queryparam['vouchernumber'] = voucherno;
        queryparam['firebase_token'] = firebase_token;
        response = await dio.get(
          Api.login,
          queryParameters: queryparam,
          options: Options(
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
          ),
        );
      } else {
        EasyLoading.showToast(AppConstants.txt_nointernet,
            toastPosition: EasyLoadingToastPosition.bottom);
      }

      return response;
    } on DioError catch (e) {
      print("Error");
      print(e.message);
      EasyLoading.showToast(AppConstants.txt_somethingwrong,
          toastPosition: EasyLoadingToastPosition.bottom);
    }
  }

  fetchusers() async {
    try {
      var res = await checkInternet();
      Response? response;
      if (res) {
        Map<String, String> queryparam = Map();
        response = await dio.get(
          Api.userlistall,
          queryParameters: queryparam,
          options: Options(
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
          ),
        );
      } else {
        EasyLoading.showToast(AppConstants.txt_nointernet,
            toastPosition: EasyLoadingToastPosition.bottom);
      }

      return response;
    } on DioError {
      EasyLoading.showToast(AppConstants.txt_somethingwrong,
          toastPosition: EasyLoadingToastPosition.bottom);
    }
  }

  fetchusersListAll() async {
    try {
      var res = await checkInternet();
      Response? response;
      if (res) {
        Map<String, String> queryparam = Map();
        response = await dio.get(
          Api.userlistall,
          queryParameters: queryparam,
          options: Options(
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
          ),
        );
      } else {
        EasyLoading.showToast(AppConstants.txt_nointernet,
            toastPosition: EasyLoadingToastPosition.bottom);
      }

      return response;
    } on DioError {
      EasyLoading.showToast(AppConstants.txt_somethingwrong,
          toastPosition: EasyLoadingToastPosition.bottom);
    }
  }

  categoryListApiCall(String id, String voucherno) async {
    try {
      var res = await checkInternet();
      Response? response;
      if (res) {
        Map<String, String> queryparam = Map();
        queryparam['vouchernumber'] = /*"56942346"*/ voucherno;
        var apiLink = "${Api.categoryList}$id&vouchernumber=$voucherno";
        print("users filter by category api>>$apiLink");
        response = await dio.get(
          apiLink,
          queryParameters: queryparam,
          options: Options(
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
          ),
        );
        return response;
      } else {
        EasyLoading.showToast(AppConstants.txt_nointernet,
            toastPosition: EasyLoadingToastPosition.bottom);
      }

      return response;
    } on DioError {
      EasyLoading.showToast(AppConstants.txt_somethingwrong,
          toastPosition: EasyLoadingToastPosition.bottom);
    }
  }

  usersList() async {
    try {
      var res = await checkInternet();
      Response? response;
      if (res) {
        Map<String, String> queryparam = Map();
        response = await dio.get(
          Api.userList,
          queryParameters: queryparam,
          options: Options(
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
          ),
        );
      } else {
        EasyLoading.showToast(AppConstants.txt_nointernet,
            toastPosition: EasyLoadingToastPosition.bottom);
      }
      log("${response!.data}");
      log("$response");
      log("${response.statusCode}");

      return response;
    } on DioError {
      EasyLoading.showToast(AppConstants.txt_somethingwrong,
          toastPosition: EasyLoadingToastPosition.bottom);
    }
  }

  fetchInboxMessageListAll(String data, String voucherno) async {
    try {
      var res = await checkInternet();
      Response? response;
      if (res) {
        Map<String, String> queryparam = {};
        queryparam['vouchernumber'] = /*"56942346"*/ voucherno;
        response = await dio.get(
          Api.inboxCall,
          queryParameters: queryparam,
          options: Options(
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
          ),
        );
      } else {
        EasyLoading.showToast(AppConstants.txt_nointernet,
            toastPosition: EasyLoadingToastPosition.bottom);
      }
      if (kDebugMode) {
        log("===============---------====>$response");
      }
      return response;
    } on DioError {
      EasyLoading.showToast(AppConstants.txt_somethingwrong,
          toastPosition: EasyLoadingToastPosition.bottom);
    }
  }

  checkCompanyStatusApi(voucherno) async {
    try {
      var res = await checkInternet();
      Response? response;
      if (res) {
        Map<String, String> queryparam = Map();
        queryparam['vouchernumber'] = voucherno;
        print(Api.checkCompanyStatus);
        print(queryparam.toString());
        response = await dio.get(
          Api.checkCompanyStatus,
          queryParameters: queryparam,
          options: Options(
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
          ),
        );
      } else {
        EasyLoading.showToast(AppConstants.txt_nointernet,
            toastPosition: EasyLoadingToastPosition.bottom);
      }
      print('checkCompanyStatusApi response');
      print(response.toString());
      return response;
    } on DioError {
      EasyLoading.showToast(AppConstants.txt_somethingwrong,
          toastPosition: EasyLoadingToastPosition.bottom);
    }
  }

  Sendmail(
      String? voucherno,
      String? firma,
      String? land,
      String? gmail,
      String? name,
      String? beschwerde,
      File? file,
      String? mitarbeiterIn,
      String? externer) async {
    try {
      print("enter send mail >>>>>");
      print("Api.sendMail");
      print(Api.sendMail);
      var res = await checkInternet();
      Response? response;
      if (res) {
        FormData formData = FormData.fromMap({
          'vouchernumber': voucherno ?? '',
          'firma': firma ?? '',
          'land': land ?? '',
          'email': gmail ?? '',
          'namen_des_absenders': name ?? '',
          'beschwerde': beschwerde ?? '',
          'file': file != null &&
                  file.path != null &&
                  file.path.isNotEmpty &&
                  File(file.path).existsSync()
              ? await MultipartFile.fromFile(file.path,
                  filename: file.path.split('/').last)
              : "",
          'mitarbeiterin': mitarbeiterIn,
          'externer': externer,
        });
        print(formData.fields);
        response = await dio.post(Api.sendMail, data: formData);
        print("response *****");
        print(response);
      } else {
        EasyLoading.showToast(AppConstants.txt_nointernet,
            toastPosition: EasyLoadingToastPosition.bottom);
      }
      return response;
    } on DioError catch (e) {
      print('error');
      print(e);
      print(e.toString());
      EasyLoading.showToast(AppConstants.txt_somethingwrong,
          toastPosition: EasyLoadingToastPosition.bottom);
    }
  }

//78506670 //40552880
  aktuelLes(String voucherno) async {
    try {
      var res = await checkInternet();
      Response? response;
      if (res) {
        print('Api.kooperatiosPartner >>');
        print(Api.kooperatiosPartner);
        Map<String, String> queryparam = {};
        queryparam['vouchernumber'] = /*"56942346"*/ voucherno;
        print(queryparam);
        response = await dio.get(
          Api.kooperatiosPartner,
          queryParameters: queryparam,
          options: Options(
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
          ),
        );
      } else {
        EasyLoading.showToast(AppConstants.txt_nointernet,
            toastPosition: EasyLoadingToastPosition.bottom);
      }
      if (kDebugMode) {
        log("========---------=====>$response");
      }
      return response;
    } on DioError {
      EasyLoading.showToast(AppConstants.txt_somethingwrong,
          toastPosition: EasyLoadingToastPosition.bottom);
    }
  }

  fetchApiCallDashboard(voucherno) async {
    try {
      var res = await checkInternet();
      Response? response;
      if (res) {
        log("$res");
        log("$response");
        Map<String, String> queryparam = {};
        queryparam['vouchernumber'] = /*"56942346"*/ voucherno;
        response = await dio.get(
          Api.dashboardCall,
          queryParameters: queryparam,
          options: Options(
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
          ),
        );
        print("response >>> $response");
      } else {
        EasyLoading.showToast(AppConstants.txt_nointernet,
            toastPosition: EasyLoadingToastPosition.bottom);
      }
      log("$response");
      return response;
    } on DioError catch (e) {
      print(e);
      EasyLoading.showToast(AppConstants.txt_somethingwrong,
          toastPosition: EasyLoadingToastPosition.bottom);
    }
  }

  mainProfile(String voucherno) async {
    try {
      var res = await checkInternet();
      Response? response;
      if (res) {
        Map<String, String> queryparam = {};
        queryparam['vouchernumber'] = /*"10728771"*/ voucherno;

        response = await dio.get(
          Api.profile,
          queryParameters: queryparam,
          options: Options(
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
          ),
        );
      } else {
        EasyLoading.showToast(AppConstants.txt_nointernet,
            toastPosition: EasyLoadingToastPosition.bottom);
      }

      return response;
    } on DioError {
      EasyLoading.showToast(AppConstants.txt_somethingwrong,
          toastPosition: EasyLoadingToastPosition.bottom);
    }
  }

  updateProfile(
    String voucherno,
    String email,
    String name,
    String gender,
    String phone,
    String department,
    String kunde,
    String standort,
    String subject_areas,
    File imageFile,
  ) async {
    try {
      var res = await checkInternet();
      Response? response;
      if (res) {
        String fileName = imageFile.path.split('/').last;
        FormData formData = FormData.fromMap({
          'voucher_number': voucherno,
          'name': name,
          'email': email,
          'gender': gender,
          'phone': phone,
          'department': department,
          'kunde': kunde,
          'standort': standort,
          'subject_areas': subject_areas,
          'async_upload':
              await MultipartFile.fromFile(imageFile.path, filename: fileName),

          // 'image': await MultipartFile.fromFile(imageFile.path, filename: fileName)
        });
        response = await dio.post(
          Api.updateProfile,
          data: formData,
        );
      } else {
        EasyLoading.showToast(AppConstants.txt_nointernet,
            toastPosition: EasyLoadingToastPosition.bottom);
      }
      log("${response!.data}");
      return response;
    } on DioError {
      EasyLoading.showToast(AppConstants.txt_somethingwrong,
          toastPosition: EasyLoadingToastPosition.bottom);
    }
  }

  zusagenDashboard(post_id, bool iscancel) async {
    try {
      var res = await checkInternet();
      Response? response;
      if (res) {
        log("========---------=====>$response");
        Map<String, String> queryparam = {};
        queryparam['post_id'] = '$post_id';
        if (iscancel) {
          queryparam['cancel'] = '1';
        } else {
          queryparam['accept'] = '1';
        }
        response = await dio.post(
          Api.zusagen,
          queryParameters: queryparam,
          options: Options(
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
          ),
        );
      } else {
        EasyLoading.showToast(AppConstants.txt_nointernet,
            toastPosition: EasyLoadingToastPosition.bottom);
      }

      return response;
    } catch (e) {
      EasyLoading.showToast(AppConstants.txt_somethingwrong,
          toastPosition: EasyLoadingToastPosition.bottom);
    }
  }

  fetchApiCalendar(String date, String voucherno) async {
    try {
      var res = await checkInternet();
      Response? response;
      if (res) {
        Map<String, String> queryparam = {};
        queryparam['vouchernumber'] = voucherno;
        queryparam['date'] = date;
        response = await dio.get(
          Api.calendarAPICall,
          queryParameters: queryparam,
          options: Options(
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
          ),
        );
      } else {
        EasyLoading.showToast(AppConstants.txt_nointernet,
            toastPosition: EasyLoadingToastPosition.bottom);
      }
      if (kDebugMode) {
        log("$response");
      }
      return response;
    } on DioError {
      EasyLoading.showToast(AppConstants.txt_somethingwrong,
          toastPosition: EasyLoadingToastPosition.bottom);
    }
  }

  whistleKeeperProgram() async {
    try {
      var res = await checkInternet();
      Response? response;
      if (res) {
        Map<String, String> queryparam = Map();
        print("======");
        print(queryparam);
        response = await dio.get(
          Api.whistleKeeperProgram,
          queryParameters: queryparam,
          options: Options(
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
          ),
        );
      } else {
        EasyLoading.showToast(AppConstants.txt_nointernet,
            toastPosition: EasyLoadingToastPosition.bottom);
      }

      return response;
    } on DioError {
      EasyLoading.showToast(AppConstants.txt_somethingwrong,
          toastPosition: EasyLoadingToastPosition.bottom);
    }
  }

  videoTrainer(String voucherno) async {
    try {
      var res = await checkInternet();
      Response? response;
      if (res) {
        print('Api.videoTrainer >>');
        print(Api.videoTrainer);
        Map<String, String> queryparam = {};
        queryparam['vouchernumber'] = voucherno;
        response = await dio.get(
          Api.videoTrainer,
          queryParameters: queryparam,
          options: Options(
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
          ),
        );
      } else {
        EasyLoading.showToast(AppConstants.txt_nointernet,
            toastPosition: EasyLoadingToastPosition.bottom);
      }
      if (kDebugMode) {
        log("========---------=====>$response");
      }
      return response;
    } on DioError {
      EasyLoading.showToast(AppConstants.txt_somethingwrong,
          toastPosition: EasyLoadingToastPosition.bottom);
    }
  }

  apiGetSpiele() async {
    try {
      var res = await checkInternet();
      Response? response;
      if (res) {
        Map<String, String> queryparam = Map();
        response = await dio.get(
          Api.apiGetSpiele,
          queryParameters: queryparam,
          options: Options(
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
          ),
        );
      } else {
        EasyLoading.showToast(AppConstants.txt_nointernet,
            toastPosition: EasyLoadingToastPosition.bottom);
      }

      return response;
    } on DioError {
      EasyLoading.showToast(AppConstants.txt_somethingwrong,
          toastPosition: EasyLoadingToastPosition.bottom);
    }
  }

  callPhoneNumber(
      int? voucherno,
      int? phoneNumber,
      int? type,
      ) async {
    try {
      print("enter send mail >>>>>");
      print("Api.sendMail");
      print(Api.sendMail);
      var res = await checkInternet();
      Response? response;
      if (res) {
        FormData formData = FormData.fromMap({
          'voucher_number': voucherno ?? '',
          'phonenumber': phoneNumber ?? '',
          'type': type ?? '',
        });
        print(formData.fields);
        response = await dio.post(Api.sendPhoneNumber, data: formData);
        print("response *****");
        print(response);
      } else {
        EasyLoading.showToast(AppConstants.txt_nointernet,
            toastPosition: EasyLoadingToastPosition.bottom);
      }
      return response;
    } on DioError catch (e) {
      print('error');
      print(e);
      print(e.toString());
      EasyLoading.showToast(AppConstants.txt_somethingwrong,
          toastPosition: EasyLoadingToastPosition.bottom);
    }
  }
}
