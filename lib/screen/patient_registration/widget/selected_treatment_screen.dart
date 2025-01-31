import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noviindus_ayurvedic_patient_management/bloc/treatment_cubit/treatment_cubit.dart';
import 'package:noviindus_ayurvedic_patient_management/model/treatment_model.dart';
import 'package:noviindus_ayurvedic_patient_management/screen/services/injection/injection.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SelectedTreatmentScreen extends StatefulWidget {
  const SelectedTreatmentScreen({Key? key}) : super(key: key);

  @override
  State<SelectedTreatmentScreen> createState() =>
      _SelectedTreatmentScreenState();
}

class _SelectedTreatmentScreenState extends State<SelectedTreatmentScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TreatmentCubit, Treatment>(
      bloc: locator<TreatmentCubit>(),
      builder: (context, state) {
        return (state.treatmentList ?? []).isNotEmpty
            ? SizedBox(
                height: 180,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.treatmentList?.length,
                    itemBuilder: (context, index) {
                      print("treatment list ${state.treatmentList?.length}");
                      return Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.w, vertical: 2.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Color(0x40d9d9d9)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 0),
                                child: Align(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      ' ${index + 1}.  ',
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    )),
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    (state.treatmentList ?? [])[index]
                                        .name
                                        .toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16.sp,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Male",
                                        style:
                                            TextStyle(color: Color(0xff05690e)),
                                      ),
                                      const SizedBox(width: 5),
                                      Container(
                                        height: 4.5.h,
                                        width: 12.w,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                          border: Border.all(),
                                        ),
                                        child: Center(
                                          child: Text(
                                            (state.treatmentList ?? [])[index]
                                                .maleCount
                                                .toString(),
                                            style: const TextStyle(
                                                color: Color(0xff05690e)),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      const Text(
                                        "Female",
                                        style:
                                            TextStyle(color: Color(0xff05690e)),
                                      ),
                                      const SizedBox(width: 5),
                                      Container(
                                        height: 4.5.h,
                                        width: 14.w,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                          border: Border.all(),
                                        ),
                                        child: Center(
                                          child: Text(
                                            (state.treatmentList ?? [])[index]
                                                .femaleCount
                                                .toString(),
                                            style: const TextStyle(
                                                color: Color(0xff05690e)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              )
            : Container();
      },
    );
  }
}
