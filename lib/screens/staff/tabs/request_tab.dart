import 'package:blood_donor_web_admin/services/firebase_services.dart';
import 'package:blood_donor_web_admin/widgets/request_card_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:group_button/group_button.dart';
import 'package:intl/intl.dart';
import 'package:time_range/time_range.dart';

import '../../../constants/constants.dart';
import '../../../constants/custom_dialog_box.dart';
import '../../../widgets/app_input_field.dart';

class RequestTab extends StatefulWidget {
  RequestTab({
    Key? key,
  }) : super(key: key);

  @override
  State<RequestTab> createState() => _RequestTabState();
}

class _RequestTabState extends State<RequestTab> {
  TextEditingController dateController = TextEditingController();

  TextEditingController locationController = TextEditingController();

  GlobalKey<FormState> locationKey = GlobalKey<FormState>();

  TextEditingController addressController = TextEditingController();

  GlobalKey<FormState> addressKey = GlobalKey<FormState>();

  TextEditingController startController = TextEditingController();

  GlobalKey<FormState> startKey = GlobalKey<FormState>();

  int? startTime;

  int? endTime;

  DateTime selectedDate = DateTime.now();

  TextEditingController endController = TextEditingController();

  GlobalKey<FormState> endKey = GlobalKey<FormState>();

  final controller = GroupButtonController();
  String selectedBloodGroup = "";
  List<String> groups = ["A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              Expanded(
                  flex: 3,
                  child: SizedBox(
                      height: 500,
                      child: StreamBuilder(
                        stream: FirebaseServices().getAllRequests(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text(snapshot.error.toString());
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Text("loading");
                          } else {
                            return ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  return RequestCardView(
                                    group: snapshot.data!.docs[index]
                                        ['bloodGroup'],
                                    location: snapshot.data!.docs[index]
                                        ['location'],
                                    address: snapshot.data!.docs[index]
                                        ['address'],
                                    date: snapshot.data!.docs[index]
                                        ['startDate'],
                                    startTime: snapshot
                                        .data!.docs[index]['startTime']
                                        .toString(),
                                    endTime: snapshot
                                        .data!.docs[index]['endTime']
                                        .toString(),
                                  );
                                });
                          }
                        },
                      )
                      /*ListView.builder(
                        itemCount: 20,
                        itemBuilder: (context, index) {
                          return CampaignCardView(
                            group: "A+",
                            title: "Kalubowila Hospital",
                            imgUrl: "assets/images/campaign-1.jpg",
                            location:
                                "B229 Hospital Rd, Dehiwala-Mount Lavinia",
                            time: "2022/02/04 \nat 8.00 am - 2.00 pm",
                          );
                        }),*/
                      )),
              Expanded(flex: 2, child: Container()),
              Expanded(
                  flex: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GroupButton(
                        controller: controller,
                        isRadio: true,
                        spacing: 2,
                        groupingType: GroupingType.row,
                        direction: Axis.horizontal,
                        selectedTextStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: Constants.appColorWhite,
                        ),
                        unselectedTextStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: Constants.appColorBrownRed,
                        ),
                        selectedColor: Constants.appColorBrownRed,
                        unselectedColor: Constants.appColorWhite,
                        unselectedBorderColor:
                            Constants.appColorGray.withOpacity(0.5),
                        selectedBorderColor: Colors.transparent,
                        buttonHeight: 34,
                        buttonWidth: 50,
                        borderRadius: BorderRadius.circular(5.0),
                        buttons: groups,
                        onSelected: (i, selected) {
                          selectedBloodGroup = groups[i];
                          print(selectedBloodGroup);
                        },
                        selectedShadow: const <BoxShadow>[
                          BoxShadow(color: Colors.transparent)
                        ],
                        unselectedShadow: const <BoxShadow>[
                          BoxShadow(color: Colors.transparent)
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      AppInputField(
                          formKey: locationKey,
                          controller: locationController,
                          inputType: TextInputType.text,
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: "Location is Required"),
                          ]),
                          hintText: "Enter the Location"),
                      const SizedBox(
                        height: 16,
                      ),
                      AppInputField(
                          formKey: addressKey,
                          controller: addressController,
                          inputType: TextInputType.text,
                          validator: MultiValidator([
                            RequiredValidator(errorText: "Address is Required"),
                          ]),
                          hintText: "Enter the Address"),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        //key: _dateKey,
                        controller: dateController,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            color: Constants.appColorBlack, fontSize: 14),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintStyle: const TextStyle(
                              color: Constants.appColorGray, fontSize: 14),
                          hintText: "Enter the Date",
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: Constants.appColorBrownRed,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: const BorderSide(
                              color: Constants.appColorGray,
                              width: 1.0,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return "* Date is Required";
                          } else
                            return null;
                        },
                        readOnly: true,
                        onTap: () {
                          datePicker(context);
                          print("date picker");
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TimeRange(
                        fromTitle: const Text(
                          'From',
                          style: TextStyle(
                              fontSize: 12, color: Constants.appColorGray),
                        ),
                        toTitle: const Text(
                          'To',
                          style: TextStyle(
                              fontSize: 12, color: Constants.appColorGray),
                        ),
                        titlePadding: 20,
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black87),
                        activeTextStyle: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                        borderColor: Constants.appColorBrownRed,
                        backgroundColor: Colors.transparent,
                        activeBackgroundColor: Constants.appColorBrownRed,
                        firstTime: TimeOfDay(hour: 08, minute: 00),
                        lastTime: TimeOfDay(hour: 18, minute: 00),
                        timeStep: 60,
                        timeBlock: 60,
                        onRangeCompleted: (range) => setState(() => {
                              startTime = range?.start.hour,
                              endTime = range?.end.hour,
                              print(startTime),
                              print(endTime)
                            }),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: 500,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_isValidate()) {
                              FirebaseServices().sendDonationRequest(
                                  bloodGroup: selectedBloodGroup,
                                  location: locationController.text,
                                  address: addressController.text,
                                  startDate: dateController.text,
                                  startTime: startTime!,
                                  endTime: endTime!);
                            }
                          },
                          child: Text("Send"),
                        ),
                      )
                    ],
                  )),
              Expanded(flex: 2, child: Container())
            ],
          ),
        ),
      ),
    );
  }

  void datePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: new DateTime.now(),
      lastDate: new DateTime(selectedDate.year + 1),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        String formattedDate = DateFormat("yyyy-MM-dd").format(picked);
        dateController.text = formattedDate;
        print(selectedDate.year);
      });
    }
  }

  bool _isValidate() {
    if (selectedBloodGroup.isEmpty) {
      CustomDialogBox.buildOkDialog(description: "Please pick a Blood Group");
      return false;
    } else if (!locationKey.currentState!.validate()) {
      return false;
    } else if (!addressKey.currentState!.validate()) {
      return false;
    } else if (dateController.text.isEmpty) {
      CustomDialogBox.buildOkDialog(description: "Please pick the Date");
      return false;
    } else if (startTime == null && endTime == null) {
      CustomDialogBox.buildOkDialog(description: "Please pick the Duration");
      return false;
    } else {
      return true;
    }
  }
}
