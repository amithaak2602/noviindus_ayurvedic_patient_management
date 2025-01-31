part of 'fetch_treatment_cubit.dart';

@immutable
abstract class FetchTreatmentState {}

class FetchTreatmentInitial extends FetchTreatmentState {}

class FetchTreatmentLoaded extends FetchTreatmentState {
  final List<Treatment> treatmentList;
  FetchTreatmentLoaded(this.treatmentList);
  List<Object>? get props => treatmentList;
}

class FetchTreatmentLoadFailed extends FetchTreatmentState {
  List<Object>? get props => [];
}
