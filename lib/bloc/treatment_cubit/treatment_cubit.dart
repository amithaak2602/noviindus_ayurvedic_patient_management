import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:noviindus_ayurvedic_patient_management/model/treatment_model.dart';

@singleton
class TreatmentCubit extends Cubit<Treatment> {
  TreatmentCubit() : super(Treatment());
  Future<void> addTreatment(Treatment treatment) async {
    emit(treatment);
  }

  Future<void> updateTreatment(Treatment treatment) async {
    print("treatment list length ${state.treatmentList?.length}");
    final newState = List<Treatment>.from(state.treatmentList ?? []).toList();
    print(newState.length);
    newState.add(treatment);
    emit(state.copyWith(treatmentList: newState));
  }
}
