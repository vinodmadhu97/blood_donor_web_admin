import 'package:blood_donor_web_admin/constants/widget_size.dart';
import 'package:blood_donor_web_admin/widgets/app_heading.dart';
import 'package:blood_donor_web_admin/widgets/app_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../constants/constants.dart';
import '../../../services/firebase_services.dart';
import '../../../widgets/chart.dart';
import '../../../widgets/progress_line.dart';

class CampaignSummaryTab extends StatelessWidget {
  final String campaignId;
  CampaignSummaryTab({Key? key, required this.campaignId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: FutureBuilder(
        future: Future.wait([
          FirebaseServices().getTotalRequests(campaignId),
          FirebaseServices().getCompletedRequests(campaignId),
          FirebaseServices().getRejectedRequests(campaignId),
          //second
          FirebaseServices().getCompletedRequests(campaignId),
          FirebaseServices().getGroupA(campaignId),
          FirebaseServices().getGroupB(campaignId),
          FirebaseServices().getGroupAB(campaignId),
          FirebaseServices().getGroupO(campaignId),
          FirebaseServices().getTotalRequests(campaignId),
        ]),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SpinKitCircle(
                color: Constants.appColorBrownRed,
              ),
            );
          }
          var aPersentage = 0;
          var bPersentage = 0;
          var abPersentage = 0;
          var oPersentage = 0;
          var totalCompletedCount = snapshot.data![3]['count'];
          var totalCount = snapshot.data![8]['count'];

          var aPosCount = snapshot.data![4]['a+'];
          var aNegCount = snapshot.data![4]['a-'];
          var aTotACount = aPosCount + aNegCount;
          if (aTotACount != 0 && totalCompletedCount != 0) {
            aPersentage = ((aTotACount / totalCompletedCount) * 100).toInt();
          }

          var bPosCount = snapshot.data![5]['b+'];
          var bNegCount = snapshot.data![5]['b-'];
          var bTotACount = bPosCount + bNegCount;

          if (bTotACount != 0 && totalCompletedCount != 0) {
            bPersentage = ((bTotACount / totalCompletedCount) * 100).toInt();
          }

          var abPosCount = snapshot.data![6]['ab+'];
          var abNegCount = snapshot.data![6]['ab-'];
          var abTotACount = abPosCount + abNegCount;

          if (abTotACount != 0 && totalCompletedCount != 0) {
            abPersentage = ((abTotACount / totalCompletedCount) * 100).toInt();
          }

          var oPosCount = snapshot.data![7]['o+'];
          var oNegCount = snapshot.data![7]['o-'];
          var oTotACount = oPosCount + oNegCount;
          if (oTotACount != 0 && totalCompletedCount != 0) {
            oPersentage = ((oTotACount / totalCompletedCount) * 100).toInt();
          }
          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Card(
                        color: Constants.appColorGray.withOpacity(0.5),
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppHeading(
                                text: "Total Participation",
                                widgetSize: WidgetSize.small,
                                color: Constants.appColorWhite,
                              ),
                              AppHeading(
                                text: snapshot.data![0]['count'].toString(),
                                color: Constants.appColorWhite,
                              )
                            ],
                          ),
                        ),
                      )),
                  Expanded(
                      flex: 1,
                      child: Card(
                        color: Constants.appColorGray.withOpacity(0.5),
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppHeading(
                                  text: "Completed Donations",
                                  color: Constants.appColorWhite,
                                  widgetSize: WidgetSize.small),
                              AppHeading(
                                text: snapshot.data![1]['count'].toString(),
                                color: Constants.appColorWhite,
                              )
                            ],
                          ),
                        ),
                      )),
                  Expanded(
                      flex: 1,
                      child: Card(
                        color: Constants.appColorGray.withOpacity(0.5),
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppHeading(
                                  text: "Rejected Donations",
                                  color: Constants.appColorWhite,
                                  widgetSize: WidgetSize.small),
                              AppHeading(
                                text: snapshot.data![2]['count'].toString(),
                                color: Constants.appColorWhite,
                              )
                            ],
                          ),
                        ),
                      )),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: Card(
                    color: Color(0xFF007ee5).withOpacity(0.5),
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppHeading(
                                    text: "$aTotACount",
                                    widgetSize: WidgetSize.medium,
                                    color: Constants.appColorWhite,
                                  ),
                                  AppLabel(
                                    text: "Donations",
                                    widgetSize: WidgetSize.medium,
                                    textColor: Constants.appColorWhite,
                                  )
                                ],
                              ),
                              Spacer(),
                              Column(
                                children: [
                                  AppHeading(
                                    text: "A",
                                    widgetSize: WidgetSize.large,
                                    color: Constants.appColorWhite,
                                  ),
                                ],
                              ),
                              Spacer()
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "$aPersentage%",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Constants.appColorWhite,
                                    fontSize: 14),
                              ),
                              ProgressLine(
                                color: Colors.red,
                                percentage: aPersentage,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )),
                  Expanded(
                      child: Card(
                    color: Color(0xFF007ee5).withOpacity(0.5),
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppHeading(
                                    text: "$bTotACount",
                                    widgetSize: WidgetSize.medium,
                                    color: Constants.appColorWhite,
                                  ),
                                  AppLabel(
                                    text: "Donations",
                                    widgetSize: WidgetSize.medium,
                                    textColor: Constants.appColorWhite,
                                  )
                                ],
                              ),
                              Spacer(),
                              Column(
                                children: [
                                  AppHeading(
                                    text: "B",
                                    widgetSize: WidgetSize.large,
                                    color: Constants.appColorWhite,
                                  ),
                                ],
                              ),
                              Spacer()
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "$bPersentage%",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Constants.appColorWhite,
                                    fontSize: 14),
                              ),
                              ProgressLine(
                                color: Colors.red,
                                percentage: bPersentage,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )),
                  Expanded(
                      child: Card(
                    color: Color(0xFF007ee5).withOpacity(0.5),
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppHeading(
                                    text: "$abTotACount",
                                    widgetSize: WidgetSize.medium,
                                    color: Constants.appColorWhite,
                                  ),
                                  AppLabel(
                                    text: "Donations",
                                    widgetSize: WidgetSize.medium,
                                    textColor: Constants.appColorWhite,
                                  )
                                ],
                              ),
                              Spacer(),
                              Column(
                                children: [
                                  AppHeading(
                                    text: "AB",
                                    widgetSize: WidgetSize.large,
                                    color: Constants.appColorWhite,
                                  ),
                                ],
                              ),
                              Spacer()
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "$abPersentage%",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Constants.appColorWhite,
                                    fontSize: 14),
                              ),
                              ProgressLine(
                                color: Colors.red,
                                percentage: abPersentage,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )),
                  Expanded(
                      child: Card(
                    color: Color(0xFF007ee5).withOpacity(0.5),
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppHeading(
                                    text: "$oTotACount",
                                    widgetSize: WidgetSize.medium,
                                    color: Constants.appColorWhite,
                                  ),
                                  AppLabel(
                                    text: "Donations",
                                    widgetSize: WidgetSize.medium,
                                    textColor: Constants.appColorWhite,
                                  )
                                ],
                              ),
                              Spacer(),
                              Column(
                                children: [
                                  AppHeading(
                                    text: "O",
                                    widgetSize: WidgetSize.large,
                                    color: Constants.appColorWhite,
                                  ),
                                ],
                              ),
                              Spacer()
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "$oPersentage%",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Constants.appColorWhite,
                                    fontSize: 14),
                              ),
                              ProgressLine(
                                color: Colors.red,
                                percentage: oPersentage,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Spacer(),
                            Expanded(
                              flex: 3,
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppHeading(
                                        text: "A+",
                                        widgetSize: WidgetSize.medium,
                                        color: Constants.appColorGray,
                                      ),
                                      Container(
                                        height: 50,
                                        width: 50,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: Constants.appColorBrownRed,
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        child: AppHeading(
                                          text: "$aPosCount",
                                          widgetSize: WidgetSize.medium,
                                          color: Constants.appColorWhite,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppHeading(
                                        text: "A-",
                                        widgetSize: WidgetSize.medium,
                                        color: Constants.appColorGray,
                                      ),
                                      Container(
                                        height: 50,
                                        width: 50,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: Constants.appColorBrownRed,
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        child: AppHeading(
                                          text: "$aNegCount",
                                          widgetSize: WidgetSize.medium,
                                          color: Constants.appColorWhite,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                        Row(
                          children: [
                            Spacer(),
                            Expanded(
                              flex: 3,
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppHeading(
                                        text: "B+",
                                        widgetSize: WidgetSize.medium,
                                        color: Constants.appColorGray,
                                      ),
                                      Container(
                                        height: 50,
                                        width: 50,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: Constants.appColorBrownRed,
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        child: AppHeading(
                                          text: "$bPosCount",
                                          widgetSize: WidgetSize.medium,
                                          color: Constants.appColorWhite,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppHeading(
                                        text: "B-",
                                        widgetSize: WidgetSize.medium,
                                        color: Constants.appColorGray,
                                      ),
                                      Container(
                                        height: 50,
                                        width: 50,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: Constants.appColorBrownRed,
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        child: AppHeading(
                                          text: "$bNegCount",
                                          widgetSize: WidgetSize.medium,
                                          color: Constants.appColorWhite,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                        Row(
                          children: [
                            Spacer(),
                            Expanded(
                              flex: 3,
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppHeading(
                                        text: "AB+",
                                        widgetSize: WidgetSize.medium,
                                        color: Constants.appColorGray,
                                      ),
                                      Container(
                                        height: 50,
                                        width: 50,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: Constants.appColorBrownRed,
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        child: AppHeading(
                                          text: "$abPosCount",
                                          widgetSize: WidgetSize.medium,
                                          color: Constants.appColorWhite,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppHeading(
                                        text: "AB-",
                                        widgetSize: WidgetSize.medium,
                                        color: Constants.appColorGray,
                                      ),
                                      Container(
                                        height: 50,
                                        width: 50,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: Constants.appColorBrownRed,
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        child: AppHeading(
                                          text: "$abNegCount",
                                          widgetSize: WidgetSize.medium,
                                          color: Constants.appColorWhite,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                        Row(
                          children: [
                            Spacer(),
                            Expanded(
                              flex: 3,
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppHeading(
                                        text: "O+",
                                        widgetSize: WidgetSize.medium,
                                        color: Constants.appColorGray,
                                      ),
                                      Container(
                                        height: 50,
                                        width: 50,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: Constants.appColorBrownRed,
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        child: AppHeading(
                                          text: "$oPosCount",
                                          widgetSize: WidgetSize.medium,
                                          color: Constants.appColorWhite,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppHeading(
                                        text: "O-",
                                        widgetSize: WidgetSize.medium,
                                        color: Constants.appColorGray,
                                      ),
                                      Container(
                                        height: 50,
                                        width: 50,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: Constants.appColorBrownRed,
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        child: AppHeading(
                                          text: "$oNegCount",
                                          widgetSize: WidgetSize.medium,
                                          color: Constants.appColorWhite,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      child: Card(
                        child: Chart(
                          bCount: bTotACount,
                          aCount: abTotACount,
                          abCount: abTotACount,
                          oCount: oTotACount,
                          completedRequest: totalCompletedCount,
                          totalRequest: totalCount,
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          );
        },
      )),
    );
  }
}

/*
import 'package:blood_donor_web_admin/screens/shimmers/table_shimmer.dart';
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
                    return Text("");
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
                    return TableShimmer();
                  }

                  var aPersentage = 0;
                  var bPersentage = 0;
                  var abPersentage = 0;
                  var oPersentage = 0;
                  var totalCompletedCount = snapshot.data![0]['count'];
                  var totalCount = snapshot.data![5]['count'];

                  var aPosCount = snapshot.data![1]['a+'];
                  var aNegCount = snapshot.data![1]['a-'];
                  var aTotACount = aPosCount + aNegCount;
                  if (aTotACount != 0 && totalCompletedCount != 0) {
                    aPersentage =
                        ((aTotACount / totalCompletedCount) * 100).toInt();
                  }

                  var bPosCount = snapshot.data![2]['b+'];
                  var bNegCount = snapshot.data![2]['b-'];
                  var bTotACount = bPosCount + bNegCount;

                  if (bTotACount != 0 && totalCompletedCount != 0) {
                    bPersentage =
                        ((bTotACount / totalCompletedCount) * 100).toInt();
                  }

                  var abPosCount = snapshot.data![3]['ab+'];
                  var abNegCount = snapshot.data![3]['ab-'];
                  var abTotACount = abPosCount + abNegCount;

                  if (abTotACount != 0 && totalCompletedCount != 0) {
                    abPersentage =
                        ((abTotACount / totalCompletedCount) * 100).toInt();
                  }

                  var oPosCount = snapshot.data![4]['o+'];
                  var oNegCount = snapshot.data![4]['o-'];
                  var oTotACount = oPosCount + oNegCount;
                  if (oTotACount != 0 && totalCompletedCount != 0) {
                    oPersentage =
                        ((oTotACount / totalCompletedCount) * 100).toInt();
                  }

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
*/
