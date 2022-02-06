import 'dart:ui';
import 'package:blood_donor_web_admin/models/campaign.dart';
import 'package:blood_donor_web_admin/models/cloud_storage_info.dart';
import 'package:blood_donor_web_admin/models/question.dart';
import 'package:blood_donor_web_admin/models/request.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Constants{
  static const appColorBrownRed = Color(0xffD92027);
  static const appColorBrownRedLight = Color(0xffff5d51);
  static const appColorWhite = Color(0xffffffff);
  static const appColorBlack = Color(0xff000000);
  static const appColorGray = Color(0xffc4c4c4);

  static const MaterialColor appColorbrownRedSwatch = MaterialColor(0xffD92027, <int, Color>{
    50: Color(0xffD92027),
    100: Color(0xffD92027),
    200: Color(0xffD92027),
    300: Color(0xffD92027),
    400: Color(0xffD92027),
    500: Color(0xffD92027),
    600: Color(0xffD92027),
    700: Color(0xffD92027),
    800: Color(0xffD92027),
    900: Color(0xffD92027),
  });


  static const primaryColor = Color(0xFF2697FF);
  static const secondaryColor = Color(0xFF2A2D3E);
  static const bgColor = Color(0xFF212332);

  static const defaultPadding = 16.0;


  List demoMyFiles = [
    CloudStorageInfo(
      title: "Documents",
      numOfFiles: 1328,
      svgSrc: "assets/icons/Documents.svg",
      totalStorage: "1.9GB",
      color: primaryColor,
      percentage: 35,
    ),
    CloudStorageInfo(
      title: "Google Drive",
      numOfFiles: 1328,
      svgSrc: "assets/icons/google_drive.svg",
      totalStorage: "2.9GB",
      color: Color(0xFFFFA113),
      percentage: 35,
    ),
    CloudStorageInfo(
      title: "One Drive",
      numOfFiles: 1328,
      svgSrc: "assets/icons/one_drive.svg",
      totalStorage: "1GB",
      color: Color(0xFFA4CDFF),
      percentage: 10,
    ),
    CloudStorageInfo(
      title: "Documents",
      numOfFiles: 5328,
      svgSrc: "assets/icons/drop_box.svg",
      totalStorage: "7.3GB",
      color: Color(0xFF007EE5),
      percentage: 78,
    ),
  ];



  List campaignsList = [
    Campaign(
      campaignId: "0xFF007EE5",
      title: "Maharagama",
      date: "01-03-2021",
      time: "8.00 am - 2.00 pm",
        status : "closed"
    ),
    Campaign(
      campaignId: "0xFF007EE6",
      title: "Nugegoda",
      date: "27-02-2021",
      time: "8.00 am - 2.00 pm",
        status : "open"
    ),
    Campaign(
      campaignId: "0xFF007EE7",
      title: "Gampaha",
      date: "23-02-2021",
      time: "8.00 am - 2.00 pm",
        status : "open"
    ),
    Campaign(
      campaignId: "0xFF007EE8",
      title: "Kadawatha",
      date: "21-02-2021",
      time: "8.00 am - 2.00 pm",
        status : "closed"
    ),
    Campaign(
      campaignId: "0xFF007EE9",
      title: "Ja-ela",
      date: "23-02-2021",
      time: "8.00 am - 2.00 pm",
        status : "open"
    ),
    Campaign(
      campaignId: "0xFF007EE10",
      title: "Wattala",
      date: "25-02-2021",
      time: "8.00 am - 2.00 pm",
        status : "closed"
    ),
    Campaign(
      campaignId: "0xFF007EE11",
      title: "Kiribathgoda",
      date: "25-02-2021",
      time: "8.00 am - 2.00 pm",
      status : "closed"
    ),
  ];

  List<Request> requestList = [
    Request(
      donorId: "0xffff5d51",
      name: "a",
      status: "active"
    ),

    Request(
        donorId: "0xffff5d52",
        name: "b",
        status: "active"
    ),
    Request(
        donorId: "0xffff5d53",
        name: "c",
        status: "Pending"
    ),
    Request(
        donorId: "0xffff5d54",
        name: "d",
        status: "Pending"
    ),
    Request(
        donorId: "0xffff5d55",
        name: "e",
        status: "active"
    ),
    Request(
        donorId: "0xffff5d56",
        name: "f",
        status: "active"
    ),
    Request(
        donorId: "0xffff5d57",
        name: "g",
        status: "Pending"
    ),
    Request(
        donorId: "0xffff5d58",
        name: "h",
        status: "active"
    ),
    Request(
        donorId: "0xffff5d59",
        name: "i",
        status: "Pending"
    ),
    Request(
        donorId: "0xffff5d510",
        name: "j",
        status: "Pending"
    ),
  ];

  List<Question> qaList = [
    Question(
      qno: "1",
      question: "question 1",
      answer: "yes"
    ),
    Question(
        qno: "2",
        question: "question 2",
        answer: "yes"
    ),
    Question(
        qno: "3",
        question: "question 3",
        answer: "yes"
    ),
    Question(
        qno: "4",
        question: "question 4",
        answer: "no"
    ),
    Question(
        qno: "5",
        question: "question 5",
        answer: "yes"
    ),
    Question(
        qno: "6",
        question: "question 6",
        answer: "yes"
    ),
    Question(
        qno: "7",
        question: "question 7",
        answer: "no"
    ),
    Question(
        qno: "8",
        question: "question 8",
        answer: "yes"
    ),
    Question(
        qno: "9",
        question: "question 9",
        answer: "yes"
    ),
    Question(
        qno: "10",
        question: "question 10",
        answer: "no"
    ),
  ];

  List<PieChartSectionData> paiChartSelectionDatas = [
    PieChartSectionData(
      color: primaryColor,
      value: 25,
      showTitle: false,
      radius: 25,
    ),
    PieChartSectionData(
      color: Color(0xFF26E5FF),
      value: 20,
      showTitle: false,
      radius: 22,
    ),
    PieChartSectionData(
      color: Color(0xFFFFCF26),
      value: 10,
      showTitle: false,
      radius: 19,
    ),
    PieChartSectionData(
      color: Color(0xFFEE2727),
      value: 15,
      showTitle: false,
      radius: 16,
    ),
    PieChartSectionData(
      color: primaryColor.withOpacity(0.1),
      value: 25,
      showTitle: false,
      radius: 13,
    ),
  ];

  static showAlertDialog(BuildContext context,String title,String description) {

    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () { Navigator.of(context).pop();},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(description),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}