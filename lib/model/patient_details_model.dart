import 'package:noviindus_ayurvedic_patient_management/model/branch_model.dart';
import 'package:noviindus_ayurvedic_patient_management/model/patient_detail_set.dart';

class PatientDetail {
  int? id;
  String? male;
  String? female;
  int? patient;
  int? treatment;
  String? treatmentName;
  final List<PatientDetailSet>? patientDetails;
  final Branch? branch;
  final String? user;
  final String? payment;
  final String? name;
  final String? phone;
  final String? address;
  final double? price;
  final double? totalAmount;
  final double? discountAmount;
  final double? advanceAmount;
  final double? balanceAmount;
  final String? dateTime;

  PatientDetail({
    this.id,
    this.male,
    this.female,
    this.patient,
    this.treatment,
    this.treatmentName,
    this.patientDetails,
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
    this.dateTime,
  });

  PatientDetail copyWith({
    int? id,
    String? male,
    String? female,
    int? patient,
    int? treatment,
    String? treatmentName,
  }) =>
      PatientDetail(
        id: id ?? this.id,
        male: male ?? this.male,
        female: female ?? this.female,
        patient: patient ?? this.patient,
        treatment: treatment ?? this.treatment,
        treatmentName: treatmentName ?? this.treatmentName,
      );

  factory PatientDetail.fromJson(Map<String, dynamic> json) {
    return PatientDetail(
        id: json['id'],
        patientDetails: (json['patientdetails_set'] as List)
            .map((item) => PatientDetailSet.fromJson(item))
            .toList(),
        branch: null != json['branch']?Branch.fromJson(json['branch']):Branch(),
        user: json['user'],
        payment: json['payment'],
        name: json['name'],
        phone: json['phone'],
        address: json['address'],
        price: json['price']?.toDouble(),
        totalAmount: (json['total_amount'] ?? 0).toDouble(),
        discountAmount: (json['discount_amount'] ?? 0).toDouble(),
        advanceAmount: (json['advance_amount'] ?? 0).toDouble(),
        balanceAmount: (json['balance_amount'] ?? 0).toDouble(),
        dateTime: json['date_nd_time'],
      );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "male": male,
        "female": female,
        "patient": patient,
        "treatment": treatment,
        "treatment_name": treatmentName,
      };
}
