import 'dart:html' as html;
import 'dart:typed_data';
import 'dart:ui';

import 'package:blood_donor_web_admin/constants/constants.dart';
import 'package:blood_donor_web_admin/constants/widget_size.dart';
import 'package:blood_donor_web_admin/services/firebase_services.dart';
import 'package:blood_donor_web_admin/widgets/app_input_field.dart';
import 'package:blood_donor_web_admin/widgets/filled_rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';
import 'package:nanoid/async.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:time_range/time_range.dart';

class CreateNewCampaign extends StatefulWidget {
  CreateNewCampaign({Key? key}) : super(key: key);

  @override
  State<CreateNewCampaign> createState() => _CreateNewCampaignState();
}

class _CreateNewCampaignState extends State<CreateNewCampaign> {
  GlobalKey<FormState> _donationKey = GlobalKey<FormState>();

  TextEditingController _donationController = TextEditingController();

  GlobalKey<FormState> _locationKey = GlobalKey<FormState>();

  TextEditingController _locationController = TextEditingController();

  TextEditingController _dateController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  String campaignId = "";
  DateTime selectedDate = DateTime.now();
  int? startTime;
  int? endTime;
  String QRdata = "";
  bool qrVisibility = false;
  int size = 5;
  GlobalKey globalKey = new GlobalKey();
  QrPainter? _painter;

  void getCampaignId() async {
    //var uuid = const Uuid();
    var id = await nanoid(8);

    //campaignId = uuid.v1();
    _donationController.text = id;
    campaignId = id;
  }

  bool _isValidate() {
    if (!_donationKey.currentState!.validate()) {
      return false;
    } else if (!_locationKey.currentState!.validate()) {
      return false;
    } else if (_dateController.text == null) {
      Constants.showAlertDialog(context, "Alert", "Please pick the Date");
      return false;
    } else if (startTime == null && endTime == null) {
      Constants.showAlertDialog(context, "Alert", "Please pick the Duration");
      return false;
    } else {
      return true;
    }
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCampaignId();
  }

  @override
  Widget build(BuildContext context) {
    _painter = QrPainter(
      errorCorrectionLevel: QrErrorCorrectLevel.H,
      eyeStyle: const QrEyeStyle(
        eyeShape: QrEyeShape.square,
        color: Constants.appColorBrownRed,
      ),
      data: QRdata,
      version: QrVersions.auto,
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            "CREATE CAMPAIGN",
            style: TextStyle(fontSize: 30, color: Constants.appColorBrownRed),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Campaign ID",
                          style: TextStyle(
                              color: Constants.appColorBrownRed, fontSize: 20),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        AppInputField(
                            formKey: _donationKey,
                            controller: _donationController,
                            inputType: TextInputType.text,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: "Location Id is Required"),
                            ]),
                            enabled: false,
                            hintText: "campaign Key"),
                        SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Location",
                          style: TextStyle(
                              color: Constants.appColorBrownRed, fontSize: 20),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        AppInputField(
                            formKey: _locationKey,
                            controller: _locationController,
                            inputType: TextInputType.text,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: "Location is Required"),
                            ]),
                            hintText: "Location"),
                        SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Date",
                          style: TextStyle(
                              color: Constants.appColorBrownRed, fontSize: 20),
                        ),
                        SizedBox(
                          height: 10,
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
                            hintText: "Date",
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
                          height: 20,
                        ),
                        const Text(
                          "Duration",
                          style: TextStyle(
                              color: Constants.appColorBrownRed, fontSize: 20),
                        ),
                        TimeRange(
                          fromTitle: Text(
                            'From',
                            style: TextStyle(
                                fontSize: 18, color: Constants.appColorGray),
                          ),
                          toTitle: Text(
                            'To',
                            style: TextStyle(
                                fontSize: 18, color: Constants.appColorGray),
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
                          height: 20,
                        ),
                        FilledRoundedButton(
                            text: "Create",
                            widgetSize: WidgetSize.large,
                            clickEvent: () {
                              var result = _isValidate();

                              if (result) {
                                setState(() {
                                  qrVisibility = true;

                                  QRdata =
                                      "$campaignId,${_dateController.text.toString()},$startTime,${endTime}";
                                });
                              }
                            })
                      ],
                    ),
                  )),
              Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Container(
                        child: Visibility(
                          visible: qrVisibility,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: double.infinity,
                                child: Center(
                                  child: RepaintBoundary(
                                    child: CustomPaint(
                                        size: Size.square(
                                            (size * 100).toDouble()),
                                        key: globalKey,
                                        painter: _painter),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              _buildButton()
                            ],
                          ),
                        ),
                        width: 600,
                        height: 600,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Constants.appColorBrownRed, width: 3),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ],
                  ))
            ],
          ),
        ]),
      ),
    );
  }

  Widget _buildButton() {
    return ElevatedButton(
        onPressed: () async {
          await _capturePng();
          FirebaseServices().createNewCampaign(
              context,
              campaignId,
              _locationController.text,
              _dateController.text,
              startTime.toString(),
              endTime.toString(),
              auth.currentUser!.uid);
        },
        style: ElevatedButton.styleFrom(
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
          ),
        ),
        child: Text('Download'));
  }

  Future<void> _capturePng() async {
    final picData = await _painter?.toImageData((size * 100).toDouble(),
        format: ImageByteFormat.png);
    await writeToFile(picData!);
  }

  Future<void> writeToFile(ByteData data) async {
    final bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = 'qr_code.png';
    html.document.body?.children.add(anchor);

    anchor.click();

    html.document.body?.children.remove(anchor);
    html.Url.revokeObjectUrl(url);
  }
}
