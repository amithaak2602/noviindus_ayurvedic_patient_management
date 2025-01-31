import 'dart:convert';
import 'package:noviindus_ayurvedic_patient_management/model/branch_model.dart';

class Treatment {
  int? id;
  List<Branch>? branchList;

  String? name;
  String? duration;

  double? price;

  bool? isActive;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? maleCount;
  int? femaleCount;
  List<Treatment>?treatmentList;
  Treatment({
    this.id,
    this.branchList,
    this.duration,
    this.name,
    this.price,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.maleCount,
    this.femaleCount,
    this.treatmentList,
  });

  factory Treatment.fromJson(Map<String, dynamic> json) => Treatment(
        id: json["id"],
        branchList:
            List<Branch>.from(json["branches"].map((x) => Branch.fromJson(x))),
        name: json["name"],
        duration: json["duration"],
        price: double.parse(json["price"]),
        isActive: json["is_active"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  static Treatment fromString(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);
    return Treatment.fromJson(json);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "branch": List<dynamic>.from((branchList ?? []).map((x) => x.toJson())),
        "name": name,
        "duration": duration,
        "price": price,
        "is_active": isActive,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
  Treatment copyWith({
    int? id,
    String? name,
    List<Branch>? branchList,
    String? duration,
    double? price,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? maleCount,
    int? femaleCount,
    List<Treatment>?treatmentList,
  }) =>
      Treatment(
        id: id ?? this.id,
        name: name ?? this.name,
        branchList: branchList ?? this.branchList,
        duration: duration ?? this.duration,
        price: price ?? this.price,
        isActive: isActive ?? this.isActive,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        maleCount: maleCount ?? this.maleCount,
        femaleCount: femaleCount ?? this.femaleCount,
        treatmentList: treatmentList??this.treatmentList,
      );
}
