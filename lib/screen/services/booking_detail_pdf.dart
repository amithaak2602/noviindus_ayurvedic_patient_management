import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:noviindus_ayurvedic_patient_management/common/common.dart';
import 'package:noviindus_ayurvedic_patient_management/model/patient_details_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pdf/widgets.dart' as pw;

class BookingDetails {
  static Future<void> downloadBookingDeatils(PatientDetail patientDtl) async {

    List<pw.Widget> widgets = [];
    List<pw.Widget> invoiceDataWidget = [];

    widgets.add(
      pw.Header(
          level: 0,
          child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Padding(
                    padding: const pw.EdgeInsets.symmetric(
                        horizontal: 10, vertical: 8),
                    child: pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Container(
                              width: 200,
                              height: 100,
                              padding:
                                  const pw.EdgeInsets.symmetric(vertical: 6),
                              decoration: pw.BoxDecoration(
                                shape: pw.BoxShape.circle,
                                  image: pw.DecorationImage(
                                    fit: pw.BoxFit.contain,
                                      image: pw.MemoryImage(
                                (await rootBundle
                                        .load("assets/images/logo.png"))
                                    .buffer
                                    .asUint8List(),
                              )))),
                          pw.SizedBox(width: 100),
                          pw.Column(
                              mainAxisAlignment: pw.MainAxisAlignment.start,
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              children: [
                                pw.Text(
                                  "${patientDtl.branch?.name}",
                                  style: const pw.TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                                pw.SizedBox(height: 10),
                                pw.Text(
                                  "${patientDtl.branch?.address}",
                                  style: const pw.TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                                pw.SizedBox(height: 10),
                                pw.Text(
                                  ' ${patientDtl.branch?.mail}',
                                  maxLines: 1,
                                  overflow: pw.TextOverflow.clip,
                                  style: const pw.TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                                pw.SizedBox(height: 10),
                                pw.Text(
                                  "Mob ${"${patientDtl.branch?.phone}"}",
                                  style: const pw.TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                                pw.SizedBox(height: 10),
                                pw.Text(
                                  "GST no: ${"${patientDtl.branch?.gst}"}",
                                  style: const pw.TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                                //pw.SizedBox(height: 10),
                                // pw.Text(
                                //   ":  ${shipOne}\n   ${shipTwo}",
                                //   style: const pw.TextStyle(
                                //     fontSize: 13,
                                //   ),
                                //   //overflow:pw.TextOverflow.ell
                                // ),
                                // pw.SizedBox(height: 10),
                                // pw.Text(
                                //   ":  ${billOne}\n   ${billTwo}",
                                //   style: const pw.TextStyle(
                                //     fontSize: 13,
                                //   ),
                                //   //overflow:pw.TextOverflow.ell
                                // )
                              ])
                        ])),
                pw.Divider(color: PdfColors.grey500),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Expanded(
                          flex: 3,
                          child: pw.Padding(
                              padding: pw.EdgeInsets.symmetric(
                                  horizontal: 13, vertical: 8),
                              child: pw.Column(
                                  mainAxisAlignment: pw.MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text(
                                      "Patient Details",
                                      style: pw.TextStyle(
                                          fontSize: 13,
                                          color: PdfColors.green,
                                          fontWeight: pw.FontWeight.bold),
                                    ),
                                    pw.SizedBox(height: 13),
                                    pw.Row(children: [
                                      pw.Column(
                                          mainAxisAlignment:
                                              pw.MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.start,
                                          children: [
                                            pw.Text(
                                              "Name",
                                              overflow: pw.TextOverflow.visible,
                                              textAlign: pw.TextAlign.left,
                                              style: const pw.TextStyle(
                                                fontSize: 13,
                                              ),
                                              //overflow:pw.TextOverflow.ell
                                            ),
                                            pw.SizedBox(height: 10),
                                            pw.Text(
                                              "Address",
                                              overflow: pw.TextOverflow.visible,
                                              textAlign: pw.TextAlign.left,
                                              style: const pw.TextStyle(
                                                fontSize: 13,
                                              ),
                                              //overflow:pw.TextOverflow.ell
                                            ),
                                            pw.SizedBox(height: 10),
                                            pw.Text(
                                              "Whatsapp number",
                                              overflow: pw.TextOverflow.visible,
                                              textAlign: pw.TextAlign.left,
                                              style: const pw.TextStyle(
                                                fontSize: 13,
                                              ),
                                              //overflow:pw.TextOverflow.ell
                                            ),
                                          ]),
                                      pw.SizedBox(width: 20),
                                      pw.Column(
                                          mainAxisAlignment:
                                              pw.MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.start,
                                          children: [
                                            pw.Text(
                                              "${patientDtl.name}",
                                              overflow: pw.TextOverflow.visible,
                                              textAlign: pw.TextAlign.left,
                                              style: const pw.TextStyle(
                                                fontSize: 13,
                                              ),
                                              //overflow:pw.TextOverflow.ell
                                            ),
                                            pw.SizedBox(height: 10),
                                            pw.Text(
                                              "${patientDtl.address}",
                                              overflow: pw.TextOverflow.visible,
                                              textAlign: pw.TextAlign.left,
                                              style: const pw.TextStyle(
                                                fontSize: 13,
                                              ),
                                              //overflow:pw.TextOverflow.ell
                                            ),
                                            pw.SizedBox(height: 10),
                                            pw.Text(
                                              "${patientDtl.phone}",
                                              overflow: pw.TextOverflow.visible,
                                              textAlign: pw.TextAlign.left,
                                              style: const pw.TextStyle(
                                                fontSize: 13,
                                              ),
                                              //overflow:pw.TextOverflow.ell
                                            ),
                                          ])
                                    ])
                                  ]))),
                      pw.Expanded(
                          child: pw.Container(
                              // width: 1.0, // Thickness of the divider
                              // height: 100.0, // Height of the divider
                              // color: PdfColors.grey, // Color of the divider
                              )),
                      pw.Expanded(
                          flex: 3,
                          child: pw.Padding(
                            padding: pw.EdgeInsets.symmetric(
                                horizontal: 13, vertical: 8),
                            child: pw.Column(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceBetween,
                                crossAxisAlignment:
                                    pw.CrossAxisAlignment.center,
                                children: [
                                  pw.Text(
                                    "",
                                    style: pw.TextStyle(
                                        fontSize: 13,
                                        color: PdfColors.green,
                                        fontWeight: pw.FontWeight.bold),
                                  ),
                                  pw.SizedBox(height: 13),
                                  pw.Row(children: [
                                    pw.Column(
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.start,
                                        children: [
                                          pw.Text(
                                            "Booked On",
                                            overflow: pw.TextOverflow.visible,
                                            textAlign: pw.TextAlign.left,
                                            style: const pw.TextStyle(
                                              fontSize: 13,
                                            ),
                                            //overflow:pw.TextOverflow.ell
                                          ),
                                          pw.SizedBox(height: 10),
                                          pw.Text(
                                            "Treatment Date",
                                            overflow: pw.TextOverflow.visible,
                                            textAlign: pw.TextAlign.left,
                                            style: const pw.TextStyle(
                                              fontSize: 13,
                                            ),
                                            //overflow:pw.TextOverflow.ell
                                          ),
                                          pw.SizedBox(height: 10),
                                          pw.Text(
                                            "Treatment Time",
                                            overflow: pw.TextOverflow.visible,
                                            textAlign: pw.TextAlign.left,
                                            style: const pw.TextStyle(
                                              fontSize: 13,
                                            ),
                                            //overflow:pw.TextOverflow.ell
                                          ),
                                        ]),
                                    pw.SizedBox(width: 20),
                                    pw.Column(
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.start,
                                        children: [
                                          pw.Text(
                                            "",
                                            overflow: pw.TextOverflow.visible,
                                            textAlign: pw.TextAlign.left,
                                            style: const pw.TextStyle(
                                              fontSize: 13,
                                            ),
                                            //overflow:pw.TextOverflow.ell
                                          ),
                                          pw.SizedBox(height: 10),
                                          pw.Text(
                                            "",
                                            overflow: pw.TextOverflow.visible,
                                            textAlign: pw.TextAlign.left,
                                            style: const pw.TextStyle(
                                              fontSize: 13,
                                            ),
                                            //overflow:pw.TextOverflow.ell
                                          ),
                                          pw.SizedBox(height: 10),
                                          pw.Text(
                                            "",
                                            overflow: pw.TextOverflow.visible,
                                            textAlign: pw.TextAlign.left,
                                            style: const pw.TextStyle(
                                              fontSize: 13,
                                            ),
                                            //overflow:pw.TextOverflow.ell
                                          ),
                                        ])
                                  ])
                                ]),
                          ))
                    ])
              ])),
    );
    widgets.add(
      pw.Container(
        decoration: pw.BoxDecoration(),
        padding: const pw.EdgeInsets.all(2.0),
        margin: const pw.EdgeInsets.only(top: 10.0),
        child: pw.Padding(
            padding: const pw.EdgeInsets.only(
                left: 8.0, bottom: 8.0, top: 10.0, right: 6),
            child: pw.Row(children: [
              pw.Expanded(
                  flex: 2,
                  child: pw.Text("Treatment",
                      style: const pw.TextStyle(
                          fontSize: 13, color: PdfColors.green))),
              pw.Expanded(
                  flex: 1,
                  child: pw.Text("Price",
                      style: const pw.TextStyle(
                          fontSize: 13, color: PdfColors.green),
                      textAlign: pw.TextAlign.left)),
              pw.Expanded(
                  flex: 1,
                  child: pw.Text(
                    "Male",
                    style: const pw.TextStyle(
                        fontSize: 13, color: PdfColors.green),
                  )),
              pw.Expanded(
                  flex: 1,
                  child: pw.Text("Female",
                      style: const pw.TextStyle(
                          fontSize: 13, color: PdfColors.green),
                      textAlign: pw.TextAlign.right)),
              pw.Expanded(
                  flex: 1,
                  child: pw.Text("Total",
                      style: const pw.TextStyle(
                          fontSize: 13, color: PdfColors.green),
                      textAlign: pw.TextAlign.right)),
            ])),
      ),
    );
    pw.Container buildPatientListWidget() => pw.Container(
        decoration: pw.BoxDecoration(),
        child: pw.Column(children: invoiceDataWidget));
    widgets.add(buildPatientListWidget());
    widgets.add(pw.Column(
        mainAxisAlignment: pw.MainAxisAlignment.end,
        crossAxisAlignment: pw.CrossAxisAlignment.end,
        children: [
          pw.Divider(),
          pw.SizedBox(height: 23),
          pw.Padding(
              padding: pw.EdgeInsets.only(right: 10),
              child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            "Total Amount",
                            style: const pw.TextStyle(
                              fontSize: 13,
                            ),
                          ),
                          pw.SizedBox(height: 10),
                          pw.Text(
                            "Discount",
                            style: const pw.TextStyle(
                              fontSize: 13,
                            ),
                          ),
                            pw.SizedBox(height: 10),
                            pw.Text(
                              "Advance",
                              style: const pw.TextStyle(
                                fontSize: 13,
                              ),
                            ),
                          pw.SizedBox(height: 10),
                          pw.Text(
                            "Balance",
                            style: const pw.TextStyle(
                              fontSize: 13,
                            ),
                          ),
                        ]),
                    pw.SizedBox(width: 23),
                    pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.end,
                        children: [
                          pw.Text(
                            "${patientDtl.totalAmount}",
                            style: const pw.TextStyle(
                              fontSize: 13,
                            ),
                          ),
                          pw.SizedBox(height: 10),
                          pw.Text(
                            "${patientDtl.discountAmount}",
                            textAlign: pw.TextAlign.right,
                            style: const pw.TextStyle(
                              fontSize: 13,
                            ),
                          ),
                            pw.SizedBox(height: 10),
                            pw.Text(
                             "${patientDtl.advanceAmount}",
                              textAlign: pw.TextAlign.right,
                              style: const pw.TextStyle(
                                fontSize: 13,
                              ),
                            ),
                          pw.SizedBox(height: 10),
                          pw.Text(
                          "${patientDtl.balanceAmount}",
                            textAlign: pw.TextAlign.right,
                            style: const pw.TextStyle(
                              fontSize: 13,
                            ),
                          ),
                        ])
                  ])),
          pw.SizedBox(height: 23),
          pw.Text(
              "Thank you for choosing us",
              style: const pw.TextStyle(
                fontSize: 18,color: PdfColors.green
              ),
              textAlign: pw.TextAlign.end),
        ]));
    for (int i = 0; i < patientDtl.patientDetails!.length; i++) {
      invoiceDataWidget.add(pw.Container(
          child: pw.Column(children: [
            pw.Container(
                padding: const pw.EdgeInsets.all(10),
                decoration: pw.BoxDecoration(
                    color: i.isOdd ? PdfColors.grey300 : PdfColors.white,
                   ),
                child: pw.Row(children: [
                  pw.Expanded(
                    flex: 2,
                    child: pw.Text(
                        "${patientDtl.patientDetails?[i].treatmentName}",
                        style: const pw.TextStyle(
                          fontSize: 13,
                        ),
                        textAlign: pw.TextAlign.left),
                  ),
                  pw.Expanded(
                      flex: 1,
                      child:
                          pw.Text('${patientDtl.patientDetails?[i].treatment}',
                              style: const pw.TextStyle(
                                fontSize: 13,
                              ))),
                  pw.Expanded(
                    flex: 1,
                    child: pw.Text(
                      (patientDtl.patientDetails![i].male ?? 0).toString(),
                      style: const pw.TextStyle(
                        fontSize: 13,
                      ),
                    ),

                  ),
                  pw.Expanded(
                      flex: 1,
                      child: pw.Text(
                          null != patientDtl.patientDetails?[i].female
                              ? '${patientDtl.patientDetails?[i].female}'
                              : "0",
                          style: const pw.TextStyle(
                            fontSize: 13,
                          ))),
                  pw.Expanded(
                      flex: 1,
                      child: pw.Text(
                          '${patientDtl.totalAmount?.toStringAsFixed(2)}',
                          textAlign: pw.TextAlign.right,
                          style: const pw.TextStyle(
                            fontSize: 13,
                          ))),
                ]))
          ])));
    }
    final pdf = pw.Document();
    pdf.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(25),
        build: (pw.Context context) {
          return widgets;
        }));
    var bytes = await pdf.save();
    await saveFile(bytes, "Booking_Details", patientDtl);

  }

  static Future<void> saveFile(
      List<int>? bytes, String name, PatientDetail patient) async {
    var directory;
    if (await _requestPermission(Permission.storage)) {
      if (Platform.isAndroid) {
        directory = await getExternalStorageDirectory();
      }
      String filepath = directory.path;
      String date = DateTime.now().millisecondsSinceEpoch.toString();
      final String fileName = '$filepath/$name.pdf';
      final file = File(fileName);
      await file.writeAsBytes(bytes!, flush: true);
      Common.toast('$name$date.pdf downloaded successfully');

      final directory1 = (await getExternalStorageDirectory())?.path;
      final String fileName1 = '${directory1}/$name.pdf';
      final files = await File(fileName1).create();
      await files.writeAsBytes(bytes, flush: true);
    }
  }

  static Future<bool> _requestPermission(Permission permission) async {
    AndroidDeviceInfo info = await DeviceInfoPlugin().androidInfo;
    if (info.version.sdkInt >= 33) {
      var re = await Permission.storage.request();
      if (re.isGranted) {
        return true;
      } else {
        return false;
      }
    } else {
      if (await permission.isGranted) {
        return true;
      } else {
        var result = await permission.request();
        if (result == PermissionStatus.granted) {
          return true;
        } else {
          return false;
        }
      }
    }
  }
}
