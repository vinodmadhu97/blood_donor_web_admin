import 'package:blood_donor_web_admin/screens/shimmers/table_shimmer.dart';
import 'package:blood_donor_web_admin/screens/staff/single_campaign_management_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/constants.dart';
import '../../services/firebase_services.dart';

class AvailableCampaign extends StatefulWidget {
  const AvailableCampaign({Key? key}) : super(key: key);

  @override
  State<AvailableCampaign> createState() => _AvailableCampaignState();
}

class _AvailableCampaignState extends State<AvailableCampaign> {
  Future<QuerySnapshot<Map<String, dynamic>>>? searchedSnapshot;
  String searchedValue = "";
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(children: [
              Expanded(flex: 4, child: Container()),
              Expanded(
                  flex: 1,
                  child: Card(
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: "Search",
                        fillColor: Constants.appColorWhite,
                        filled: true,
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        suffixIcon: Container(
                          padding: const EdgeInsets.all(
                              Constants.defaultPadding * 0.75),
                          margin: const EdgeInsets.symmetric(
                              horizontal: Constants.defaultPadding / 2),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: SvgPicture.asset(
                            "assets/icons/Search.svg",
                            color: Constants.appColorBrownRed,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          searchedValue = value;
                          searchedSnapshot = FirebaseServices()
                              .getSearchedResult(
                                  "campaigns", "location", searchedValue);
                        });
                      },
                    ),
                  )),
            ]),
            searchedValue.isEmpty
                ? StreamBuilder(
                    stream: FirebaseServices().getCampaignCollection(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return TableShimmer();
                      }

                      return Card(
                        elevation: 10,
                        child: Container(
                          padding: EdgeInsets.all(Constants.defaultPadding),
                          decoration: BoxDecoration(
                            color: Constants.appColorWhite,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Campaigns",
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: DataTable2(
                                  columnSpacing: Constants.defaultPadding,
                                  minWidth: 600,
                                  columns: [
                                    DataColumn(
                                      label: Text("Campaign Id"),
                                    ),
                                    DataColumn(
                                      label: Text("Location"),
                                    ),
                                    DataColumn(
                                      label: Text("Date"),
                                    ),
                                    DataColumn(
                                      label: Text("Time"),
                                    ),
                                    DataColumn(
                                      label: Text(""),
                                    ),
                                  ],
                                  rows: List.generate(
                                    snapshot.data!.docs.length,
                                    (index) => availableCampaignsDataRow(
                                        snapshot.data!.docs[index],
                                        context,
                                        index + 1),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    })
                : FutureBuilder(
                    future: searchedSnapshot,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return TableShimmer();
                      }

                      return Card(
                        elevation: 10,
                        child: Container(
                          padding: EdgeInsets.all(Constants.defaultPadding),
                          decoration: BoxDecoration(
                            color: Constants.appColorWhite,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Staff Members",
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: DataTable2(
                                  columnSpacing: Constants.defaultPadding,
                                  minWidth: 600,
                                  columns: [
                                    DataColumn(
                                      label: Text("Campaign Id"),
                                    ),
                                    DataColumn(
                                      label: Text("Location"),
                                    ),
                                    DataColumn(
                                      label: Text("Date"),
                                    ),
                                    DataColumn(
                                      label: Text("Time"),
                                    ),
                                    DataColumn(
                                      label: Text(""),
                                    ),
                                  ],
                                  rows: List.generate(
                                    snapshot.data!.docs.length,
                                    (index) => availableCampaignsDataRow(
                                        snapshot.data!.docs[index],
                                        context,
                                        index + 1),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
          ],
        ),
      ),
    );
  }

  DataRow availableCampaignsDataRow(
      QueryDocumentSnapshot snapshot, BuildContext context, int no) {
    return DataRow(
      cells: [
        DataCell(
          Row(
            children: [
              SvgPicture.asset(
                "assets/icons/campaign-logo.svg",
                height: 30,
                width: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Constants.defaultPadding),
                child: Text(snapshot['campaignId']),
              ),
            ],
          ),
        ),
        DataCell(Text(snapshot['location'])),
        DataCell(Text(snapshot['date'])),
        DataCell(
            Text("${snapshot['startTime']}.00 to ${snapshot['endTime']}.00")),
        DataCell(ElevatedButton(
          child: Text("View"),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => SingleCampaignManagementScreen(
                      campaignId: snapshot['campaignId'],
                      location: snapshot['location'],
                    )));
          },
        )),
      ],
    );
  }
}
