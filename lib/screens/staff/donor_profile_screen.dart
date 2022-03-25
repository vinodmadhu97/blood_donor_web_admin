import 'package:blood_donor_web_admin/screens/shimmers/table_shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../services/firebase_services.dart';

class DonorProfileScreen extends StatefulWidget {
  final String donorId;

  DonorProfileScreen({required this.donorId});
  @override
  _DonorProfileScreenState createState() => _DonorProfileScreenState();
}

class _DonorProfileScreenState extends State<DonorProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                FutureBuilder(
                    future:
                        FirebaseServices().getDonorDetailsById(widget.donorId),
                    builder: (ctx, AsyncSnapshot snapshot) {
                      if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return TableShimmer();
                      }
                      return Column(
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Constants.appColorBrownRed,
                                  Constants.appColorBrownRedLight
                                ],
                              ),
                            ),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  CircleAvatar(
                                    radius: 65.0,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(65),
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl: snapshot.data["profileUrl"],
                                        placeholder: (context, url) =>
                                            new CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(65),
                                          child: Image.asset(
                                              "assets/images/profile_avatar.jpg"),
                                        ),
                                      ),
                                    ),
                                    backgroundColor: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(snapshot.data['fullName'],
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0,
                                          )),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                        snapshot.data['address'],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                        snapshot.data['phone'],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15.0,
                                        ),
                                      )
                                    ],
                                  )
                                ]),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Card(
                              child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                    child: Column(
                                  children: [
                                    Text(
                                      'Group',
                                      style: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 14.0),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      snapshot.data['bloodGroup'].isNotEmpty
                                          ? snapshot.data['bloodGroup']
                                          : "N/A",
                                      style: TextStyle(
                                        fontSize: 15.0,
                                      ),
                                    )
                                  ],
                                )),
                                Container(
                                  child: Column(children: [
                                    Text(
                                      'Birthday',
                                      style: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 14.0),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      snapshot.data['dob'],
                                      style: TextStyle(
                                        fontSize: 15.0,
                                      ),
                                    )
                                  ]),
                                ),
                                Container(
                                  child: Column(children: [
                                    Text(
                                      'NIC',
                                      style: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 14.0),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      snapshot.data['nic'],
                                      style: TextStyle(
                                        fontSize: 15.0,
                                      ),
                                    )
                                  ]),
                                ),
                                Container(
                                    child: Column(
                                  children: [
                                    Text(
                                      'Number of Donations',
                                      style: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 14.0),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      snapshot.data['numberOfDonation'],
                                      style: TextStyle(
                                        fontSize: 15.0,
                                      ),
                                    )
                                  ],
                                )),
                                Container(
                                    child: Column(
                                  children: [
                                    Text(
                                      'Last Donations Date',
                                      style: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 14.0),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      snapshot.data['nextDonationDate']
                                              .isNotEmpty
                                          ? snapshot.data['nextDonationDate']
                                          : "N/A",
                                      style: TextStyle(
                                        fontSize: 15.0,
                                      ),
                                    )
                                  ],
                                )),
                              ],
                            ),
                          )),
                        ],
                      );
                    }),
              ],
            ),
            FutureBuilder(
                future: FirebaseServices().getDonorHistoryById(widget.donorId),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("");
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
                                  label: Text("Barcode"),
                                ),
                              ],
                              rows: List.generate(
                                snapshot.data!.size,
                                (index) => availableCampaignsDataRow(
                                    snapshot.data!.docs[index], context),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }

  DataRow availableCampaignsDataRow(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot,
      BuildContext context) {
    return DataRow(
      cells: [
        DataCell(Text(snapshot.id)),
        DataCell(Text(snapshot['location'])),
        DataCell(Text(snapshot['date'])),
        DataCell(Text(snapshot['barcode'])),
      ],
    );
  }
}
