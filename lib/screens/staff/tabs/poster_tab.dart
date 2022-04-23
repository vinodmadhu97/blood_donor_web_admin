import 'package:blood_donor_web_admin/constants/custom_dialog_box.dart';
import 'package:blood_donor_web_admin/screens/staff/add_poster.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  /*bool isSelected = false;

  DateTime selectedDate = DateTime.now();
  TextEditingController _dateController = TextEditingController();
  PlatformFile? file;
*/
  @override
  Widget build(BuildContext context) {
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
                            return const Text("");
                          } else {
                            return Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      child: ElevatedButton(
                                          onPressed: () {
                                            Get.to(AddPoster());
                                          },
                                          child: Text("+ Add New")),
                                      height: 50,
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                GridView.builder(
                                    itemCount: snapshot.data?.docs.length,
                                    shrinkWrap: true,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 4,
                                            mainAxisExtent: 200,
                                            crossAxisSpacing: 20,
                                            mainAxisSpacing: 20),
                                    itemBuilder: (ctx, i) {
                                      return InkWell(
                                        onTap: () {
                                          CustomDialogBox
                                              .buildOkWithCancelDialog(
                                                  description:
                                                      "Do you want to Delete?",
                                                  okOnclick: () {
                                                    Get.back();
                                                    FirebaseServices()
                                                        .deletePoster(
                                                            snapshot.data!
                                                                .docs[i].id,
                                                            snapshot.data!
                                                                    .docs[i]
                                                                ['url']);
                                                  });
                                        },
                                        child: PosterCard(
                                          docId: snapshot.data!.docs[i].id,
                                          url: snapshot.data!.docs[i]['url'],
                                          expDate: snapshot.data!.docs[i]
                                              ['expireDate'],
                                        ),
                                      );
                                    })
                              ],
                            );
                          }
                        },
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}
