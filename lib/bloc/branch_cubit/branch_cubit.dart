import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:noviindus_ayurvedic_patient_management/api_service/get_api.dart';
import 'package:noviindus_ayurvedic_patient_management/model/branch_model.dart';

part 'branch_state.dart';
 @singleton
class BranchCubit extends Cubit<BranchState> {
  BranchCubit(this.getApiService) : super(BranchInitial());
  final GetApiService getApiService;
  Future<void> fetchBranchData() async {
    final data = await getApiService.getBranchList();
    if (data != null) {
      emit(BranchLoaded(data));
    } else {
      emit(BranchLoadFailed());
    }
  }
}
