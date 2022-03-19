import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

import '../constants/constants.dart';
import '../screens/admin/admin_dashboard_screen.dart';
import '../screens/staff/staff_dashboard_screen.dart';
import 'http_services.dart';

class FirebaseServices {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final Stream<QuerySnapshot> staffStream =
      FirebaseFirestore.instance.collection('staff').snapshots();

  final Stream<QuerySnapshot> campaignsStream =
      FirebaseFirestore.instance.collection('campaigns').snapshots();

  final Stream<QuerySnapshot> assessmentStream =
      FirebaseFirestore.instance.collection('assessments').snapshots();

  Future adminLogin(String email, String password, BuildContext context) async {
    try {
      await auth
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((auth) {
        auth.user?.getIdTokenResult().then((idTokenResult) {
          print(idTokenResult.claims?['admin']);
          if (idTokenResult.claims?['admin']) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => AdminDashboardScreen()),
            );
          }
        });
      }).catchError((error) {
        Constants.showAlertDialog(context, "Alert", "$error");
        //todo show error
      });
    } catch (error) {
      Constants.showAlertDialog(context, "Alert", "$error");
    }
  }

  Future registerNewStaff(BuildContext context, String email, String password,
      String name, String phone) async {
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        HttpsCallable callable = FirebaseFunctions.instance.httpsCallable(
            "addStaffRole",
            options: HttpsCallableOptions(timeout: const Duration(seconds: 5)));
        var result = await callable({"email": value.user?.email});
        print("------------>staff claim ${result.data.toString()}");
        Response response = await HttpServices().sendWelcomeMailToStaff(
            "Blood Transfusion Service", name, email, password, email);
        print("----------->email send${response.statusCode}");

        firestore.collection("staff").doc(auth.currentUser!.uid).set({
          "staffId": auth.currentUser!.uid,
          "staffName": name,
          "staffEmail": email,
          "staffPhone": phone,
          "enabled": true
        }).then((value) => print("Data stored in firestore"));
      });

      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (ctx) => AdminDashboardScreen()));
        Constants.showAlertDialog(
            context, "Alert", "New Staff Member is Created");
      }
    } catch (error) {
      Constants.showAlertDialog(context, "Alert", error.toString());
    }
  }

  Stream<QuerySnapshot> getStaffCollection() {
    return staffStream;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getSearchedResult(
      String collection, String searchBy, String searchKey) {
    final Future<QuerySnapshot<Map<String, dynamic>>> searchedStream =
        FirebaseFirestore.instance
            .collection(collection)
            .where(searchBy, isEqualTo: searchKey)
            .get();

    return searchedStream;
  }

  Future changeAvailabilityOfStaff(
      String docId, String email, BuildContext context, bool toEnable) async {
    if (toEnable) {
      HttpsCallable callable = FirebaseFunctions.instance.httpsCallable(
          "enableStaffRole",
          options: HttpsCallableOptions(timeout: const Duration(seconds: 5)));
      await callable({"email": email}).then((value) {
        print("------claim enabled ${value.data}");
        firestore
            .collection("staff")
            .doc(docId)
            .set({"enabled": false}, SetOptions(merge: true))
            .then((value) => print('updated enable staff claim in firestore'))
            .catchError((error) =>
                Constants.showAlertDialog(context, "Alert", "$error"));
      });
    } else {
      HttpsCallable callable = FirebaseFunctions.instance.httpsCallable(
          "disableStaffRole",
          options: HttpsCallableOptions(timeout: const Duration(seconds: 5)));
      await callable({"email": email}).then((value) {
        print("------claim disabled $value");
        firestore
            .collection("staff")
            .doc(docId)
            .set({"enabled": true}, SetOptions(merge: true))
            .then((value) => print('updated enable staff claim in firestore'))
            .catchError((error) =>
                Constants.showAlertDialog(context, "Alert", "$error"));
      });
    }
  }

  Future changeAdminPassword(String password, BuildContext context) async {
    print(password);
    try {
      await auth.currentUser?.updatePassword(password).then((value) {
        Constants.showAlertDialog(
            context, "Alert", "Password has been changed");
      }).catchError((error) {
        Constants.showAlertDialog(context, "Alert", "$error");
      });
    } catch (error) {
      Constants.showAlertDialog(context, "Alert", "$error");
    }
  }

  bool adminLogout(BuildContext context) {
    try {
      auth.signOut();
      return true;
    } catch (e) {
      Constants.showAlertDialog(context, "Error", "$e");
      return false;
    }
  }

  //<---------------------------------STAFF API CALLS-------------------------------------------->

  Future staffLogin(String email, String password, BuildContext context) async {
    try {
      await auth
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((auth) {
        auth.user?.getIdTokenResult().then((idTokenResult) {
          print(idTokenResult.claims?['staff']);
          if (idTokenResult.claims?['staff']) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => StaffDashboardScreen()),
            );
          }
        });
      }).catchError((error) {
        Constants.showAlertDialog(context, "Alert", "$error");
        //todo show error
      });
    } catch (error) {
      Constants.showAlertDialog(context, "Alert", "$error");
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getLoggedStaffDetails(
      String? staffId) {
    final Future<DocumentSnapshot<Map<String, dynamic>>> loggedUserSnapShot =
        FirebaseFirestore.instance.collection("staff").doc(staffId).get();

    return loggedUserSnapShot;
  }

  Future createNewCampaign(
      BuildContext context,
      String campaignId,
      String location,
      String date,
      String startTime,
      String endTime,
      String createdBy) async {
    try {
      firestore.collection("campaigns").doc(campaignId).set({
        "campaignId": campaignId,
        "location": location,
        "date": date,
        "startTime": startTime,
        "endTime": endTime,
        "createdBy": auth.currentUser!.uid
      }).then((value) => Constants.showAlertDialog(
          context, "Alert", "New campaign has been created"));
    } catch (error) {
      Constants.showAlertDialog(context, "Alert", error.toString());
    }
  }

  Stream<QuerySnapshot> getCampaignCollection() {
    return campaignsStream;
  }

  Stream<QuerySnapshot> getAssesments() {
    return assessmentStream;
  }

  Stream<QuerySnapshot> getCampaignDetailsById(String campaignId) {
    final Stream<QuerySnapshot> campaignDetailsStream = FirebaseFirestore
        .instance
        .collection('campaigns')
        .doc(campaignId)
        .collection("donorRequests")
        .snapshots();
    return campaignDetailsStream;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getSearchedDonorInCampaign(
      String collection,
      String docId,
      String subCollection,
      String searchBy,
      String searchKey) {
    final Future<QuerySnapshot<Map<String, dynamic>>> searchedStream =
        FirebaseFirestore.instance
            .collection(collection)
            .doc(docId)
            .collection(subCollection)
            .where(searchBy, isEqualTo: searchKey)
            .get();

    return searchedStream;
  }

  Future<void> addOrEditAssessments(
      {required BuildContext context,
      String? assesId,
      required String assesInEn,
      required String assesInSi,
      required String assesInTa,
      required String assesAns,
      required bool isEdited}) async {
    try {
      if (!isEdited) {
        firestore.collection("assessments").doc().set({
          "answer": assesAns,
          "assessment": {
            "as_en": assesInEn,
            "as_si": assesInSi,
            "as_ta": assesInTa
          },
        }).then((value) {
          Navigator.of(context).pop();
          Constants.showAlertDialog(
              context, "Alert", "Assessment has been added");
        });
      } else {
        firestore.collection("assessments").doc(assesId).set({
          "answer": assesAns,
          "assessment": {
            "as_en": assesInEn,
            "as_si": assesInSi,
            "as_ta": assesInTa
          },
        }, SetOptions(merge: true)).then((value) {
          Navigator.of(context).pop();
          Constants.showAlertDialog(
              context, "Alert", "Assessment has been added");
        });
      }
    } catch (error) {
      Navigator.of(context).pop();
      Constants.showAlertDialog(context, "Alert", error.toString());
    }
  }

  Future<void> deleteAssessment(BuildContext context, String assesId) async {
    try {
      firestore.collection("assessments").doc(assesId).delete().then((value) {
        Constants.showAlertDialog(
            context, "Alert", "Assessment has been Deleted");
      });
    } catch (e) {
      Constants.showAlertDialog(context, "Alert", e.toString());
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getDonorDetailsById(
      String donorId) {
    final Future<DocumentSnapshot<Map<String, dynamic>>> donorSnapshot =
        FirebaseFirestore.instance.collection("donors").doc(donorId).get();

    return donorSnapshot;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getDonorAssessmentData(
      String donorId, String campaignId) {
    final Future<DocumentSnapshot<Map<String, dynamic>>> donorSnapshot =
        FirebaseFirestore.instance
            .collection("campaigns")
            .doc(campaignId)
            .collection("donorRequests")
            .doc(donorId)
            .collection("answers")
            .doc("result")
            .get();

    return donorSnapshot;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAssessmentData() {
    final Future<QuerySnapshot<Map<String, dynamic>>> donorSnapshot =
        FirebaseFirestore.instance.collection("assessments").get();

    return donorSnapshot;
  }

  Future<void> setMedicalReport(BuildContext context, String campaignId,
      String donorId, Map<String, dynamic> data) async {
    try {
      firestore
          .collection("campaigns")
          .doc(campaignId)
          .collection("donorRequests")
          .doc(donorId)
          .collection("answers")
          .doc("reportData")
          .set(data)
          .then((value) async {
        var donor = await firestore.collection("donors").doc(donorId).get();
        String donationCount = donor.data()!['numberOfDonation'];
        int updatedCount = int.parse(donationCount);
        updatedCount++;

        var date = DateTime.parse(data['date']);
        var newDate = DateTime(date.year, date.month + 4, date.day);
        DateFormat formatter = DateFormat('yyyy-MM-dd');
        String formattedDate = formatter.format(newDate);

        Map<String, dynamic> donorData = {
          "numberOfDonation": updatedCount.toString(),
          "bloodGroup": data["bloodGroup"],
          "nextDonationDate": formattedDate,
        };

        var campaign =
            await firestore.collection("campaigns").doc(campaignId).get();
        var location = campaign.data()!["location"];

        Map<String, dynamic> donorHistory = {
          "location": location,
          "barcode": data["barcode"],
          "date": data["date"]
        };

        firestore
            .collection("donors")
            .doc(donorId)
            .set(donorData, SetOptions(merge: true))
            .then((value) {
          firestore
              .collection("donors")
              .doc(donorId)
              .collection("history")
              .doc(campaignId)
              .set(donorHistory)
              .then((value) async {
            await firestore
                .collection("campaigns")
                .doc(campaignId)
                .collection("donorRequests")
                .doc(donorId)
                .set({"request": "no"}, SetOptions(merge: true));
            Navigator.of(context).pop();
            Constants.showAlertDialog(context, "Alert", "Assessment Completed");
          });
        });
      });
    } catch (e) {
      Constants.showAlertDialog(context, "Alert", e.toString());
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getMedicalData(
      String campaignId, String donorId) {
    final Future<DocumentSnapshot<Map<String, dynamic>>> donorSnapshot =
        FirebaseFirestore.instance
            .collection("campaigns")
            .doc(campaignId)
            .collection("donorRequests")
            .doc(donorId)
            .collection("answers")
            .doc("reportData")
            .get();

    return donorSnapshot;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getSummery() {
    final Future<QuerySnapshot<Map<String, dynamic>>> donorSnapshot =
        FirebaseFirestore.instance.collection("summery").get();

    return donorSnapshot;
  }
}
