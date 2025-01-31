import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:noviindus_ayurvedic_patient_management/api_service/post_api.dart';
import 'package:noviindus_ayurvedic_patient_management/bloc/branch_cubit/branch_cubit.dart';
import 'package:noviindus_ayurvedic_patient_management/bloc/fetch_treatment_cubit/fetch_treatment_cubit.dart';
import 'package:noviindus_ayurvedic_patient_management/bloc/treatment_cubit/treatment_cubit.dart';
import 'package:noviindus_ayurvedic_patient_management/common/common.dart';
import 'package:noviindus_ayurvedic_patient_management/model/branch_model.dart';
import 'package:noviindus_ayurvedic_patient_management/model/patient_model.dart';
import 'package:noviindus_ayurvedic_patient_management/model/treatment_model.dart';
import 'package:noviindus_ayurvedic_patient_management/screen/patient_registration/widget/add_treatment_bottomsheet.dart';
import 'package:noviindus_ayurvedic_patient_management/screen/patient_registration/widget/selected_treatment_screen.dart';
import 'package:noviindus_ayurvedic_patient_management/screen/services/injection/injection.dart';
import 'package:noviindus_ayurvedic_patient_management/widget/custom_textformfield.dart';
import 'package:noviindus_ayurvedic_patient_management/widget/save_btn.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PatientRegistrationScreen extends StatefulWidget {
  const PatientRegistrationScreen({super.key});

  @override
  State<PatientRegistrationScreen> createState() =>
      _PatientRegistrationScreenState();
}

