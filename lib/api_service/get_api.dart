import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:noviindus_ayurvedic_patient_management/model/branch_model.dart';
import 'package:noviindus_ayurvedic_patient_management/model/patient_details_model.dart';
import 'package:noviindus_ayurvedic_patient_management/model/treatment_model.dart';
import 'package:noviindus_ayurvedic_patient_management/screen/services/shared_preference.dart';
@singleton
class GetApiService {
  Shared shared;
  GetApiService({required this.shared});
  Future<List<Branch>> getBranchList() async {
    String baseUrl = "https://flutter-amr.noviindus.in/api/";
    String url = "${baseUrl}BranchList";

    try {
      Response response = await Dio().get(
        Uri.encodeFull(url),
        options: Options(
          headers: {
            'authorization': "Bearer ${shared.token}",
          },
        ),
      );
      Map<String, dynamic> data = json.decode('$response');
      if (data['status'] = true && data.containsKey('branches')) {
        List list = data['branches'];
        final branchList =
        List<Branch>.from(list.map((x) => Branch.fromJson(x)));
        return branchList;
      } else {
        return [];
      }
    } on DioException catch (e) {
      print(e.response?.data);
      return [];
    }
  }
  Future<List<Treatment>> getTreatmentList() async {
    String baseUrl = "https://flutter-amr.noviindus.in/api/";
    String url = "${baseUrl}TreatmentList";

    try {
      Response response = await Dio().get(
        Uri.encodeFull(url),
        options: Options(
          headers: {
            'authorization': "Bearer ${shared.token}",
          },
        ),
      );
      Map<String, dynamic> data = json.decode('$response');
      if (data['status'] = true && data.containsKey('treatments')) {
        List list = data['treatments'];
        final treatmentList =
        List<Treatment>.from(list.map((x) => Treatment.fromJson(x)));
        return treatmentList;
      } else {
        return [];
      }
    } on DioException catch (e) {
      print(e.response?.data);
      return [];
    }
  }

  Future<List<PatientDetail>> getPatientDetails() async {
    String baseUrl = "https://flutter-amr.noviindus.in/api/";
    String url = "${baseUrl}PatientList";

    try {
      Response response = await Dio().get(
        Uri.encodeFull(url),
        options: Options(
          headers: {
            'authorization': "Bearer ${shared.token}",
          },
        ),
      );
      Map<String, dynamic> data = json.decode('$response');
      print(data);
      if (data['status'] = true && data.containsKey('patient')) {
        List list = data['patient'];
        final patientList =
        List<PatientDetail>.from(list.map((x) => PatientDetail.fromJson(x)));
        return patientList;
      } else {
        return [];
      }
    } on DioException catch (e) {
      print(e.response?.data);
      return [];
    }
  }
}