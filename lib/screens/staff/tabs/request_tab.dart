import 'package:blood_donor_web_admin/screens/staff/add_request.dart';
import 'package:blood_donor_web_admin/services/firebase_services.dart';
import 'package:blood_donor_web_admin/widgets/request_card_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/custom_dialog_box.dart';

class RequestTab extends StatefulWidget {
  RequestTab({
    Key? key,
  }) : super(key: key);

  @override
  State<RequestTab> createState() => _RequestTabState();
}

class _RequestTabState extends State<RequestTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () {
                          Get.to(AddRequest());
                        },
                        child: Text("+ Add New")),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                  height: 500,
                  child: StreamBuilder(
                    stream: FirebaseServices().getAllRequests(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text("");
                      } else {
                        return GridView.builder(
                            itemCount: snapshot.data?.docs.length,
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    mainAxisExtent: 200,
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 20),
                            itemBuilder: (ctx, i) {
                              return InkWell(
                                  onTap: () {
                                    CustomDialogBox.buildOkWithCancelDialog(
                                        description: "Do you want to Delete?",
                                        okOnclick: () {
                                          Get.back();
                                          FirebaseServices()
                                              .deleteDonationRequest(
                                                  snapshot.data!.docs[i].id);
                                        });
                                  },
                                  child: RequestCardView(
                                    group: snapshot.data!.docs[i]['bloodGroup'],
                                    location: snapshot.data!.docs[i]
                                        ['location'],
                                    address: snapshot.data!.docs[i]['address'],
                                    date: snapshot.data!.docs[i]['startDate'],
                                    startTime: snapshot
                                        .data!.docs[i]['startTime']
                                        .toString(),
                                    endTime: snapshot.data!.docs[i]['endTime']
                                        .toString(),
                                  ));
                            });
                      }
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
