import 'dart:convert';

import 'package:noviindus_ayurvedic_patient_management/model/branch_model.dart';

// List<Patient> patientFromJson(String str) =>
//     List<Patient>.from(json.decode(str).map((x) => Patient.fromJson(x)));

String patientToJson(List<Patient> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Patient {
  String? id;

  // List<PatientDetail> patientdetailsSet;
  Branch? branch;
  String? user;
  String? payment;
  String? name;
  String? phone;
  String? address;
  double? price;
  double? totalAmount;
  double? discountAmount;
  double? advanceAmount;
  double? balanceAmount;
  DateTime? dateNdTime;
  bool? isActive;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<int>? male;
  List<int>? female;
  List<int>? treatments;

  Patient(
      {this.id,
      // this.patientdetailsSet,
      this.branch,
      this.user,
      this.payment,
      this.name,
      this.phone,
      this.address,
      this.price,
      this.totalAmount,
      this.discountAmount,
      this.advanceAmount,
      this.balanceAmount,
      this.dateNdTime,
      this.isActive,
      this.createdAt,
      this.updatedAt,
      this.female,
      this.male,
      this.treatments});

  // Welcome copyWith({
  //   int? id,
  //   List<Patientdetail>? patientdetailsSet,
  //   Branch? branch,
  //   String? user,
  //   String? payment,
  //   String? name,
  //   String? phone,
  //   String? address,
  //   dynamic price,
  //   int? totalAmount,
  //   int? discountAmount,
  //   int? advanceAmount,
  //   int? balanceAmount,
  //   DateTime? dateNdTime,
  //   bool? isActive,
  //   DateTime? createdAt,
  //   DateTime? updatedAt,
  // }) =>
  //     Welcome(
  //       id: id ?? this.id,
  //       patientdetailsSet: patientdetailsSet ?? this.patientdetailsSet,
  //       branch: branch ?? this.branch,
  //       user: user ?? this.user,
  //       payment: payment ?? this.payment,
  //       name: name ?? this.name,
  //       phone: phone ?? this.phone,
  //       address: address ?? this.address,
  //       price: price ?? this.price,
  //       totalAmount: totalAmount ?? this.totalAmount,
  //       discountAmount: discountAmount ?? this.discountAmount,
  //       advanceAmount: advanceAmount ?? this.advanceAmount,
  //       balanceAmount: balanceAmount ?? this.balanceAmount,
  //       dateNdTime: dateNdTime ?? this.dateNdTime,
  //       isActive: isActive ?? this.isActive,
  //       createdAt: createdAt ?? this.createdAt,
  //       updatedAt: updatedAt ?? this.updatedAt,
  //     );
  //
  // factory Patient.fromJson(Map<String, dynamic> json) => Patient(
  //   id: json["id"],
  //   patientdetailsSet: List<PatientDetail>.from(
  //       json["patientdetails_set"].map((x) => PatientDetail.fromJson(x))),
  //   branch: Branch.fromJson(json["branch"]),
  //   user: json["user"]??"",
  //   payment: json["payment"]??"",
  //   name: json["name"],
  //   phone: json["phone"],
  //   address: json["address"],
  //   price: json["price"] ?? 0,
  //   totalAmount: json["total_amount"],
  //   discountAmount: json["discount_amount"],
  //   advanceAmount: double.parse(json["advance_amount"]),
  //   balanceAmount: json["balance_amount"],
  //   dateNdTime: DateTime.parse(json["date_nd_time"]),
  //   isActive: json["is_active"],
  //   createdAt: DateTime.parse(json["created_at"]),
  //   updatedAt: DateTime.parse(json["updated_at"]),
  // );

  Map<String, dynamic> toJson() => {
        "id": "",
        "executive": "",
        // "patientdetails_set":
        // List<dynamic>.from(patientdetailsSet.map((x) => x.toJson())),
         "branch": branch?.toJson(),
        "payment": payment,
        "name": name,
        "phone": phone,
        "address": address,
        "total_amount": totalAmount,
        "discount_amount": discountAmount,
        "advance_amount": advanceAmount,
        "balance_amount": balanceAmount,
        "date_nd_time": dateNdTime?.toIso8601String(),
        "male": male,
        "female": female,
        "treatments": treatments,
      };
}
