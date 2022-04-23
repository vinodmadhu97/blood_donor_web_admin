import 'package:blood_donor_web_admin/constants/constants.dart';
import 'package:blood_donor_web_admin/constants/custom_dialog_box.dart';
import 'package:blood_donor_web_admin/widgets/app_heading.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../services/firebase_services.dart';

class AddPoster extends StatefulWidget {
  AddPoster({
    Key? key,
  }) : super(key: key);

  @override
  State<AddPoster> createState() => _AddPosterState();
}

class _AddPosterState extends State<AddPoster> {
  bool isSelected = false;

  DateTime selectedDate = DateTime.now();
  TextEditingController _dateController = TextEditingController();
  PlatformFile? file;

  @override
  Widget build(BuildContext context) {
    var trueColor = Constants.appColorBrownRedLight.withOpacity(0.9);
    var falseColor = Constants.appColorBrownRedLight.withOpacity(0.5);
    Color bgColor = isSelected ? trueColor : falseColor;

    return Scaffold(
      body: SingleChildScrollView(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const SizedBox(
                height: 10,
              ),
              AppHeading(
                text: "SEND POSTER NOTIFICATION",
                color: Constants.appColorBrownRed,
              ),
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
                              color: Constants.appColorGray.withOpacity(0.5))),
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
                    color: bgColor, borderRadius: BorderRadius.circular(8)),
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
                          style: TextStyle(color: Colors.white, fontSize: 24),
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
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 200,
                    child: TextFormField(
                      //key: _dateKey,
                      controller: _dateController,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          color: Constants.appColorBlack, fontSize: 14),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(
                            color: Constants.appColorGray, fontSize: 14),
                        hintText: "Pick a Expired Date",
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Constants.appColorBrownRed,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
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
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                        onPressed: () async {
                          if (file == null) {
                            CustomDialogBox.buildOkDialog(
                                description: "Please pick a Image");
                          } else if (_dateController.text.isEmpty) {
                            CustomDialogBox.buildOkDialog(
                                description: "Please pick a expire date");
                          } else {
                            Get.back();
                            FirebaseServices()
                                .sendPoster(file!, _dateController.text);
                          }
                        },
                        child: const Text("Send")),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ]),
          ),
        ),
      ),
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
}
