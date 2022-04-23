import 'package:blood_donor_web_admin/constants/constants.dart';
import 'package:blood_donor_web_admin/constants/custom_dialog_box.dart';
import 'package:blood_donor_web_admin/widgets/app_heading.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:time_range/time_range.dart';

import '../../../services/firebase_services.dart';
import '../../widgets/app_input_field.dart';

class AddCampaignPromo extends StatefulWidget {
  AddCampaignPromo({
    Key? key,
  }) : super(key: key);

  @override
  State<AddCampaignPromo> createState() => _AddCampaignPromoState();
}

class _AddCampaignPromoState extends State<AddCampaignPromo> {
  bool isSelected = false;
  String imgUrl = "";
  int? startTime;
  int? endTime;
  DateTime selectedDate = DateTime.now();
  TextEditingController _dateController = TextEditingController();
  PlatformFile? file;

  TextEditingController locationController = TextEditingController();
  GlobalKey<FormState> locationKey = GlobalKey<FormState>();

  TextEditingController addressController = TextEditingController();
  GlobalKey<FormState> addressKey = GlobalKey<FormState>();

  TextEditingController startController = TextEditingController();
  GlobalKey<FormState> startKey = GlobalKey<FormState>();

  TextEditingController endController = TextEditingController();
  GlobalKey<FormState> endKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var trueColor = Constants.appColorBrownRedLight.withOpacity(0.9);
    var falseColor = Constants.appColorBrownRedLight.withOpacity(0.5);
    Color bgColor = isSelected ? trueColor : falseColor;

    return Scaffold(
      body: Column(children: [
        SizedBox(
          height: 30,
        ),
        AppHeading(
          text: "SEND CAMPAIGN NOTIFICATION",
          color: Constants.appColorBrownRed,
        ),
        SizedBox(
          height: 30,
        ),
        Row(
          children: [
            Expanded(flex: 2, child: Container()),
            Expanded(
              flex: 4,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 60),
                  child: Column(children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          child: Container(
                            height: 150,
                            width: 300,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Constants.appColorGray
                                        .withOpacity(0.5))),
                            child: file == null
                                ? Visibility(
                                    visible: !isSelected,
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: const Icon(
                                        Icons.photo,
                                        size: 40,
                                        color: Constants.appColorGray,
                                      ),
                                    ),
                                  )
                                : Image.memory(
                                    file!.bytes!,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 200,
                      width: 400,
                      decoration: BoxDecoration(
                          color: bgColor,
                          borderRadius: BorderRadius.circular(8)),
                      child: Stack(children: [
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.cloud_upload,
                                size: 42,
                                color: Colors.white,
                              ),
                              const Text(
                                "Pick File Here",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 24),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  chooseImage();
                                },
                                child: const Text("Choose Image"),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              const Text(
                                "(only JPG,JPEG,PNG Files)",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ),
                  ]),
                ),
              ),
            ),
            Expanded(
                flex: 4,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
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
                              RequiredValidator(
                                  errorText: "Address is Required"),
                            ]),
                            hintText: "Enter the Address"),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          //key: _dateKey,
                          controller: _dateController,
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              color: Constants.appColorBlack, fontSize: 14),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintStyle: const TextStyle(
                                color: Constants.appColorGray, fontSize: 14),
                            hintText: "Enter a Start Date",
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
                              return "Start Date is Required";
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
                          firstTime: const TimeOfDay(hour: 08, minute: 00),
                          lastTime: const TimeOfDay(hour: 18, minute: 00),
                          timeStep: 60,
                          timeBlock: 60,
                          onRangeCompleted: (range) => setState(() => {
                                startTime = range?.start.hour,
                                endTime = range?.end.hour,
                                print(startTime),
                                print(endTime)
                              }),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          width: 500,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_isValidate()) {
                                Get.back();
                                FirebaseServices().sendCampaignPromotion(
                                    file: file!,
                                    address: addressController.text,
                                    location: locationController.text,
                                    startDate: _dateController.text,
                                    startTime: startTime!,
                                    endTime: endTime!);
                              }
                            },
                            child: Text("Send"),
                          ),
                        )
                      ],
                    ),
                  ),
                )),
            Expanded(flex: 2, child: Container()),
          ],
        ),
      ]),
    );
  }

  void chooseImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png'],
    );

    if (result != null) {
      setState(() {
        file = result.files.first;
      });
    }
  }

  void datePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(selectedDate.year + 1),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        String formattedDate = DateFormat("yyyy-MM-dd").format(picked);
        _dateController.text = formattedDate;
        print(selectedDate.year);
      });
    }
  }

  bool _isValidate() {
    if (file == null) {
      CustomDialogBox.buildOkDialog(description: "Please pick a Image");
      return false;
    } else if (!locationKey.currentState!.validate()) {
      return false;
    } else if (!addressKey.currentState!.validate()) {
      return false;
    } else if (_dateController.text.isEmpty) {
      CustomDialogBox.buildOkDialog(description: "Please pick a Date");
      return false;
    } else if (startTime == null && endTime == null) {
      CustomDialogBox.buildOkDialog(description: "Please pick a Duration");
      return false;
    } else {
      return true;
    }
  }
}
