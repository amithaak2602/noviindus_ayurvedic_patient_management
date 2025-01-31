import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:noviindus_ayurvedic_patient_management/model/patient_details_model.dart';
import 'package:noviindus_ayurvedic_patient_management/screen/services/booking_detail_pdf.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PatientCard extends StatelessWidget {
  final PatientDetail patientDetail;
  final int count;

  const PatientCard(
      {super.key, required this.patientDetail, required this.count});

  @override
  Widget build(BuildContext context) {
    String formattedDate = '';
    if (patientDetail.dateTime.toString().isNotEmpty &&
        null != patientDetail.dateTime) {
      final dateTime = DateTime.parse(patientDetail.dateTime.toString());
      formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
    }
    return Container(
      height: (patientDetail.patientDetails ?? []).length > 1 ? 22.h : 20.h,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.grey.withOpacity(0.1)),
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.only(bottom: 4.0, right: 8.0, left: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            ' ${count + 1}.  ',
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.w600),
                          )),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            patientDetail.name.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17.sp,
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:
                                      patientDetail.patientDetails!.map((data) {
                                    return Text(
                                      data.treatmentName.toString().isNotEmpty
                                          ? data.treatmentName.toString()
                                          : "",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 16.sp, color: Colors.green),
                                    );
                                  }).toList()),
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_month_sharp,
                                color: Colors.red,
                                size: 18,
                              ),
                              const SizedBox(width: 5),
                              Text(formattedDate),
                              const SizedBox(width: 20),
                              const Icon(
                                Icons.group,
                                color: Colors.red,
                                size: 20,
                              ),
                              const SizedBox(width: 5),
                              Text(patientDetail.user.toString()),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(),
          GestureDetector(
            child: Padding(
              padding: EdgeInsets.only(left: 45, right: 10, top: 0, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'View Booking details',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0,
                        color: Colors.black54,
                        fontSize: 17.sp),
                  ),

                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.green,
                    size: 18,
                  ), // Trailing icon
                ],
              ),
            ),
            onTap: ()async{
              await BookingDetails.downloadBookingDeatils(patientDetail);
            },
          ),
        ],
      ),
    );
  }
}
