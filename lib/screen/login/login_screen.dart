import 'package:flutter/material.dart';
import 'package:noviindus_ayurvedic_patient_management/api_service/post_api.dart';
import 'package:noviindus_ayurvedic_patient_management/common/common.dart';
import 'package:noviindus_ayurvedic_patient_management/screen/patient_details/patient_details_screen.dart';
import 'package:noviindus_ayurvedic_patient_management/screen/patient_registration/patient_registration_screen.dart';
import 'package:noviindus_ayurvedic_patient_management/screen/services/injection/injection.dart';
import 'package:noviindus_ayurvedic_patient_management/widget/custom_textformfield.dart';
import 'package:noviindus_ayurvedic_patient_management/widget/save_btn.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoad = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 3.h,
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 3.2,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage(
                            "assets/images/login_img.png",
                          ),
                          alignment: Alignment.topCenter)),
                ),
                Positioned(
                    top: 100,
                    left: 130,
                    child: Container(
                        height: 75,
                        width: 75,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage(
                            "assets/images/logo.png",
                          ),
                        ))))
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Login Or Register To Book\nYour Appointments",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Text(
                        "Email",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      SizedBox(
                        height: 8.h,
                        child: CustomTextFormField(
                          controller: _emailController,
                          hintText: "Enter your email",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Email is required";
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Text(
                        "password",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      SizedBox(
                        height: 8.h,
                        child: CustomTextFormField(
                          controller: _passwordController,
                          hintText: "Enter your password",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Password is required";
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                     isLoad?CustomSaveButton(child: Center(child:
                       SizedBox(
                           width: 6.w,
                           height: 3.h,
                           child: CircularProgressIndicator(
                             color: Colors.white,
                           )),)): CustomSaveButton(
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp),
                        ),
                        onTap: () async {
                          if(_formKey.currentState!.validate()) {
                            setState(() {
                              isLoad = true;
                            });
                            final result =
                            await locator<PostApiService>().loginUserAccount();
                            if (result) {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                    return PatientDetailsScreen();
                                  }));
                            }else{
                              Common.toast("Login failed");
                            }
                            setState(() {
                              isLoad = false;
                            });
                          }
                        },
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              text:
                                  'By creating or logging into an account you are agreeing\n', // Non-underlined part
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.normal),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'with our ', // Underlined part
                                  style: TextStyle(
                                    color: Colors.black, fontSize: 16.sp,
                                    fontWeight:
                                        FontWeight.normal, // Underline applied here
                                  ),
                                ),
                                TextSpan(
                                  text: 'Terms and Conditions ', // Underlined part
                                  style: TextStyle(
                                    color: Color(0xff0028fc), fontSize: 15.sp,
                                    fontWeight:
                                        FontWeight.bold, // Underline applied here
                                  ),
                                ),
                                TextSpan(
                                  text: 'and', // Underlined part
                                  style: TextStyle(
                                    color: Colors.black, fontSize: 15.sp,
                                    fontWeight:
                                        FontWeight.normal, // Underline applied here
                                  ),
                                ),
                                TextSpan(
                                  text: ' Privacy Policy', // Underlined part
                                  style: TextStyle(
                                    color: Color(0xff0028fc), fontSize: 15.sp,
                                    fontWeight:
                                        FontWeight.bold, // Underline applied here
                                  ),
                                ),
                              ]))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
