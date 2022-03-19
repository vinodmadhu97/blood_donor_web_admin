import 'package:blood_donor_web_admin/widgets/proifle_history_data_list.dart';
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
        body: Row(
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
                  return Text("Loading");
                }

                return ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    CircleAvatar(
                      radius: 65.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(65),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: snapshot.data[0]["profileUrl"],
                          placeholder: (context, url) =>
                              new CircularProgressIndicator(),
                          errorWidget: (context, url, error) => ClipRRect(
                            borderRadius: BorderRadius.circular(65),
                            child:
                                Image.asset("assets/images/profile_avatar.jpg"),
                          ),
                        ),
                      ),
                      backgroundColor: Colors.white,
                    ),
                    const SizedBox(height: 24),
                    Column(
                      children: [
                        Text(
                          snapshot.data[0]['fullName'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                        const SizedBox(height: 4),
                        Text(snapshot.data[0]['address']),
                        const SizedBox(height: 4),
                        Text(snapshot.data[0]['nic'])
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              snapshot.data[0]['bloodGroup'],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24),
                            ),
                            SizedBox(height: 2),
                            Text(
                              "Group",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(height: 24, child: VerticalDivider()),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              snapshot.data[0]['numberOfDonation'],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24),
                            ),
                            SizedBox(height: 2),
                            Text(
                              "donations",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ProfileHistoryDataList(
                      snapshot: snapshot.data[1],
                    ),
                    SizedBox(
                      height: 500,
                    ),
                  ],
                );
              }),
        ),
        Expanded(flex: 1, child: Container()),
      ],
    ));
  }
}
