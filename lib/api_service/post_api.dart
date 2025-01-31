import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:noviindus_ayurvedic_patient_management/screen/services/injection/injection.dart';
import 'package:noviindus_ayurvedic_patient_management/screen/services/shared_preference.dart';

@singleton
class PostApiService {
  String baseUrl = "https://flutter-amr.noviindus.in/api/";
  Future<bool> loginUserAccount() async {
    try {
      FormData formData = FormData.fromMap({
        'username': "test_user",
        'password': "12345678",
      });

      String url = "${baseUrl}Login";
      Response response = await Dio().post(
        url,
        data: formData,
      );
      if ((response.statusCode ?? 0) == 200) {
        Map<String, dynamic> responseDataMap = json.decode('$response');
        if (responseDataMap['status'] == true) {
          locator<Shared>().token = responseDataMap['token'];
        }
        return true;
      } else {
        return false;
      }
    } on DioException catch (e, st) {
      return false;
    }
  }
  Future registerPatient(data) async {
    try {
      String url = "${baseUrl}PatientUpdate";
      Response response = await Dio().post(
        Uri.encodeFull(url),
        data: data,
        options: Options(
          headers: {
            'authorization': "Bearer ${locator<Shared>().token}",
          },
        ),
      );
      print(response.data);
      if ((response.statusCode ?? 0) == 200) {
        Map<String, dynamic> responseDataMap = json.decode('$response');
        if (responseDataMap['status'] == true) {
        }
        return true;
      }
      return false;
    } on DioException catch (e, st) {
      print(e);
      print(st);
    }
  }
}
