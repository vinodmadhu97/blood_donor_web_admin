import 'package:blood_donor_web_admin/constants/constants.dart';
import 'package:blood_donor_web_admin/widgets/poster_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:intl/intl.dart';

class PosterTab extends StatefulWidget {
  PosterTab({
    Key? key,
  }) : super(key: key);

  @override
  State<PosterTab> createState() => _PosterTabState();
}

class _PosterTabState extends State<PosterTab> {
  late DropzoneViewController controller;
  bool isHighlited = false;
  String imgUrl = "";
  DateTime selectedDate = DateTime.now();
  TextEditingController _dateController = TextEditingController();

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
                        itemCount: 4,
                        itemBuilder: (ctx, index) => Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 10),
                              child: PosterCard(),
                            )),
                  )),
              Expanded(
                flex: 8,
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
                              style: TextStyle(
                                  color: Constants.appColorBlack, fontSize: 14),
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                    color: Constants.appColorGray,
                                    fontSize: 14),
                                hintText: "Pick a Expired Date",
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
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          ElevatedButton(
                              onPressed: () {}, child: const Text("Send"))
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
}