class _PatientRegistrationScreenState extends State<PatientRegistrationScreen> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _number = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _location = TextEditingController();
  final TextEditingController _branch = TextEditingController();
  final TextEditingController _total = TextEditingController();
  final TextEditingController _discount = TextEditingController();
  final TextEditingController _advance = TextEditingController();
  TextEditingController balance = TextEditingController();
  final TextEditingController date = TextEditingController();
  TextEditingController hour = TextEditingController();
  TextEditingController minutes = TextEditingController();
  List<Branch> branchList = [];
  String selectedBranch = '';
  bool isLoad = false;
  DateTime? _selectedDate;
  String? _paymentMethod;
  int? _selectedMinute;
  int? _selectedHr;
  List<int> hours = [];
  List<int> minute = [];
  final _formKey = GlobalKey<FormState>();
  Branch branch = Branch();
  @override
  void initState() {
    setData();
    locator<FetchTreatmentCubit>().fetchTreatment();
    locator<TreatmentCubit>().addTreatment(Treatment());
    super.initState();
  }

  void setData() async {
    setState(() {
      isLoad = true;
    });
    hours = List.generate(24, (index) => index);
    minute = List.generate(60, (index) => index);
    await locator<BranchCubit>().fetchBranchData();
    final state = locator<BranchCubit>().state;
    if (state is BranchLoaded) {
      branchList = state.branchList;
    }
    setState(() {
      isLoad = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TreatmentCubit, Treatment>(
      bloc: locator<TreatmentCubit>(),
      builder: (context, treatment) {
        return Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            backgroundColor: Colors.white,
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
          body: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 8.w, top: 2.h, bottom: 0.8.h),
                  child: Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Divider(),
                SizedBox(
                  height: 1.h,
                ),
                isLoad
                    ? Center(
                        child: SizedBox(
                            width: 6.w,
                            height: 3.h,
                            child: CircularProgressIndicator()),
                      )
                    : Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.w, vertical: 2.h),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Name",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                SizedBox(
                                  height: 8.h,
                                  child: CustomTextFormField(
                                    controller: _name,
                                    hintText: "Enter your full name",
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Name is required";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 3.h,
                                ),
                                Text(
                                  "Whatsapp Number",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                SizedBox(
                                  height: 8.h,
                                  child: CustomTextFormField(
                                    controller: _number,
                                    hintText: "Enter your Whatsapp number",
                                    textInputType: TextInputType.phone,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Whatsapp number is required";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 3.h,
                                ),
                                Text(
                                  "Address",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                SizedBox(
                                  height: 8.h,
                                  child: CustomTextFormField(
                                    controller: _address,
                                    hintText: "Enter your full address",
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Address is required";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 3.h,
                                ),
                                Text(
                                  "Branch",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                DropdownButtonFormField<String>(
                                  iconSize: 0.0,
                                  elevation: 0,
                                  value: branch.name,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedBranch = newValue ?? "";
                                      int index =
                                          branchList.indexWhere((element) {
                                        return element.name
                                            .toString()
                                            .toLowerCase()
                                            .contains(newValue
                                                .toString()
                                                .toLowerCase());
                                      });
                                      if (index > -1) {
                                        setState(() {
                                          branch = branchList[index];
                                        });
                                      }
                                    });
                                  },
                                  items: branchList.map((value) {
                                    return DropdownMenuItem<String>(
                                      value: value.name,
                                      child: Text(
                                        value.name.toString(),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  decoration: InputDecoration(
                                    hintText: 'Choose your Branch',
                                    hintStyle: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15.sp),
                                    fillColor: Color(0x40d9d9d9),
                                    filled: true,
                                    suffixIcon: const Icon(
                                        Icons.keyboard_arrow_down_sharp),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade400,
                                            width: 0,
                                            style: BorderStyle.solid),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10))),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade400,
                                            width: 0,
                                            style: BorderStyle.solid),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10))),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade400,
                                            width: 0,
                                            style: BorderStyle.solid),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10))),
                                  ),
                                ),
                                SizedBox(
                                  height: 3.h,
                                ),
                                SelectedTreatmentScreen(),
                                SizedBox(
                                  height: 1.h,
                                ),
                                CustomSaveButton(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        "Add Treatments",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.sp),
                                      ),
                                    ],
                                  ),
                                  onTap: () async {
                                    showModalBottomSheet(
                                        backgroundColor: Colors.transparent,
                                        context: context,
                                        builder: (context) {
                                          return const ClipRRect(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                      top: Radius.circular(15)),
                                              child: AddTreatmentBottomSheet());
                                        });
                                  },
                                ),
                                SizedBox(
                                  height: 3.h,
                                ),
                                Text(
                                  "Total Amount",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                SizedBox(
                                  height: 8.h,
                                  child: CustomTextFormField(
                                    textInputType: TextInputType.number,
                                    controller: _total,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Total amount is required";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 3.h,
                                ),
                                Text(
                                  "Discount Amount",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                SizedBox(
                                  height: 8.h,
                                  child: CustomTextFormField(
                                    controller: _discount,
                                    textInputType: TextInputType.number,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Discount amount is required";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 3.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Radio<String>(
                                          value: 'Card',
                                          groupValue: _paymentMethod,
                                          activeColor: Color(0xff05690e),
                                          onChanged: (String? value) {
                                            setState(() {
                                              _paymentMethod = value;
                                            });
                                          },
                                        ),
                                        const Text('Card'),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Radio<String>(
                                          value: 'Cash',
                                          groupValue: _paymentMethod,
                                          activeColor: Color(0xff05690e),
                                          onChanged: (String? value) {
                                            setState(() {
                                              _paymentMethod = value;
                                            });
                                          },
                                        ),
                                        const Text('Cash'),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Radio<String>(
                                          value: 'UPI',
                                          groupValue: _paymentMethod,
                                          activeColor: Color(0xff05690e),
                                          onChanged: (String? value) {
                                            setState(() {
                                              _paymentMethod = value;
                                            });
                                          },
                                        ),
                                        const Text('UPI'),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 3.h,
                                ),
                                Text(
                                  "Advance Amount",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                SizedBox(
                                  height: 8.h,
                                  child: CustomTextFormField(
                                    controller: _advance,
                                    textInputType: TextInputType.number,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Advance amount is required";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 3.h,
                                ),
                                Text(
                                  "Balance Amount",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                SizedBox(
                                  height: 8.h,
                                  child: CustomTextFormField(
                                    controller: balance,
                                    textInputType: TextInputType.number,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Balance amount is required";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 3.h,
                                ),
                                Text(
                                  "Treatment Date",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                SizedBox(
                                  height: 8.h,
                                  child: CustomTextFormField(
                                    controller: date,
                                    readOnly: true,
                                    icon: Icon(
                                      Icons.date_range,
                                      color: Color(0xff05690e),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Treatment date is required";
                                      }
                                      return null;
                                    },
                                    onTap: () async {
                                      await _selectDate(context);
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 3.h,
                                ),
                                Text(
                                  "Treatment Time",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: SizedBox(
                                        height: 50,
                                        child: DropdownButtonFormField<int>(
                                          iconSize: 0.0,
                                          value: _selectedHr,
                                          onChanged: (int? newValue) {
                                            setState(() {
                                              _selectedHr = newValue;
                                            });
                                          },
                                          items: hours.map((int value) {
                                            return DropdownMenuItem<int>(
                                              value: value,
                                              child: Text(value.toString()),
                                            );
                                          }).toList(),
                                          decoration: InputDecoration(
                                            hintText: 'Hour',
                                            hintStyle: TextStyle(
                                                color: Colors.grey.shade500,
                                                fontSize: 12),
                                            fillColor: Color(0x40d9d9d9),
                                            filled: true,
                                            suffixIcon: const Icon(
                                                Icons.keyboard_arrow_down_sharp,
                                                color: Colors.green),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey,
                                                    width: 0,
                                                    style: BorderStyle.solid),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(10))),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey,
                                                    width: 0,
                                                    style: BorderStyle.solid),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(10))),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey,
                                                    width: 0,
                                                    style: BorderStyle.solid),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(10))),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        height: 50,
                                        child: DropdownButtonFormField<int>(
                                          iconSize: 0.0,
                                          value: _selectedMinute,
                                          onChanged: (int? newValue) {
                                            setState(() {
                                              _selectedMinute = newValue;
                                            });
                                          },
                                          items: minute.map((int value) {
                                            return DropdownMenuItem<int>(
                                              value: value,
                                              child: Text(value.toString()),
                                            );
                                          }).toList(),
                                          decoration: InputDecoration(
                                            hintText: 'Minutes',
                                            hintStyle: TextStyle(
                                                color: Colors.grey.shade500,
                                                fontSize: 12),
                                            fillColor: Color(0x40d9d9d9),
                                            filled: true,
                                            suffixIcon: const Icon(
                                              Icons.keyboard_arrow_down_sharp,
                                              color: Colors.green,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey,
                                                    width: 0,
                                                    style: BorderStyle.solid),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(10))),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey,
                                                    width: 0,
                                                    style: BorderStyle.solid),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(10))),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey,
                                                    width: 0,
                                                    style: BorderStyle.solid),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(10))),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 3.h,
                                ),
                                CustomSaveButton(
                                  child: Text(
                                    "Save",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.sp),
                                  ),
                                  onTap: () async {
                                    if (_formKey.currentState!.validate()) {
                                      if ((branch.id ?? 0) <= 0) {
                                        Common.toast("Please select branch");
                                      } else if(_paymentMethod.toString().isEmpty){
                                        Common.toast("Please select payment");
                                      }
                                      else {
                                        Patient patient = Patient(
                                          id: "",
                                          name: _name.text,
                                          payment: _paymentMethod,
                                          phone: _number.text,
                                          address: _address.text,
                                          branch: branch,
                                          totalAmount: double.tryParse(_total.text),
                                          discountAmount: double.tryParse(_discount.text),
                                          advanceAmount: double.tryParse(_advance.text),
                                          balanceAmount: double.tryParse(balance.text),
                                          dateNdTime: _selectedDate,
                                          male: [
                                            treatment.treatmentList?[0].id ?? 0
                                          ],
                                          female: [
                                            treatment.treatmentList?[0].id ?? 0
                                          ],
                                          treatments: [
                                            treatment.treatmentList?[0].id ?? 0
                                          ],
                                        );
                                        await locator<PostApiService>()
                                            .registerPatient(patient.toJson());
                                      }
                                    }
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
        date.text = DateFormat('dd/MM/yyyy').format(pickedDate);
      });
    }
  }
}
