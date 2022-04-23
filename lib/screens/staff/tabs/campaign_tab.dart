import 'package:blood_donor_web_admin/constants/custom_dialog_box.dart';
import 'package:blood_donor_web_admin/screens/staff/add_campaign_promo.dart';
import 'package:blood_donor_web_admin/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/campaign_card.dart';

class CampaignTab extends StatefulWidget {
  CampaignTab({
    Key? key,
  }) : super(key: key);

  @override
  State<CampaignTab> createState() => _CampaignTabState();
}

class _CampaignTabState extends State<CampaignTab> {
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
                        stream: FirebaseServices().getAllCampaignPromo(),
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
                                            Get.to(AddCampaignPromo());
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
                                                        .deleteCampaignPromo(
                                                            snapshot.data!
                                                                .docs[i].id,
                                                            snapshot.data!
                                                                    .docs[i]
                                                                ['url']);
                                                  });
                                        },
                                        child: CampaignCard(
                                          docId: snapshot.data!.docs[i].id,
                                          url: snapshot.data!.docs[i]['url'],
                                          location: snapshot.data!.docs[i]
                                              ['location'],
                                          expDate: snapshot.data!.docs[i]
                                              ['startDate'],
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
