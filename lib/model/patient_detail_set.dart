class PatientDetailSet {
  final int id;
  final String? male;
  final String? female;
  final int? patient;
  final int? treatment;
  final String? treatmentName;

  PatientDetailSet({
    required this.id,
    this.male,
    this.female,
     this.patient,
     this.treatment,
     this.treatmentName,
  });

  factory PatientDetailSet.fromJson(Map<String, dynamic> json) {
    return PatientDetailSet(
      id: json['id'],
      male: json['male'] ?? "0",
      female: json['female'] ?? "0",
      patient: json['patient'],
      treatment: json['treatment'],
      treatmentName: json['treatment_name'],
    );
  }
}
