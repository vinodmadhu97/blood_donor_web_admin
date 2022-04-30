import 'package:blood_donor_web_admin/constants/constants.dart';
import 'package:blood_donor_web_admin/constants/widget_size.dart';
import 'package:blood_donor_web_admin/widgets/app_heading.dart';
import 'package:blood_donor_web_admin/widgets/app_label.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:intl/intl.dart';

import '../../services/firebase_services.dart';

class DonorManagementScreen extends StatefulWidget {
  final DocumentSnapshot profileData;
  final DocumentSnapshot assessmentData;
  final String campaignId;
  final String donorId;

  const DonorManagementScreen(
      {Key? key,
      required this.profileData,
      required this.assessmentData,
      required this.donorId,
      required this.campaignId})
      : super(key: key);

  @override
  _DonorManagementScreenState createState() => _DonorManagementScreenState(
      profileData: profileData, assessmentData: assessmentData);
}

class _DonorManagementScreenState extends State<DonorManagementScreen> {
  final DocumentSnapshot profileData;
  final DocumentSnapshot assessmentData;

  bool verified = false;
  int counter = 0;
  bool feelingWell = false;
  bool isSleep = false;
  bool lastMeal = false;
  bool hospitalised = false;
  bool allergies = false;
  bool riskBehaviours = false;
  bool deferral = false;

  TextEditingController barcodeController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController bloodGroupController = TextEditingController();
  TextEditingController cvsStatusController = TextEditingController();
  TextEditingController bpController = TextEditingController();
  TextEditingController deferralController = TextEditingController();
  TextEditingController remarksController = TextEditingController();

