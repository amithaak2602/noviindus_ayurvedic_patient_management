import 'package:flutter/material.dart';
import 'package:noviindus_ayurvedic_patient_management/api_service/get_api.dart';
import 'package:noviindus_ayurvedic_patient_management/bloc/branch_cubit/branch_cubit.dart';
import 'package:noviindus_ayurvedic_patient_management/model/patient_details_model.dart';
import 'package:noviindus_ayurvedic_patient_management/screen/patient_details/widget/patientCard.dart';
import 'package:noviindus_ayurvedic_patient_management/screen/patient_registration/patient_registration_screen.dart';
import 'package:noviindus_ayurvedic_patient_management/screen/services/injection/injection.dart';
import 'package:noviindus_ayurvedic_patient_management/widget/custom_textformfield.dart';
import 'package:noviindus_ayurvedic_patient_management/widget/save_btn.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PatientDetailsScreen extends StatefulWidget {
  const PatientDetailsScreen({super.key});

  @override
  State<PatientDetailsScreen> createState() => _PatientDetailsScreenState();
}

class _PatientDetailsScreenState extends State<PatientDetailsScreen> {
  List<PatientDetail> patientList = [];
  bool isLoad = false;
  @override
  void initState() {
    fetchData();
    locator<BranchCubit>().fetchBranchData();
    locator<GetApiService>().getPatientDetails();
    super.initState();
  }

  Future<void> fetchData() async {
    setState(() {
      isLoad = true;
    });
    patientList = await locator<GetApiService>().getPatientDetails();
    setState(() {
      isLoad = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Icon(Icons.arrow_back),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 1.5.h),
            child: Image.asset(
              "assets/images/bell.png",
              width: 8.w,
              height: 3.h,
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        displacement: 2,
        color: Color(0xff05690e),
        strokeWidth: 3,
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        onRefresh: () async {
          await fetchData();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 3.w, top: 2.h, right: 3.w),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                        height: 45.0,
                        child: CustomTextFormField(
                          hintText: "Search for treatments",
                        )),
                  ),
                  const SizedBox(width: 10.0),
                  Container(
                      width: 100.0,
                      height: 45.0,
                      decoration: BoxDecoration(
                        color: const Color(0xff05690e),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: const Center(
                          child: Text('Search',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Colors.white)))),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Sort by :',
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp),
                  ),
                  Container(
                    width: 160,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Colors.grey.shade400,
                        width: 1,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: DropdownButton<String>(
                        elevation: 0,
                        hint: Text(
                          'Date',
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.normal),
                        ),
                        isExpanded: true,
                        underline: const SizedBox(),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: <String>[
                          'Option 1',
                          'Option 2',
                          'Option 3',
                          'Option 4'
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            SizedBox(
              height: 2.h,
            ),
            isLoad
                ? SizedBox(
                    width: 6.w,
                    height: 3.h,
                    child: CircularProgressIndicator(
                      color: Color(0xff05690e),
                    ))
                : Expanded(
                    child: ListView.builder(
                        itemCount: patientList.length,
                        physics: AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return PatientCard(
                            patientDetail: patientList[index],
                            count: index,
                          );
                        }),
                  ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
              child: CustomSaveButton(
                child: Text(
                  "Register Now",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return PatientRegistrationScreen();
                  }));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
