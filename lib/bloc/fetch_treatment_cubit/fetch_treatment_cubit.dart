import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:noviindus_ayurvedic_patient_management/api_service/get_api.dart';
import 'package:noviindus_ayurvedic_patient_management/model/treatment_model.dart';

part 'fetch_treatment_state.dart';
@singleton
class FetchTreatmentCubit extends Cubit<FetchTreatmentState> {
  FetchTreatmentCubit(this.getApiService) : super(FetchTreatmentInitial());
  final GetApiService getApiService;
  Future<void> fetchTreatment() async {
    final data = await getApiService.getTreatmentList();
    if (data != null) {
      emit(FetchTreatmentLoaded(data));
    } else {
      emit(FetchTreatmentLoadFailed());
    }
  }
}
