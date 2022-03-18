import 'dart:ui';

import 'package:blood_donor_web_admin/models/blood_donor.dart';
import 'package:blood_donor_web_admin/models/campaign.dart';
import 'package:blood_donor_web_admin/models/history_data.dart';
import 'package:blood_donor_web_admin/models/question.dart';
import 'package:blood_donor_web_admin/models/request.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../models/completed_donor.dart';
import '../models/donation_summary.dart';
import '../models/staff.dart';

class Constants {
  static const appColorBrownRed = Color(0xffD92027);
  static const appColorBrownRedLight = Color(0xffff5d51);
  static const appColorWhite = Color(0xffffffff);
  static const appColorBlack = Color(0xff000000);
  static const appColorGray = Color(0xffc4c4c4);

  static const MaterialColor appColorbrownRedSwatch =
      MaterialColor(0xffD92027, <int, Color>{
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

  List summaryList = [
    DonationSummary(
      group: "A",
      count: "100",
      svgSrc: "assets/icons/campaign-logo.svg",
      color: Color(0xffff2400),
    ),
    DonationSummary(
      group: "B",
      count: "150",
      svgSrc: "assets/icons/campaign-logo.svg",
      color: Color(0xFFFFA113),
    ),
    DonationSummary(
      group: "AB",
      count: "25",
      svgSrc: "assets/icons/campaign-logo.svg",
      color: Color(0xFF800000),
    ),
    DonationSummary(
      group: "O",
      count: "120",
      svgSrc: "assets/icons/campaign-logo.svg",
      color: Color(0xFF007EE5),
    ),
  ];

  List campaignsList = [
    Campaign(
        campaignId: "0xFF007EE5",
        title: "Maharagama",
        date: "01-03-2021",
        time: "8.00 am - 2.00 pm",
        status: "closed"),
    Campaign(
        campaignId: "0xFF007EE6",
        title: "Nugegoda",
        date: "27-02-2021",
        time: "8.00 am - 2.00 pm",
        status: "open"),
    Campaign(
        campaignId: "0xFF007EE7",
        title: "Gampaha",
        date: "23-02-2021",
        time: "8.00 am - 2.00 pm",
        status: "open"),
    Campaign(
        campaignId: "0xFF007EE8",
        title: "Kadawatha",
        date: "21-02-2021",
        time: "8.00 am - 2.00 pm",
        status: "closed"),
    Campaign(
        campaignId: "0xFF007EE9",
        title: "Ja-ela",
        date: "23-02-2021",
        time: "8.00 am - 2.00 pm",
        status: "open"),
    Campaign(
        campaignId: "0xFF007EE10",
        title: "Wattala",
        date: "25-02-2021",
        time: "8.00 am - 2.00 pm",
        status: "closed"),
    Campaign(
        campaignId: "0xFF007EE11",
        title: "Kiribathgoda",
        date: "25-02-2021",
        time: "8.00 am - 2.00 pm",
        status: "closed"),
  ];

  List<Request> requestList = [
    Request(donorId: "0xffff5d51", name: "a", status: "active"),
    Request(donorId: "0xffff5d52", name: "b", status: "active"),
    Request(donorId: "0xffff5d53", name: "c", status: "Pending"),
    Request(donorId: "0xffff5d54", name: "d", status: "Pending"),
    Request(donorId: "0xffff5d55", name: "e", status: "active"),
    Request(donorId: "0xffff5d56", name: "f", status: "active"),
    Request(donorId: "0xffff5d57", name: "g", status: "Pending"),
    Request(donorId: "0xffff5d58", name: "h", status: "active"),
    Request(donorId: "0xffff5d59", name: "i", status: "Pending"),
    Request(donorId: "0xffff5d510", name: "j", status: "Pending"),
  ];

  List<CompletedDonor> completedDonorList = [
    CompletedDonor(donorId: "0xffff5d51", name: "a", status: "Completed"),
    CompletedDonor(donorId: "0xffff5d52", name: "b", status: "Completed"),
    CompletedDonor(donorId: "0xffff5d53", name: "c", status: "Completed"),
    CompletedDonor(donorId: "0xffff5d54", name: "d", status: "Completed"),
    CompletedDonor(donorId: "0xffff5d55", name: "e", status: "Completed"),
    CompletedDonor(donorId: "0xffff5d56", name: "f", status: "Completed"),
    CompletedDonor(donorId: "0xffff5d57", name: "g", status: "Completed"),
    CompletedDonor(donorId: "0xffff5d58", name: "h", status: "Completed"),
    CompletedDonor(donorId: "0xffff5d59", name: "i", status: "Completed"),
    CompletedDonor(donorId: "0xffff5d510", name: "j", status: "Completed"),
  ];

  List<Question> qaList = [
    Question(qno: "1", question: "question 1", answer: "yes"),
    Question(qno: "2", question: "question 2", answer: "yes"),
    Question(qno: "3", question: "question 3", answer: "yes"),
    Question(qno: "4", question: "question 4", answer: "no"),
    Question(qno: "5", question: "question 5", answer: "yes"),
    Question(qno: "6", question: "question 6", answer: "yes"),
    Question(qno: "7", question: "question 7", answer: "no"),
    Question(qno: "8", question: "question 8", answer: "yes"),
    Question(qno: "9", question: "question 9", answer: "yes"),
    Question(qno: "10", question: "question 10", answer: "no"),
  ];

  List<Staff> currentStaffList = [
    Staff(
        staffId: "001",
        name: "A",
        email: "abc1@a.com",
        phone: "1234567",
        status: "active"),
    Staff(
        staffId: "002",
        name: "B",
        email: "abc2@a.com",
        phone: "1234567",
        status: "inactive"),
    Staff(
        staffId: "003",
        name: "C",
        email: "abc3@a.com",
        phone: "1234567",
        status: "active"),
    Staff(
        staffId: "004",
        name: "D",
        email: "abc4@a.com",
        phone: "1234567",
        status: "inactive"),
    Staff(
        staffId: "005",
        name: "E",
        email: "abc5@a.com",
        phone: "1234567",
        status: "active"),
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

  List<HistoryData> historyDataList = [
    HistoryData(type: "Donor name and Id Is verified", result: "yes"),
    HistoryData(type: "Barcode", result: "58394893"),
    HistoryData(type: "Weight", result: "67Kg"),
    HistoryData(type: "Last Meal(<4 hrs)?", result: "yes"),
    HistoryData(type: "Any Allergies or Medications", result: "No"),
    HistoryData(type: "Adequate overnight sleep? (>6hrs)", result: "Yes"),
    HistoryData(type: "Ever Hospitalized?", result: "No"),
    HistoryData(type: "High risk Behaviors", result: "No"),
    HistoryData(type: "CVS status pulse", result: "130"),
    HistoryData(type: "BP", result: "90"),
    HistoryData(type: "Remark", result: "N/A"),
  ];

  List<BloodDonor> bloodDonorsList = [
    BloodDonor(
        donorId: "jdisjdsijd",
        name: "Name1",
        address: "address 1",
        gender: "male",
        dob: "dob1",
        status: "active",
        bloodGroup: "A+",
        donationCount: "2",
        donationHistory: ["489384", "489384"],
        lastDonatedDate: "2021/01/22",
        nic: "4738398493V",
        phone: "123456789"),
    BloodDonor(
        donorId: "jdisjdsijd",
        name: "Name1",
        address: "address 1",
        gender: "male",
        dob: "dob1",
        status: "active",
        bloodGroup: "A+",
        donationCount: "2",
        donationHistory: ["489384", "489384"],
        lastDonatedDate: "2021/01/22",
        nic: "4738398493V",
        phone: "123456789"),
    BloodDonor(
        donorId: "jdisjdsijd",
        name: "Name2",
        address: "address 2",
        gender: "male",
        dob: "dob1",
        status: "active",
        bloodGroup: "A+",
        donationCount: "2",
        donationHistory: ["489384", "489384"],
        lastDonatedDate: "2021/01/22",
        nic: "4738398493V",
        phone: "123456789"),
    BloodDonor(
        donorId: "jdisjdsijd",
        name: "Name3",
        address: "address 3",
        gender: "male",
        dob: "dob1",
        status: "active",
        bloodGroup: "A+",
        donationCount: "1",
        donationHistory: ["489384"],
        lastDonatedDate: "2021/01/22",
        nic: "4738398493V",
        phone: "123456789"),
    BloodDonor(
        donorId: "jdisjdsijd",
        name: "Name3",
        address: "address 3",
        gender: "male",
        dob: "dob1",
        status: "active",
        bloodGroup: "A+",
        donationCount: "3",
        donationHistory: ["489384", "489384", "489384"],
        lastDonatedDate: "2021/01/22",
        nic: "4738398493V",
        phone: "123456789"),
  ];

  static showAlertDialog(
      BuildContext context, String title, String description) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(description),
      actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Ok")),
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
