import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noviindus_ayurvedic_patient_management/bloc/fetch_treatment_cubit/fetch_treatment_cubit.dart';
import 'package:noviindus_ayurvedic_patient_management/bloc/treatment_cubit/treatment_cubit.dart';
import 'package:noviindus_ayurvedic_patient_management/model/treatment_model.dart';
import 'package:noviindus_ayurvedic_patient_management/screen/services/injection/injection.dart';
import 'package:noviindus_ayurvedic_patient_management/widget/save_btn.dart';

class AddTreatmentBottomSheet extends StatefulWidget {
  const AddTreatmentBottomSheet({super.key});

  @override
  State<AddTreatmentBottomSheet> createState() =>
      _AddTreatmentBottomsheetState();
}

class _AddTreatmentBottomsheetState extends State<AddTreatmentBottomSheet> {
  List<Treatment> treatmentList = [];
  int maleCount = 0;
  int femaleCount = 0;
  Treatment treatment=Treatment();
  @override
  void initState() {
    locator<FetchTreatmentCubit>().fetchTreatment();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TreatmentCubit, Treatment>(
      bloc: locator<TreatmentCubit>(),
      builder: (context, treatment) {
        return BlocBuilder<FetchTreatmentCubit, FetchTreatmentState>(
          bloc: locator<FetchTreatmentCubit>(),
          builder: (context, state) {
            treatmentList =
                state is FetchTreatmentLoaded ? state.treatmentList : [];
            return Container(
              width: double.infinity,
              height: 400,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 16, right: 8, left: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Choose Treatment",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (treatmentList.isNotEmpty)
                      DropdownButtonFormField<Treatment>(
                        iconSize: 0.0,
                        elevation: 0,
                        value: treatmentList[0],
                        onChanged: (Treatment? newValue) {
                          print(newValue);
                            locator<TreatmentCubit>()
                                .addTreatment(newValue ?? Treatment());
                            setState(() {
                              treatment = newValue!;
                            });

                        },
                        padding: EdgeInsets.zero,
                        items: treatmentList.map((value) {
                          return DropdownMenuItem<Treatment>(
                            value: value,
                            child: Text(
                              value.name.toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          hintText: 'Choose Preferred Treatment',
                          hintStyle: TextStyle(
                              color: Colors.grey.shade500, fontSize: 12),
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          suffixIcon: Icon(Icons.keyboard_arrow_down_sharp),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey.shade400,
                                  width: 0,
                                  style: BorderStyle.solid),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey.shade400,
                                  width: 0,
                                  style: BorderStyle.solid),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                        ),
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Add Patients",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    customSelection("Male", () {
                      setState(() {
                        maleCount++;
                      });
                    }, () {
                      setState(() {
                        maleCount--;
                      });
                    }, maleCount.toString()),
                    const SizedBox(
                      height: 20,
                    ),
                    customSelection("Female", () {
                      setState(() {
                        femaleCount++;
                      });
                    }, () {
                      setState(() {
                        femaleCount--;
                      });
                    }, femaleCount.toString()),
                    const SizedBox(
                      height: 40,
                    ),
                    CustomSaveButton(
                      child: Text(
                        "Save",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                      ),
                      onTap: () async {
                        final treatment = locator<TreatmentCubit>().state;
                        final data = treatment.copyWith(
                            maleCount: maleCount, femaleCount: femaleCount);
                        await locator<TreatmentCubit>().addTreatment(data);
                        await locator<TreatmentCubit>().updateTreatment(data);
                        Navigator.pop(context);
                        // int index = treatmentList.indexWhere(
                        //         (element) => element.name == _selectedTreatment);
                        //
                        // PatientDetail patientDtl = PatientDetail(
                        //     id: 0,
                        //     male: maleCount.toString(),
                        //     female: femaleCount.toString(),
                        //     patient: 0,
                        //     treatment: treatmentList[index].id,
                        //     treatmentName: _selectedTreatment ?? "");
                        // Navigator.pop(context, patientDtl);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget customSelection(String title, void Function() onTapIncrement,
      void Function() onTapDecrement, String? count) {
    return Row(children: [
      Container(
        height: 46,
        width: 100,
        decoration: BoxDecoration(
          color: Color(0x40d9d9d9),
          border: Border.all(),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Center(child: Text(title)),
      ),
      const SizedBox(
        width: 20,
      ),
      Expanded(
        child: InkWell(
          onTap: onTapIncrement,
          child: const CircleAvatar(
              radius: 15,
              backgroundColor: Color(0xff05690e),
              child: Center(
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              )),
        ),
      ),
      const SizedBox(
        width: 10,
      ),
      Expanded(
        child: Container(
          height: 45,
          width: 50,
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Center(
            child: Text(count ?? ""),
          ),
        ),
      ),
      const SizedBox(
        width: 10,
      ),
      Expanded(
        child: InkWell(
          onTap: onTapDecrement,
          child: const CircleAvatar(
              radius: 15,
              backgroundColor: Color(0xff05690e),
              child: Center(
                child: Icon(
                  Icons.remove,
                  color: Colors.white,
                ),
              )),
        ),
      )
    ]);
  }
}
