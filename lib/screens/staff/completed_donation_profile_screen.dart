import 'package:blood_donor_web_admin/constants/widget_size.dart';
import 'package:blood_donor_web_admin/screens/shimmers/table_shimmer.dart';
import 'package:blood_donor_web_admin/widgets/app_heading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../services/firebase_services.dart';

class CompletedDonorProfilePage extends StatefulWidget {
  final String campaignId;
  final String donorId;

  CompletedDonorProfilePage({required this.campaignId, required this.donorId});

  @override
  _CompletedDonorProfilePageState createState() =>
      _CompletedDonorProfilePageState();
}

class _CompletedDonorProfilePageState extends State<CompletedDonorProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("DONATION STATUS"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Row(
            children: [
              Expanded(flex: 1, child: Container()),
              Expanded(
                flex: 3,
                child: FutureBuilder(
                    future: Future.wait([
                      FirebaseServices().getDonorDetailsById(widget.donorId),
                      FirebaseServices()
                          .getMedicalData(widget.campaignId, widget.donorId)
                    ]),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return TableShimmer();
                      }

                      return Column(
                        children: [
                          Card(
                            elevation: 0,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 20),
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 100,
                                    width: 100,
                                    child: ClipOval(
                                      child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl: snapshot.data[0]
                                              ["profileUrl"],
                                          placeholder: (context, url) =>
                                              CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              Image.asset(
                                                  "assets/images/profile_avatar.jpg")),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Column(
                                    children: [
                                      AppHeading(
                                        text: snapshot.data[0]['fullName'],
                                        widgetSize: WidgetSize.medium,
                                      ),
                                      AppHeading(
                                        text: snapshot.data[0]['address'],
                                        widgetSize: WidgetSize.small,
                                      ),
                                      AppHeading(
                                        text: snapshot.data[0]['nic'],
                                        widgetSize: WidgetSize.small,
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Column(
                                    children: [
                                      AppHeading(
                                          text: snapshot.data[0]['bloodGroup'],
                                          widgetSize: WidgetSize.large),
                                      AppHeading(
                                          text: "Group",
                                          widgetSize: WidgetSize.small),
                                    ],
                                  ),
                                  Spacer(),
                                  Column(
                                    children: [
                                      AppHeading(
                                          text: snapshot.data[0]
                                              ['numberOfDonation'],
                                          widgetSize: WidgetSize.large),
                                      AppHeading(
                                          text: "Donations",
                                          widgetSize: WidgetSize.small),
                                    ],
                                  ),
                                  Spacer(),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            elevation: 0,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 60.0, vertical: 40),
                              child: Column(
                                children: [
                                  Card(
                                    elevation: 0,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20.0, horizontal: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Donor name and Id Is verified"),
                                          Text(snapshot.data[1]['accept']),
                                        ],
                                      ),
                                    ),
                                    color: Colors.grey.withOpacity(0.1),
                                  ),
                                  Card(
                                    elevation: 0,
                                    color: Colors.grey.withOpacity(0.1),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20.0, horizontal: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Barcode"),
                                          Text(snapshot.data[1]['barcode']),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Card(
                                    elevation: 0,
                                    color: Colors.grey.withOpacity(0.1),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20.0, horizontal: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Weight"),
                                          Text(
                                              "${snapshot.data[1]['weight']} Kg"),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Card(
                                    elevation: 0,
                                    color: Colors.grey.withOpacity(0.1),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20.0, horizontal: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Feeling well?"),
                                          Text(snapshot.data[1]['feelingWell']),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Card(
                                    elevation: 0,
                                    color: Colors.grey.withOpacity(0.1),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20.0, horizontal: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Last Meal(<4 hrs)?"),
                                          Text(snapshot.data[1]['lastMeal']),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Card(
                                    elevation: 0,
                                    color: Colors.grey.withOpacity(0.1),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20.0, horizontal: 20),
                                      child: Row(
                                        children: [
                                          Text("Any Allergies or Medications?"),
                                          Text(snapshot.data[1]['allergies']),
                                        ],
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                      ),
                                    ),
                                  ),
                                  Card(
                                    elevation: 0,
                                    color: Colors.grey.withOpacity(0.1),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20.0, horizontal: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              "Adequate overnight sleep? (>6hrs)?"),
                                          Text(snapshot.data[1]['isSlept']),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Card(
                                    elevation: 0,
                                    color: Colors.grey.withOpacity(0.1),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20.0, horizontal: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Ever Hospitalized?"),
                                          Text(
                                              snapshot.data[1]['hospitalized']),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Card(
                                    elevation: 0,
                                    color: Colors.grey.withOpacity(0.1),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20.0, horizontal: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("High risk Behaviors?"),
                                          Text(snapshot.data[1]['isRisk']),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Card(
                                    elevation: 0,
                                    color: Colors.grey.withOpacity(0.1),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20.0, horizontal: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("CVS status pulse"),
                                          Text(snapshot.data[1]['cvs']),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Card(
                                    elevation: 0,
                                    color: Colors.grey.withOpacity(0.1),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20.0, horizontal: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("BP"),
                                          Text(
                                              "${snapshot.data[1]['bp']} mmHg"),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Card(
                                    elevation: 0,
                                    color: Colors.grey.withOpacity(0.1),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20.0, horizontal: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Remark"),
                                          Text(snapshot.data[1]['remark']),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
              ),
              Expanded(flex: 1, child: Container()),
            ],
          ),
        ));
  }
}
