import 'package:blood_donor_web_admin/widgets/blood_count_info_card.dart';
import 'package:blood_donor_web_admin/widgets/chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../services/firebase_services.dart';
import '../../../widgets/blood_group_info_card.dart';

class CampaignSummaryTab extends StatelessWidget {
  final String campaignId;

  CampaignSummaryTab({Key? key, required this.campaignId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            FutureBuilder(
                future: Future.wait([
                  FirebaseServices().getTotalRequests(campaignId),
                  FirebaseServices().getCompletedRequests(campaignId),
                  FirebaseServices().getRejectedRequests(campaignId),
                ]),
                builder: (BuildContext context,
                    AsyncSnapshot<List<DocumentSnapshot<Map<String, dynamic>>>>
                        snapshot) {
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  }

                  return Row(
                    children: [
                      BloodCountInfoCard(
                        title: "Total Requests",
                        svgSrc: "assets/icons/campaign-logo.svg",
                        amountOfFiles: snapshot.data![0]['count'].toString(),
                        numOfFiles: 220,
                        color: Constants.appColorBrownRed,
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      BloodCountInfoCard(
                        title: "Completed Donations",
                        svgSrc: "assets/icons/campaign-logo.svg",
                        amountOfFiles: snapshot.data![1]['count'].toString(),
                        numOfFiles: 220,
                        color: Constants.appColorBrownRed,
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      BloodCountInfoCard(
                        title: "Rejected Donations",
                        svgSrc: "assets/icons/campaign-logo.svg",
                        amountOfFiles: snapshot.data![2]['count'].toString(),
                        numOfFiles: 220,
                        color: Constants.appColorBrownRed,
                      )
                    ],
                  );
                }),
            SizedBox(
              height: 30,
            ),
            FutureBuilder(
                future: Future.wait([
                  FirebaseServices().getCompletedRequests(campaignId),
                  FirebaseServices().getGroupA(campaignId),
                  FirebaseServices().getGroupB(campaignId),
                  FirebaseServices().getGroupAB(campaignId),
                  FirebaseServices().getGroupO(campaignId),
                  FirebaseServices().getTotalRequests(campaignId),
                ]),
                builder: (BuildContext context,
                    AsyncSnapshot<List<DocumentSnapshot<Map<String, dynamic>>>>
                        snapshot) {
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  }
                  var totalCompletedCount = snapshot.data![0]['count'];
                  var totalCount = snapshot.data![5]['count'];

                  var aPosCount = snapshot.data![1]['a+'];
                  var aNegCount = snapshot.data![1]['a-'];
                  var aTotACount = aPosCount + aNegCount;
                  var aPersentage =
                      ((aTotACount / totalCompletedCount) * 100).toInt();

                  var bPosCount = snapshot.data![2]['b+'];
                  var bNegCount = snapshot.data![2]['b-'];
                  var bTotACount = bPosCount + bNegCount;
                  var bPersentage =
                      ((bTotACount / totalCompletedCount) * 100).toInt();

                  var abPosCount = snapshot.data![3]['ab+'];
                  var abNegCount = snapshot.data![3]['ab-'];
                  var abTotACount = abPosCount + abNegCount;
                  var abPersentage =
                      ((abTotACount / totalCompletedCount) * 100).toInt();

                  var oPosCount = snapshot.data![4]['o+'];
                  var oNegCount = snapshot.data![4]['o-'];
                  var oTotACount = oPosCount + oNegCount;
                  var oPersentage =
                      ((oTotACount / totalCompletedCount) * 100).toInt();

                  return Column(
                    children: [
                      GridView(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: Constants.defaultPadding,
                          mainAxisSpacing: Constants.defaultPadding,
                          childAspectRatio: 2,
                        ),
                        children: [
                          BloodGroupInfoCard(
                            color: Color(0xffff2400),
                            count: "$aTotACount",
                            group: "A",
                            percentage: aPersentage,
                            svgUrl: "assets/icons/campaign-logo.svg",
                          ),
                          BloodGroupInfoCard(
                            color: Color(0xFFFFA113),
                            count: "$bTotACount",
                            group: "B",
                            percentage: bPersentage,
                            svgUrl: "assets/icons/campaign-logo.svg",
                          ),
                          BloodGroupInfoCard(
                            color: Color(0xFF800000),
                            count: "$abTotACount",
                            group: "AB",
                            percentage: abPersentage,
                            svgUrl: "assets/icons/campaign-logo.svg",
                          ),
                          BloodGroupInfoCard(
                            color: Color(0xFF007EE5),
                            count: "$oTotACount",
                            group: "O",
                            percentage: oPersentage,
                            svgUrl: "assets/icons/campaign-logo.svg",
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: Chart(
                                bCount: bTotACount,
                                aCount: aTotACount,
                                abCount: abTotACount,
                                oCount: oTotACount,
                                completedRequest: totalCompletedCount,
                                totalRequest: totalCount,
                              )),
                          Expanded(
                              flex: 3,
                              child: Column(
                                children: [
                                  SizedBox(
                                    child: BloodCountInfoCard(
                                      title: "A (Rh positive)",
                                      svgSrc: "assets/icons/campaign-logo.svg",
                                      amountOfFiles: "$aPosCount",
                                      numOfFiles: 220,
                                      color: Color(0xffff2400),
                                    ),
                                    width: 300,
                                  ),
                                  SizedBox(
                                    child: BloodCountInfoCard(
                                      title: "A (Rh negative)",
                                      svgSrc: "assets/icons/campaign-logo.svg",
                                      amountOfFiles: "$aNegCount",
                                      numOfFiles: 220,
                                      color: Color(0xffff2400),
                                    ),
                                    width: 300,
                                  ),
                                  SizedBox(
                                    child: BloodCountInfoCard(
                                      title: "B (Rh positive)",
                                      svgSrc: "assets/icons/campaign-logo.svg",
                                      amountOfFiles: "$bPosCount",
                                      numOfFiles: 220,
                                      color: Color(0xFFFFA113),
                                    ),
                                    width: 300,
                                  ),
                                  SizedBox(
                                    child: BloodCountInfoCard(
                                      title: "B (Rh negative)",
                                      svgSrc: "assets/icons/campaign-logo.svg",
                                      amountOfFiles: "$bNegCount",
                                      numOfFiles: 220,
                                      color: Color(0xFFFFA113),
                                    ),
                                    width: 300,
                                  ),
                                  SizedBox(
                                    child: BloodCountInfoCard(
                                        title: "AB (Rh positive)",
                                        svgSrc:
                                            "assets/icons/campaign-logo.svg",
                                        amountOfFiles: "$abPosCount",
                                        numOfFiles: 220,
                                        color: Color(0xFF800000)),
                                    width: 300,
                                  ),
                                  SizedBox(
                                    child: BloodCountInfoCard(
                                      title: "AB (Rh negative)",
                                      svgSrc: "assets/icons/campaign-logo.svg",
                                      amountOfFiles: "$abNegCount",
                                      numOfFiles: 220,
                                      color: Color(0xFF800000),
                                    ),
                                    width: 300,
                                  ),
                                  SizedBox(
                                    child: BloodCountInfoCard(
                                      title: "O (Rh positive)",
                                      svgSrc: "assets/icons/campaign-logo.svg",
                                      amountOfFiles: "$oPosCount",
                                      numOfFiles: 220,
                                      color: Color(0xFF007EE5),
                                    ),
                                    width: 300,
                                  ),
                                  SizedBox(
                                    child: BloodCountInfoCard(
                                      title: "O (Rh negative)",
                                      svgSrc: "assets/icons/campaign-logo.svg",
                                      amountOfFiles: "$oNegCount",
                                      numOfFiles: 220,
                                      color: Color(0xFF007EE5),
                                    ),
                                    width: 300,
                                  ),
                                ],
                              ))
                        ],
                      )
                    ],
                  );
                }),
          ],
        ),
      ),
    );
  }
}
