import 'package:blood_donor_web_admin/constants/custom_dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';
import 'package:time_range/time_range.dart';

import '../../../constants/constants.dart';
import '../../../widgets/app_input_field.dart';
import '../../../widgets/poster_card.dart';

class CampaignTab extends StatefulWidget {
  CampaignTab({
    Key? key,
  }) : super(key: key);

  @override
  State<CampaignTab> createState() => _CampaignTabState();
}

class _CampaignTabState extends State<CampaignTab> {
  late DropzoneViewController controller;
  bool isHighlited = false;
  String imgUrl = "";
  int? startTime;
  int? endTime;
  DateTime selectedDate = DateTime.now();
  TextEditingController _dateController = TextEditingController();

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
    Color bgColor = isHighlited ? trueColor : falseColor;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: SizedBox(
                    height: 500,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 20,
                        itemBuilder: (ctx, index) => Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 10),
                              child: PosterCard(),
                            )),
                  )),
              Expanded(
                flex: 4,
                child: Column(children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        child: Container(
                          height: 100,
                          width: 150,
                          child: imgUrl.isEmpty
                              ? Visibility(
                                  visible: isHighlited,
                                  child: Container(
                                    alignment: Alignment.center,
                                    color: Constants.appColorGray,
                                    child: Icon(
                                      Icons.photo,
                                      size: 40,
                                      color: Constants.appColorWhite,
                                    ),
                                  ),
                                )
                              : Image.network(
                                  imgUrl,
                                  fit: BoxFit.cover,
                                ),
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 200,
                    width: 300,
                    decoration: BoxDecoration(
                        color: bgColor, borderRadius: BorderRadius.circular(8)),
                    child: Stack(children: [
                      DropzoneView(
                        onCreated: (controller) => this.controller = controller,
                        onDrop: acceptFile,
                        onHover: () => setState(() {
                          isHighlited = true;
                        }),
                        onLeave: () => setState(() {
                          isHighlited = false;
                        }),
                        mime: ['image/jpeg', 'image/png'],
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.cloud_upload,
                              size: 42,
                              color: Colors.white,
                            ),
                            Text(
                              "Drop File Here",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 24),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                final event = await controller.pickFiles(
                                    mime: ['image/jpeg', 'image/png']);
                                if (event.isEmpty) return;
                                acceptFile(event[0]);
                              },
                              child: Text("Choose Image"),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const Text(
                              "(only JPG,JPEG,PNG Files)",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ),
                ]),
              ),
              Expanded(
                  flex: 4,
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
                      SizedBox(
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
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        //key: _dateKey,
                        controller: _dateController,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Constants.appColorBlack, fontSize: 14),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                              color: Constants.appColorGray, fontSize: 14),
                          hintText: "Enter the Date",
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Constants.appColorBrownRed,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: BorderSide(
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
                      SizedBox(
                        height: 16,
                      ),
                      TimeRange(
                        fromTitle: Text(
                          'From',
                          style: TextStyle(
                              fontSize: 12, color: Constants.appColorGray),
                        ),
                        toTitle: Text(
                          'To',
                          style: TextStyle(
                              fontSize: 12, color: Constants.appColorGray),
                        ),
                        titlePadding: 20,
                        textStyle: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black87),
                        activeTextStyle: TextStyle(
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
                              print("OK");
                            }
                          },
                          child: Text("Send"),
                        ),
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Future acceptFile(dynamic event) async {
    final mime = await controller.getFileMIME(event);
    final byte = await controller.getFileSize(event);
    final url = await controller.createFileUrl(event);
    print("Name : $mime");
    print("Name : $byte");
    print("Name : $url");
    setState(() {
      imgUrl = url;
    });
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
        _dateController.text = formattedDate;
        print(selectedDate.year);
      });
    }
  }

  bool _isValidate() {
    if (!locationKey.currentState!.validate()) {
      return false;
    } else if (!addressKey.currentState!.validate()) {
      return false;
    } else if (_dateController.text.isEmpty) {
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