  _DonorManagementScreenState(
      {required this.profileData, required this.assessmentData});
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> assessment =
        assessmentData.data() as Map<String, dynamic>;
    List<Widget> answers = assessment.entries
        .map((value) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text(value.key), Text(value.value)],
              ),
            ))
        .toList();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Card(
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 100,
                                height: 100,
                                child: ClipOval(
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: profileData['profileUrl'],
                                    placeholder: (context, url) =>
                                        new CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        ClipRRect(
                                      borderRadius: BorderRadius.circular(65),
                                      child: Image.asset(
                                          "assets/images/profile_avatar.jpg"),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                children: [
                                  AppHeading(
                                    widgetSize: WidgetSize.medium,
                                    text: profileData['fullName'],
                                    color: Constants.appColorBrownRed,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  AppHeading(
                                    widgetSize: WidgetSize.small,
                                    text: profileData['address'],
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  AppHeading(
                                    widgetSize: WidgetSize.small,
                                    text: profileData['phone'],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 20),
                          child: Row(
                            children: [
                              Spacer(
                                flex: 1,
                              ),
                              Column(
                                children: [
                                  Text(
                                    'Group',
                                    style: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 14.0),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    profileData['bloodGroup'].toString().isEmpty
                                        ? "N/A"
                                        : profileData['bloodGroup'],
                                    style: TextStyle(
                                      fontSize: 15.0,
                                    ),
                                  )
                                ],
                              ),
                              Spacer(
                                flex: 1,
                              ),
                              Column(
                                children: [
                                  Text(
                                    'DOB',
                                    style: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 14.0),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    profileData['dob'],
                                    style: TextStyle(
                                      fontSize: 15.0,
                                    ),
                                  )
                                ],
                              ),
                              Spacer(
                                flex: 1,
                              ),
                              Column(
                                children: [
                                  Text(
                                    'NIC',
                                    style: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 14.0),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    profileData['nic'],
                                    style: TextStyle(
                                      fontSize: 15.0,
                                    ),
                                  )
                                ],
                              ),
                              Spacer(
                                flex: 1,
                              ),
                              Column(
                                children: [
                                  Text(
                                    'Donations',
                                    style: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 14.0),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    profileData['numberOfDonation'],
                                    style: TextStyle(
                                      fontSize: 15.0,
                                    ),
                                  )
                                ],
                              ),
                              Spacer(
                                flex: 1,
                              ),
                              Column(
                                children: [
                                  Text(
                                    'Last Donation',
                                    style: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 14.0),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    profileData['nextDonationDate']
                                            .toString()
                                            .isEmpty
                                        ? "N/A"
                                        : profileData['nextDonationDate'],
                                    style: TextStyle(
                                      fontSize: 15.0,
                                    ),
                                  )
                                ],
                              ),
                              Spacer(
                                flex: 1,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                          elevation: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(children: answers),
                          ))
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Card(
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Row(
                            children: [
                              Spacer(
                                flex: 1,
                              ),
                              const Icon(
                                Icons.verified_user_rounded,
                                color: Colors.green,
                                size: 40,
                              ),
                              Spacer(
                                flex: 1,
                              ),
                              AppLabel(
                                  text: "Is verified Donor?",
                                  widgetSize: WidgetSize.large),
                              Spacer(
                                flex: 1,
                              ),
                              Container(
                                child: FlutterSwitch(
                                  width: 60.0,
                                  height: 30.0,
                                  valueFontSize: 10.0,
                                  toggleSize: 20.0,
                                  value: verified,
                                  activeText: "Yes",
                                  activeColor: Colors.green,
                                  inactiveColor: Colors.red,
                                  inactiveText: "No",
                                  borderRadius: 20.0,
                                  padding: 8.0,
                                  showOnOff: true,
                                  onToggle: (val) {
                                    setState(() {
                                      verified = val;
                                    });
                                  },
                                ),
                              ),
                              Spacer(
                                flex: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 60,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: AppLabel(
                                      text: "Barcode",
                                      widgetSize: WidgetSize.large,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: SizedBox(
                                      height: 40,
                                      width: 300,
                                      child: TextField(
                                        controller: barcodeController,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Constants.appColorBlack,
                                            fontSize: 14),
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          hintStyle: TextStyle(
                                              color: Constants.appColorGray,
                                              fontSize: 14),
                                          hintText: "Barcode number",
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                            borderSide: BorderSide(
                                              color: Constants.appColorBrownRed,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                            borderSide: BorderSide(
                                              color: Constants.appColorGray,
                                              width: 1.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Spacer(
                                    flex: 4,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 60,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: AppLabel(
                                      text: "Weight(Kg)",
                                      widgetSize: WidgetSize.large,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: SizedBox(
                                      height: 40,
                                      width: 300,
                                      child: TextField(
                                        controller: weightController,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Constants.appColorBlack,
                                            fontSize: 14),
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          hintStyle: TextStyle(
                                              color: Constants.appColorGray,
                                              fontSize: 14),
                                          hintText: "Kg",
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                            borderSide: BorderSide(
                                              color: Constants.appColorBrownRed,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                            borderSide: BorderSide(
                                              color: Constants.appColorGray,
                                              width: 1.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Spacer(
                                    flex: 4,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 60,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: AppLabel(
                                      text: "Blood Group",
                                      widgetSize: WidgetSize.large,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: SizedBox(
                                      height: 40,
                                      width: 300,
                                      child: TextField(
                                        controller: bloodGroupController,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Constants.appColorBlack,
                                            fontSize: 14),
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          hintStyle: TextStyle(
                                              color: Constants.appColorGray,
                                              fontSize: 14),
                                          hintText: "Blood Group",
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                            borderSide: BorderSide(
                                              color: Constants.appColorBrownRed,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                            borderSide: BorderSide(
                                              color: Constants.appColorGray,
                                              width: 1.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Spacer(
                                    flex: 4,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 60,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: AppLabel(
                                      text: "CVS Pulse",
                                      widgetSize: WidgetSize.large,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: SizedBox(
                                      height: 40,
                                      width: 300,
                                      child: TextField(
                                        controller: cvsStatusController,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Constants.appColorBlack,
                                            fontSize: 14),
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          hintStyle: TextStyle(
                                              color: Constants.appColorGray,
                                              fontSize: 14),
                                          hintText: "CVS Pulse Status",
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                            borderSide: BorderSide(
                                              color: Constants.appColorBrownRed,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                            borderSide: BorderSide(
                                              color: Constants.appColorGray,
                                              width: 1.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Spacer(
                                    flex: 4,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 60,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: AppLabel(
                                      text: "BP",
                                      widgetSize: WidgetSize.large,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: SizedBox(
                                      height: 40,
                                      width: 300,
                                      child: TextField(
                                        controller: bpController,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Constants.appColorBlack,
                                            fontSize: 14),
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          hintStyle: TextStyle(
                                              color: Constants.appColorGray,
                                              fontSize: 14),
                                          hintText: "BP Value",
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                            borderSide: BorderSide(
                                              color: Constants.appColorBrownRed,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                            borderSide: BorderSide(
                                              color: Constants.appColorGray,
                                              width: 1.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Spacer(
                                    flex: 4,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        elevation: 0,
                        child: Row(
                          children: [
                            Expanded(
                                child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Feeling well?"),
                                        Container(
                                          child: FlutterSwitch(
                                            width: 60.0,
                                            height: 30.0,
                                            valueFontSize: 10.0,
                                            toggleSize: 20.0,
                                            value: feelingWell,
                                            activeColor: Colors.green,
                                            activeText: "Yes",
                                            inactiveText: "No",
                                            inactiveColor:
                                                Constants.appColorBrownRed,
                                            borderRadius: 20.0,
                                            padding: 8.0,
                                            showOnOff: true,
                                            onToggle: (val) {
                                              setState(() {
                                                feelingWell = val;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Last meal (<4hrs)?"),
                                        Container(
                                          child: FlutterSwitch(
                                            width: 60.0,
                                            height: 30.0,
                                            valueFontSize: 10.0,
                                            toggleSize: 20.0,
                                            value: lastMeal,
                                            activeColor: Colors.green,
                                            inactiveColor:
                                                Constants.appColorBrownRed,
                                            activeText: "Yes",
                                            inactiveText: "No",
                                            borderRadius: 20.0,
                                            padding: 8.0,
                                            showOnOff: true,
                                            onToggle: (val) {
                                              setState(() {
                                                lastMeal = val;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            "No Any Allergies or medications?"),
                                        Container(
                                          child: FlutterSwitch(
                                            width: 60.0,
                                            height: 30.0,
                                            valueFontSize: 10.0,
                                            toggleSize: 20.0,
                                            value: allergies,
                                            activeColor: Colors.green,
                                            inactiveColor:
                                                Constants.appColorBrownRed,
                                            activeText: "Yes",
                                            inactiveText: "No",
                                            borderRadius: 20.0,
                                            padding: 8.0,
                                            showOnOff: true,
                                            onToggle: (val) {
                                              setState(() {
                                                allergies = val;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )),
                            Expanded(
                                child: Container(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Adequate overnight sleep?(>6hrs)"),
                                      Container(
                                        child: FlutterSwitch(
                                          width: 60.0,
                                          height: 30.0,
                                          valueFontSize: 10.0,
                                          toggleSize: 20.0,
                                          value: isSleep,
                                          activeColor: Colors.green,
                                          inactiveColor:
                                              Constants.appColorBrownRed,
                                          activeText: "Yes",
                                          inactiveText: "No",
                                          borderRadius: 20.0,
                                          padding: 8.0,
                                          showOnOff: true,
                                          onToggle: (val) {
                                            setState(() {
                                              isSleep = val;
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Ever Hospitalised?"),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        child: FlutterSwitch(
                                          width: 60.0,
                                          height: 30.0,
                                          valueFontSize: 10.0,
                                          toggleSize: 20.0,
                                          value: hospitalised,
                                          activeColor: Colors.green,
                                          inactiveColor:
                                              Constants.appColorBrownRed,
                                          activeText: "Yes",
                                          inactiveText: "No",
                                          borderRadius: 20.0,
                                          padding: 8.0,
                                          showOnOff: true,
                                          onToggle: (val) {
                                            setState(() {
                                              hospitalised = val;
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("High risk behaviours?"),
                                      Container(
                                        child: FlutterSwitch(
                                          width: 60.0,
                                          height: 30.0,
                                          valueFontSize: 10.0,
                                          toggleSize: 20.0,
                                          value: riskBehaviours,
                                          activeColor: Colors.green,
                                          inactiveColor:
                                              Constants.appColorBrownRed,
                                          activeText: "Yes",
                                          inactiveText: "No",
                                          borderRadius: 20.0,
                                          padding: 8.0,
                                          showOnOff: true,
                                          onToggle: (val) {
                                            setState(() {
                                              riskBehaviours = val;
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(),
                ),
                Expanded(
                    flex: 4,
                    child: Card(
                      elevation: 0,
                      color: Constants.appColorGray.withOpacity(0.5),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50.0, vertical: 30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text("Deferral?"),
                                SizedBox(
                                  width: 30,
                                ),
                                Container(
                                  child: FlutterSwitch(
                                    width: 60.0,
                                    height: 30.0,
                                    valueFontSize: 10.0,
                                    toggleSize: 20.0,
                                    value: deferral,
                                    activeColor: Constants.appColorBrownRed,
                                    activeText: "Yes",
                                    inactiveText: "No",
                                    borderRadius: 20.0,
                                    padding: 8.0,
                                    showOnOff: true,
                                    onToggle: (val) {
                                      setState(() {
                                        deferral = val;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Visibility(
                                  visible: deferral,
                                  child: Row(
                                    children: [
                                      Text("Reasons for deferral"),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      SizedBox(
                                        height: 40,
                                        width: 300,
                                        child: TextField(
                                          controller: deferralController,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Constants.appColorBlack,
                                              fontSize: 14),
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                            hintStyle: TextStyle(
                                                color: Constants.appColorGray,
                                                fontSize: 14),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4.0),
                                              borderSide: BorderSide(
                                                color:
                                                    Constants.appColorBrownRed,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4.0),
                                              borderSide: BorderSide(
                                                color: Constants.appColorGray,
                                                width: 1.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Text("Remarks"),
                                SizedBox(
                                  width: 30,
                                ),
                                SizedBox(
                                  height: 40,
                                  width: 300,
                                  child: TextField(
                                    controller: remarksController,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Constants.appColorBlack,
                                        fontSize: 14),
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintStyle: TextStyle(
                                          color: Constants.appColorGray,
                                          fontSize: 14),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        borderSide: BorderSide(
                                          color: Constants.appColorBrownRed,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        borderSide: BorderSide(
                                          color: Constants.appColorGray,
                                          width: 1.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Visibility(
                                  child: SizedBox(
                                    height: 40,
                                    child: ElevatedButton(
                                        onPressed: () async {
                                          if (!deferral) {
                                            if (isVerifiedForAccept()) {
                                              print(barcodeController.text);
                                              print("verify $verified");
                                              print(weightController.text);
                                              print(bloodGroupController.text);
                                              print("feeling $feelingWell");
                                              print("last meel $lastMeal");
                                              print("alagi $allergies");
                                              print("sleep $isSleep");
                                              print(
                                                  "hospitalized $hospitalised");
                                              print("risk $riskBehaviours");
                                              print(cvsStatusController.text);
                                              print(bpController.text);
                                              print(deferral);
                                              print(remarksController.text);

                                              DateTime now = DateTime.now();
                                              var formatterDate =
                                                  DateFormat('yyyy-MM-dd');
                                              String actualDate =
                                                  formatterDate.format(now);

                                              Map<String, dynamic> data = {
                                                "isVerified":
                                                    verified ? "yes" : "no",
                                                "barcode":
                                                    barcodeController.text,
                                                "weight": weightController.text,
                                                "bloodGroup":
                                                    bloodGroupController.text,
                                                "feelingWell":
                                                    feelingWell ? "yes" : "no",
                                                "lastMeal":
                                                    lastMeal ? "yes" : "no",
                                                "allergies":
                                                    allergies ? "yes" : "no",
                                                "isSlept":
                                                    isSleep ? "yes" : "no",
                                                "hospitalized":
                                                    hospitalised ? "yes" : "no",
                                                "isRisk": riskBehaviours
                                                    ? "yes"
                                                    : "no",
                                                "cvs": cvsStatusController.text,
                                                "bp": bpController.text,
                                                "deferral":
                                                    deferral ? "yes" : "no",
                                                "remark":
                                                    remarksController.text,
                                                "remarkForDeferral": "",
                                                "accept": "yes",
                                                "date": actualDate
                                              };

                                              await FirebaseServices()
                                                  .setMedicalReport(
                                                      context,
                                                      widget.campaignId,
                                                      widget.donorId,
                                                      data);
                                            } else {
                                              Constants.showAlertDialog(
                                                  context,
                                                  "Alert",
                                                  "Please Fill out the All Fields");
                                            }
                                          }
                                        },
                                        child: Text("Accept")),
                                  ),
                                  visible: !deferral,
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                SizedBox(
                                  height: 40,
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        if (deferral) {
                                          if (isVerifiedForReject()) {
                                            DateTime now = DateTime.now();
                                            var formatterDate =
                                                DateFormat('yyyy-MM-dd');
                                            String actualDate =
                                                formatterDate.format(now);

                                            Map<String, dynamic> data = {
                                              "isVerified":
                                                  verified ? "yes" : "no",
                                              "barcode": barcodeController.text,
                                              "weight": weightController.text,
                                              "bloodGroup":
                                                  bloodGroupController.text,
                                              "feelingWell":
                                                  feelingWell ? "yes" : "no",
                                              "lastMeal":
                                                  lastMeal ? "yes" : "no",
                                              "allergies":
                                                  allergies ? "yes" : "no",
                                              "isSlept": isSleep ? "yes" : "no",
                                              "hospitalized":
                                                  hospitalised ? "yes" : "no",
                                              "isRisk":
                                                  riskBehaviours ? "yes" : "no",
                                              "cvs": cvsStatusController.text,
                                              "bp": bpController.text,
                                              "deferral":
                                                  deferral ? "yes" : "no",
                                              "remark": remarksController.text,
                                              "remarkForDeferral":
                                                  deferralController.text,
                                              "accept": "no",
                                              "date": actualDate
                                            };

                                            print(data);

                                            await FirebaseServices()
                                                .setMedicalReport(
                                                    context,
                                                    widget.campaignId,
                                                    widget.donorId,
                                                    data);
                                          }
                                        } else if (!deferral) {
                                          DateTime now = DateTime.now();
                                          var formatterDate =
                                              DateFormat('yyyy-MM-dd');
                                          String actualDate =
                                              formatterDate.format(now);

                                          Map<String, dynamic> data = {
                                            "isVerified":
                                                verified ? "yes" : "no",
                                            "barcode": barcodeController.text,
                                            "weight": weightController.text,
                                            "bloodGroup":
                                                bloodGroupController.text,
                                            "feelingWell":
                                                feelingWell ? "yes" : "no",
                                            "lastMeal": lastMeal ? "yes" : "no",
                                            "allergies":
                                                allergies ? "yes" : "no",
                                            "isSlept": isSleep ? "yes" : "no",
                                            "hospitalized":
                                                hospitalised ? "yes" : "no",
                                            "isRisk":
                                                riskBehaviours ? "yes" : "no",
                                            "cvs": cvsStatusController.text,
                                            "bp": bpController.text,
                                            "deferral": deferral ? "yes" : "no",
                                            "remark": remarksController.text,
                                            "remarkForDeferral":
                                                deferralController.text,
                                            "accept": "no",
                                            "date": actualDate
                                          };

                                          await FirebaseServices()
                                              .setMedicalReport(
                                                  context,
                                                  widget.campaignId,
                                                  widget.donorId,
                                                  data);
                                        }
                                      },
                                      child: Text("Reject"),
                                      style: ElevatedButton.styleFrom(
                                          primary: !deferral
                                              ? Constants.appColorGray
                                              : Constants.appColorBrownRed)),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    )),
                Expanded(
                  flex: 2,
                  child: Container(),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  bool isVerifiedForAccept() {
    if (barcodeController.text.isEmpty) {
      return false;
    } else if (weightController.text.isEmpty) {
      return false;
    } else if (bloodGroupController.text.isEmpty) {
      return false;
    } else if (cvsStatusController.text.isEmpty) {
      return false;
    } else if (bpController.text.isEmpty) {
      return false;
    } else if (remarksController.text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  bool isVerifiedForReject() {
    if (barcodeController.text.isEmpty) {
      return false;
    } else if (weightController.text.isEmpty) {
      return false;
    } else if (bloodGroupController.text.isEmpty) {
      return false;
    } else if (cvsStatusController.text.isEmpty) {
      return false;
    } else if (bpController.text.isEmpty) {
      return false;
    } else if (deferralController.text.isEmpty) {
      return false;
    } else if (remarksController.text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }
}

/*import 'package:blood_donor_web_admin/constants/constants.dart';
import 'package:blood_donor_web_admin/screens/shimmers/table_shimmer.dart';
import 'package:blood_donor_web_admin/services/firebase_services.dart';
import 'package:blood_donor_web_admin/widgets/q&a_list.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:intl/intl.dart';

class DonorManagementScreen extends StatefulWidget {
  final String campaignId;
  final String donorId;

  DonorManagementScreen({required this.campaignId, required this.donorId});

  @override
  _DonorManagementScreenState createState() => _DonorManagementScreenState();
}

class _DonorManagementScreenState extends State<DonorManagementScreen> {
  int counter = 0;
  bool verified = false;
  bool feelingWell = false;
  bool isSleep = false;
  bool lastMeal = false;
  bool hospitalised = false;
  bool allergies = false;
  bool riskBehaviours = false;
  bool deferral = false;

  TextEditingController barcodeController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController bloodGroupController = TextEditingController();
  TextEditingController cvsStatusController = TextEditingController();
  TextEditingController bpController = TextEditingController();
  TextEditingController deferralController = TextEditingController();
  TextEditingController remarksController = TextEditingController();

  bool isVerifiedForReject() {
    if (barcodeController.text.isEmpty) {
      return false;
    } else if (weightController.text.isEmpty) {
      return false;
    } else if (bloodGroupController.text.isEmpty) {
      return false;
    } else if (cvsStatusController.text.isEmpty) {
      return false;
    } else if (bpController.text.isEmpty) {
      return false;
    } else if (deferralController.text.isEmpty) {
      return false;
    } else if (remarksController.text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  bool isVerifiedForAccept() {
    if (barcodeController.text.isEmpty) {
      return false;
    } else if (weightController.text.isEmpty) {
      return false;
    } else if (bloodGroupController.text.isEmpty) {
      return false;
    } else if (cvsStatusController.text.isEmpty) {
      return false;
    } else if (bpController.text.isEmpty) {
      return false;
    } else if (remarksController.text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                FutureBuilder(
                    future:
                        FirebaseServices().getDonorDetailsById(widget.donorId),
                    builder: (ctx, AsyncSnapshot snapshot) {
                      if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return TableShimmer();
                      }

                      return Column(
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Constants.appColorBrownRed,
                                  Constants.appColorBrownRedLight
                                ],
                              ),
                            ),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  CircleAvatar(
                                    radius: 65.0,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(65),
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl: snapshot.data["profileUrl"],
                                        placeholder: (context, url) =>
                                            new CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(65),
                                          child: Image.asset(
                                              "assets/images/profile_avatar.jpg"),
                                        ),
                                      ),
                                    ),
                                    backgroundColor: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(snapshot.data['fullName'],
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0,
                                          )),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                        snapshot.data['address'],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                        snapshot.data['phone'],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15.0,
                                        ),
                                      )
                                    ],
                                  )
                                ]),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Card(
                              child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                    child: Column(
                                  children: [
                                    Text(
                                      'Group',
                                      style: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 14.0),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      snapshot.data['bloodGroup'].isNotEmpty
                                          ? snapshot.data['bloodGroup']
                                          : "N/A",
                                      style: TextStyle(
                                        fontSize: 15.0,
                                      ),
                                    )
                                  ],
                                )),
                                Container(
                                  child: Column(children: [
                                    Text(
                                      'Birthday',
                                      style: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 14.0),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      snapshot.data['dob'],
                                      style: TextStyle(
                                        fontSize: 15.0,
                                      ),
                                    )
                                  ]),
                                ),
                                Container(
                                  child: Column(children: [
                                    Text(
                                      'NIC',
                                      style: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 14.0),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      snapshot.data['nic'],
                                      style: TextStyle(
                                        fontSize: 15.0,
                                      ),
                                    )
                                  ]),
                                ),
                                Container(
                                    child: Column(
                                  children: [
                                    Text(
                                      'Number of Donations',
                                      style: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 14.0),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      snapshot.data['numberOfDonation'],
                                      style: TextStyle(
                                        fontSize: 15.0,
                                      ),
                                    )
                                  ],
                                )),
                                Container(
                                    child: Column(
                                  children: [
                                    Text(
                                      'Last Donations Date',
                                      style: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 14.0),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                      Text(
                                      snapshot.data['nextDonationDate']
                                              .isNotEmpty
                                          ? snapshot.data['nextDonationDate']
                                          : "N/A",
                                      style: TextStyle(
                                        fontSize: 15.0,
                                      ),
                                    )
                                  ],
                                )),
                              ],
                            ),
                          )),
                        ],
                      );
                    }),
                FutureBuilder(
                    future: Future.wait([
                      FirebaseServices().getDonorAssessmentData(
                          widget.donorId, widget.campaignId),
                    ]),
                    builder: (ctx, AsyncSnapshot snapshot) {
                      if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text("");
                      }
                      return Container(
                          width: double.infinity,
                          child: QAList(
                            snapshot: snapshot,
                          ));
                    }),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Report",
                  style: TextStyle(
                      color: Constants.appColorBrownRed, fontSize: 30),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                  "Donor name and ID card details are verified?"),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                child: FlutterSwitch(
                                  width: 60.0,
                                  height: 25.0,
                                  valueFontSize: 10.0,
                                  toggleSize: 20.0,
                                  value: verified,
                                  activeText: "Yes",
                                  activeColor: Constants.appColorBrownRed,
                                  inactiveText: "No",
                                  borderRadius: 20.0,
                                  padding: 8.0,
                                  showOnOff: true,
                                  onToggle: (val) {
                                    setState(() {
                                      verified = val;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 50,
                              ),
                              Text("barcode"),
                              SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                height: 45,
                                width: 200,
                                child: TextField(
                                  controller: barcodeController,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Constants.appColorBlack,
                                      fontSize: 14),
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                        color: Constants.appColorGray,
                                        fontSize: 14),
                                    hintText: "Barcode number",
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        color: Constants.appColorBrownRed,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        color: Constants.appColorGray,
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text("Medical assesment",
                              style: TextStyle(
                                  color: Constants.appColorBrownRed,
                                  fontSize: 20)),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Text("Weight(Kg)"),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    height: 40,
                                    width: 100,
                                    child: TextField(
                                      controller: weightController,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Constants.appColorBlack,
                                          fontSize: 14),
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        hintStyle: TextStyle(
                                            color: Constants.appColorGray,
                                            fontSize: 14),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Constants.appColorBrownRed,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Constants.appColorGray,
                                            width: 1.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                width: 50,
                              ),
                              Row(
                                children: [
                                  Text("Blood Group"),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    height: 40,
                                    width: 100,
                                    child: TextField(
                                      controller: bloodGroupController,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Constants.appColorBlack,
                                          fontSize: 14),
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        hintStyle: TextStyle(
                                            color: Constants.appColorGray,
                                            fontSize: 14),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Constants.appColorBrownRed,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Constants.appColorGray,
                                            width: 1.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "history",
                            style: TextStyle(
                                color: Constants.appColorGray, fontSize: 18),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 50,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Feling well?"),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            child: FlutterSwitch(
                                              width: 60.0,
                                              height: 25.0,
                                              valueFontSize: 10.0,
                                              toggleSize: 20.0,
                                              value: feelingWell,
                                              activeColor:
                                                  Constants.appColorBrownRed,
                                              activeText: "Yes",
                                              inactiveText: "No",
                                              borderRadius: 20.0,
                                              padding: 8.0,
                                              showOnOff: true,
                                              onToggle: (val) {
                                                setState(() {
                                                  feelingWell = val;
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Last meal (<4hrs)?"),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            child: FlutterSwitch(
                                              width: 60.0,
                                              height: 25.0,
                                              valueFontSize: 10.0,
                                              toggleSize: 20.0,
                                              value: lastMeal,
                                              activeColor:
                                                  Constants.appColorBrownRed,
                                              activeText: "Yes",
                                              inactiveText: "No",
                                              borderRadius: 20.0,
                                              padding: 8.0,
                                              showOnOff: true,
                                              onToggle: (val) {
                                                setState(() {
                                                  lastMeal = val;
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Any Allergies or medications?"),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            child: FlutterSwitch(
                                              width: 60.0,
                                              height: 25.0,
                                              valueFontSize: 10.0,
                                              toggleSize: 20.0,
                                              value: allergies,
                                              activeColor:
                                                  Constants.appColorBrownRed,
                                              activeText: "Yes",
                                              inactiveText: "No",
                                              borderRadius: 20.0,
                                              padding: 8.0,
                                              showOnOff: true,
                                              onToggle: (val) {
                                                setState(() {
                                                  allergies = val;
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 50,
                                      ),
                                      Row(
                                        children: [
                                          Row(
                                            children: [
                                              Text("CVS status pulse"),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              SizedBox(
                                                height: 40,
                                                width: 100,
                                                child: TextField(
                                                  controller:
                                                      cvsStatusController,
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      color: Constants
                                                          .appColorBlack,
                                                      fontSize: 14),
                                                  keyboardType:
                                                      TextInputType.text,
                                                  decoration: InputDecoration(
                                                    hintStyle: TextStyle(
                                                        color: Constants
                                                            .appColorGray,
                                                        fontSize: 14),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      borderSide: BorderSide(
                                                        color: Constants
                                                            .appColorBrownRed,
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      borderSide: BorderSide(
                                                        color: Constants
                                                            .appColorGray,
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            width: 50,
                                          ),
                                          Row(
                                            children: [
                                              Text("BP"),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              SizedBox(
                                                height: 40,
                                                width: 100,
                                                child: TextField(
                                                  controller: bpController,
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      color: Constants
                                                          .appColorBlack,
                                                      fontSize: 14),
                                                  keyboardType:
                                                      TextInputType.text,
                                                  decoration: InputDecoration(
                                                    hintStyle: TextStyle(
                                                        color: Constants
                                                            .appColorGray,
                                                        fontSize: 14),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      borderSide: BorderSide(
                                                        color: Constants
                                                            .appColorBrownRed,
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      borderSide: BorderSide(
                                                        color: Constants
                                                            .appColorGray,
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  )),
                              SizedBox(
                                width: 40,
                              ),
                              Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              "Adequate overnight sleep?(>6hrs)"),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            child: FlutterSwitch(
                                              width: 60.0,
                                              height: 25.0,
                                              valueFontSize: 10.0,
                                              toggleSize: 20.0,
                                              value: isSleep,
                                              activeColor:
                                                  Constants.appColorBrownRed,
                                              activeText: "Yes",
                                              inactiveText: "No",
                                              borderRadius: 20.0,
                                              padding: 8.0,
                                              showOnOff: true,
                                              onToggle: (val) {
                                                setState(() {
                                                  isSleep = val;
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Ever Hospitalised?"),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            child: FlutterSwitch(
                                              width: 60.0,
                                              height: 25.0,
                                              valueFontSize: 10.0,
                                              toggleSize: 20.0,
                                              value: hospitalised,
                                              activeColor:
                                                  Constants.appColorBrownRed,
                                              activeText: "Yes",
                                              inactiveText: "No",
                                              borderRadius: 20.0,
                                              padding: 8.0,
                                              showOnOff: true,
                                              onToggle: (val) {
                                                setState(() {
                                                  hospitalised = val;
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("High risk behaviours?"),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            child: FlutterSwitch(
                                              width: 60.0,
                                              height: 25.0,
                                              valueFontSize: 10.0,
                                              toggleSize: 20.0,
                                              value: riskBehaviours,
                                              activeColor:
                                                  Constants.appColorBrownRed,
                                              activeText: "Yes",
                                              inactiveText: "No",
                                              borderRadius: 20.0,
                                              padding: 8.0,
                                              showOnOff: true,
                                              onToggle: (val) {
                                                setState(() {
                                                  riskBehaviours = val;
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text("Deferral?"),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                child: FlutterSwitch(
                                  width: 60.0,
                                  height: 25.0,
                                  valueFontSize: 10.0,
                                  toggleSize: 20.0,
                                  value: deferral,
                                  activeColor: Constants.appColorBrownRed,
                                  activeText: "Yes",
                                  inactiveText: "No",
                                  borderRadius: 20.0,
                                  padding: 8.0,
                                  showOnOff: true,
                                  onToggle: (val) {
                                    setState(() {
                                      deferral = val;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Visibility(
                            visible: deferral,
                            child: Row(
                              children: [
                                Text("Reasons for deferral"),
                                SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  height: 40,
                                  width: 300,
                                  child: TextField(
                                    controller: deferralController,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Constants.appColorBlack,
                                        fontSize: 14),
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintStyle: TextStyle(
                                          color: Constants.appColorGray,
                                          fontSize: 14),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                          color: Constants.appColorBrownRed,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                          color: Constants.appColorGray,
                                          width: 1.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text("Remarks"),
                              SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                height: 40,
                                width: 300,
                                child: TextField(
                                  controller: remarksController,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Constants.appColorBlack,
                                      fontSize: 14),
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                        color: Constants.appColorGray,
                                        fontSize: 14),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        color: Constants.appColorBrownRed,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        color: Constants.appColorGray,
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Visibility(
                                child: ElevatedButton(
                                    onPressed: () async {
                                      if (!deferral) {
                                        if (isVerifiedForAccept()) {
                                          print(barcodeController.text);
                                          print("verify $verified");
                                          print(weightController.text);
                                          print(bloodGroupController.text);
                                          print("feeling $feelingWell");
                                          print("last meel $lastMeal");
                                          print("alagi $allergies");
                                          print("sleep $isSleep");
                                          print("hospitalized $hospitalised");
                                          print("risk $riskBehaviours");
                                          print(cvsStatusController.text);
                                          print(bpController.text);
                                          print(deferral);
                                          print(remarksController.text);

                                          DateTime now = DateTime.now();
                                          var formatterDate =
                                              DateFormat('yyyy-MM-dd');
                                          String actualDate =
                                              formatterDate.format(now);

                                          Map<String, dynamic> data = {
                                            "isVerified":
                                                verified ? "yes" : "no",
                                            "barcode": barcodeController.text,
                                            "weight": weightController.text,
                                            "bloodGroup":
                                                bloodGroupController.text,
                                            "feelingWell":
                                                feelingWell ? "yes" : "no",
                                            "lastMeal": lastMeal ? "yes" : "no",
                                            "allergies":
                                                allergies ? "yes" : "no",
                                            "isSlept": isSleep ? "yes" : "no",
                                            "hospitalized":
                                                hospitalised ? "yes" : "no",
                                            "isRisk":
                                                riskBehaviours ? "yes" : "no",
                                            "cvs": cvsStatusController.text,
                                            "bp": bpController.text,
                                            "deferral": deferral ? "yes" : "no",
                                            "remark": remarksController.text,
                                            "remarkForDeferral": "",
                                            "accept": "yes",
                                            "date": actualDate
                                          };

                                          await FirebaseServices()
                                              .setMedicalReport(
                                                  context,
                                                  widget.campaignId,
                                                  widget.donorId,
                                                  data);
                                        } else {
                                          Constants.showAlertDialog(
                                              context,
                                              "Alert",
                                              "Please Fill out the All Fields");
                                        }
                                      }
                                    },
                                    child: Text("Accept")),
                                visible: !deferral,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              ElevatedButton(
                                  onPressed: () async {
                                    if (deferral) {
                                      if (isVerifiedForReject()) {
                                        DateTime now = DateTime.now();
                                        var formatterDate =
                                            DateFormat('yyyy-MM-dd');
                                        String actualDate =
                                            formatterDate.format(now);

                                        Map<String, dynamic> data = {
                                          "isVerified": verified ? "yes" : "no",
                                          "barcode": barcodeController.text,
                                          "weight": weightController.text,
                                          "bloodGroup":
                                              bloodGroupController.text,
                                          "feelingWell":
                                              feelingWell ? "yes" : "no",
                                          "lastMeal": lastMeal ? "yes" : "no",
                                          "allergies": allergies ? "yes" : "no",
                                          "isSlept": isSleep ? "yes" : "no",
                                          "hospitalized":
                                              hospitalised ? "yes" : "no",
                                          "isRisk":
                                              riskBehaviours ? "yes" : "no",
                                          "cvs": cvsStatusController.text,
                                          "bp": bpController.text,
                                          "deferral": deferral ? "yes" : "no",
                                          "remark": remarksController.text,
                                          "remarkForDeferral":
                                              deferralController.text,
                                          "accept": "no",
                                          "date": actualDate
                                        };

                                        await FirebaseServices()
                                            .setMedicalReport(
                                                context,
                                                widget.campaignId,
                                                widget.donorId,
                                                data);
                                      }
                                    } else if (!deferral) {
                                      DateTime now = DateTime.now();
                                      var formatterDate =
                                          DateFormat('yyyy-MM-dd');
                                      String actualDate =
                                          formatterDate.format(now);

                                      Map<String, dynamic> data = {
                                        "isVerified": verified ? "yes" : "no",
                                        "barcode": barcodeController.text,
                                        "weight": weightController.text,
                                        "bloodGroup": bloodGroupController.text,
                                        "feelingWell":
                                            feelingWell ? "yes" : "no",
                                        "lastMeal": lastMeal ? "yes" : "no",
                                        "allergies": allergies ? "yes" : "no",
                                        "isSlept": isSleep ? "yes" : "no",
                                        "hospitalized":
                                            hospitalised ? "yes" : "no",
                                        "isRisk": riskBehaviours ? "yes" : "no",
                                        "cvs": cvsStatusController.text,
                                        "bp": bpController.text,
                                        "deferral": deferral ? "yes" : "no",
                                        "remark": remarksController.text,
                                        "remarkForDeferral":
                                            deferralController.text,
                                        "accept": "no",
                                        "date": actualDate
                                      };

                                      await FirebaseServices().setMedicalReport(
                                          context,
                                          widget.campaignId,
                                          widget.donorId,
                                          data);
                                    }
                                  },
                                  child: Text("Reject"),
                                  style: ElevatedButton.styleFrom(
                                      primary: !deferral
                                          ? Constants.appColorGray
                                          : Constants.appColorBrownRed))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 500,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}*/
