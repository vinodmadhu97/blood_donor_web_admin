import 'package:blood_donor_web_admin/constants/constants.dart';
import 'package:blood_donor_web_admin/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final String? staffId;
  const ProfileCard({
    required this.staffId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: Constants.defaultPadding),
      child: Card(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: Constants.defaultPadding,
            vertical: Constants.defaultPadding / 2,
          ),
          decoration: BoxDecoration(
            color: Constants.appColorWhite,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: Colors.white10),
          ),
          child: Row(
            children: [
              Image.asset(
                "assets/images/profile_pic.png",
                height: 38,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Constants.defaultPadding / 2),
                  child: FutureBuilder<DocumentSnapshot>(
                    future: FirebaseServices().getLoggedStaffDetails(staffId),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text("error");
                      }

                      if (snapshot.connectionState == ConnectionState.done) {
                        Map<String, dynamic>? data =
                            snapshot.data?.data() as Map<String, dynamic>?;
                        return data != null
                            ? Text("Welcome! ${data['staffName']}")
                            : Text("Welcome! Admin");
                      }

                      return Text("loading");
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
