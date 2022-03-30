import 'package:blood_donor_web_admin/constants/constants.dart';
import 'package:blood_donor_web_admin/constants/custom_dialog_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../services/firebase_services.dart';
import '../../../widgets/poster_card.dart';

class PosterTab extends StatefulWidget {
  PosterTab({
    Key? key,
  }) : super(key: key);

  @override
  State<PosterTab> createState() => _PosterTabState();
}

class _PosterTabState extends State<PosterTab> {
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: SizedBox(
                      height: 500,
                      child: StreamBuilder(
                        stream: FirebaseServices().getAllPosters(),
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
                                shrinkWrap: true,
                                itemCount: snapshot.data?.docs.length,
                                itemBuilder: (ctx, index) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 10),
                                      child: PosterCard(
                                        docId: snapshot.data!.docs[index].id,
                                        url: snapshot.data!.docs[index]['url'],
                                      ),
                                    ));
                          }
                        },
                      ))),
              Expanded(
                flex: 8,
                child: Column(children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        child: Container(
                          height: 100,
                          width: 150,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color:
                                      Constants.appColorGray.withOpacity(0.5))),
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
                    width: 300,
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 24),
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
                                    color: Constants.appColorGray,
                                    fontSize: 14),
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
                            width: 20,
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                if (file == null) {
                                  CustomDialogBox.buildOkDialog(
                                      description: "Please pick a Image");
                                } else if (_dateController.text.isEmpty) {
                                  CustomDialogBox.buildOkDialog(
                                      description: "Please pick a expire date");
                                } else {
                                  FirebaseServices()
                                      .sendPoster(file!, _dateController.text);
                                }
                              },
                              child: const Text("Send"))
                        ],
                      ),
                    ],
                  ),
                ]),
              )
            ],
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
