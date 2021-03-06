import 'package:blood_donor_web_admin/constants/custom_dialog_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as fbs;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
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

  final Stream<QuerySnapshot> allDonorsStream =
      FirebaseFirestore.instance.collection('donors').snapshots();

  Future adminLogin(String email, String password, BuildContext context) async {
    try {
      CustomDialogBox.buildDialogBox();
      await auth
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((auth) {
        Get.back();
        auth.user?.getIdTokenResult().then((idTokenResult) async {
          print(idTokenResult.claims?['admin']);
          if (idTokenResult.claims?['admin']) {
            var loggedUser = GetStorage('loggedUser');
            await loggedUser.write("token", auth.user!.uid);
            await loggedUser.write("userType", "admin");
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => AdminDashboardScreen()),
            );
          }
        });
      }).catchError((error) {
        Get.back();
        CustomDialogBox.buildOkDialog(
          description: "$error",
        );
        //Constants.showAlertDialog(context, "Alert", "$error");
        //todo show error
      });
    } catch (error) {
      Get.back();
      //Constants.showAlertDialog(context, "Alert", "$error");
      CustomDialogBox.buildOkDialog(
        description: "$error",
      );
    }
  }

  Future registerNewStaff(BuildContext context, String email, String password,
      String name, String phone) async {
    try {
      CustomDialogBox.buildDialogBox();
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        HttpsCallable callable = FirebaseFunctions.instance.httpsCallable(
            "addStaffRole",
            options: HttpsCallableOptions(timeout: const Duration(seconds: 5)));
        var result = await callable({"email": value.user?.email});
        print("------------>staff claim ${result.data.toString()}");
        http.Response response = await HttpServices().sendWelcomeMailToStaff(
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
      Get.back();
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (ctx) => AdminDashboardScreen()));

        CustomDialogBox.buildOkDialog(
            description: "New Staff Member is Created");
      }
    } catch (error) {
      Get.back();
      CustomDialogBox.buildOkDialog(description: error.toString());
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
    CustomDialogBox.buildDialogBox();
    if (toEnable) {
      HttpsCallable callable = FirebaseFunctions.instance.httpsCallable(
          "enableStaffRole",
          options: HttpsCallableOptions(timeout: const Duration(seconds: 5)));
      await callable({"email": email}).then((value) {
        print("------claim enabled ${value.data}");
        firestore
            .collection("staff")
            .doc(docId)
            .set({"enabled": false}, SetOptions(merge: true)).then((value) {
          Get.back();
          CustomDialogBox.buildOkDialog(
              description: "Staff Member has Disabled");
        }).catchError((error) {
          Get.back();
          CustomDialogBox.buildOkDialog(description: "$error");
        });
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
            .set({"enabled": true}, SetOptions(merge: true)).then((value) {
          Get.back();
          CustomDialogBox.buildOkDialog(
              description: "Staff Member has Enabled");
        }).catchError((error) {
          Get.back();
          CustomDialogBox.buildOkDialog(description: "$error");
        });
      });
    }
  }

  Future changeAdminPassword(String password, BuildContext context) async {
    print(password);
    try {
      CustomDialogBox.buildDialogBox();
      await auth.currentUser?.updatePassword(password).then((value) {
        Get.back();
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => AdminDashboardScreen()));
        CustomDialogBox.buildOkDialog(description: "Password has been changed");
      }).catchError((error) {
        Get.back();
        CustomDialogBox.buildOkDialog(description: "$error");
      });
    } catch (error) {
      Get.back();
      CustomDialogBox.buildOkDialog(description: "$error");
    }
  }

  Future changeStaffPassword(String password, BuildContext context) async {
    try {
      CustomDialogBox.buildDialogBox();
      await auth.currentUser?.updatePassword(password).then((value) {
        Get.back();
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => AdminDashboardScreen()));
        CustomDialogBox.buildOkDialog(description: "Password has been changed");
      }).catchError((error) {
        Get.back();
        CustomDialogBox.buildOkDialog(description: error.toString());
      });
    } catch (error) {
      Get.back();
      CustomDialogBox.buildOkDialog(description: error.toString());
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
    CustomDialogBox.buildDialogBox();
    try {
      await auth
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((auth) {
        auth.user?.getIdTokenResult().then((idTokenResult) async {
          Get.back();
          print(idTokenResult.claims?['staff']);
          if (idTokenResult.claims?['staff']) {
            var loggedUser = GetStorage('loggedUser');
            await loggedUser.write("token", auth.user!.uid);
            await loggedUser.write("userType", "staff");
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => StaffDashboardScreen()),
            );
          }
        });
      }).catchError((error) {
        Get.back();
        CustomDialogBox.buildOkDialog(description: "$error");
        //todo show error
      });
    } catch (error) {
      Get.back();
      CustomDialogBox.buildOkDialog(description: "$error");
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
      CustomDialogBox.buildDialogBox();
      firestore.collection("campaigns").doc(campaignId).set({
        "campaignId": campaignId,
        "location": location,
        "date": date,
        "startTime": startTime,
        "endTime": endTime,
        "createdBy": auth.currentUser!.uid
      }).then((value) async {
        await firestore
            .collection("campaigns")
            .doc(campaignId)
            .collection("summery")
            .doc("completedRequest")
            .set({
          "count": 0,
        });
        await firestore
            .collection("campaigns")
            .doc(campaignId)
            .collection("summery")
            .doc("rejectedRequest")
            .set({
          "count": 0,
        });
        await firestore
            .collection("campaigns")
            .doc(campaignId)
            .collection("summery")
            .doc("totalRequest")
            .set({
          "count": 0,
        });
        await firestore
            .collection("campaigns")
            .doc(campaignId)
            .collection("summery")
            .doc("completedRequest")
            .collection("group")
            .doc("a")
            .set({"a+": 0, "a-": 0});
        await firestore
            .collection("campaigns")
            .doc(campaignId)
            .collection("summery")
            .doc("completedRequest")
            .collection("group")
            .doc("ab")
            .set({"ab+": 0, "ab-": 0});
        await firestore
            .collection("campaigns")
            .doc(campaignId)
            .collection("summery")
            .doc("completedRequest")
            .collection("group")
            .doc("b")
            .set({"b+": 0, "b-": 0});
        await firestore
            .collection("campaigns")
            .doc(campaignId)
            .collection("summery")
            .doc("completedRequest")
            .collection("group")
            .doc("o")
            .set({"o+": 0, "o-": 0});
        Get.back();
        CustomDialogBox.buildOkDialog(
            description: "New campaign has been created");
      });
    } catch (error) {
      Get.back();
      CustomDialogBox.buildOkDialog(description: error.toString());
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
      CustomDialogBox.buildDialogBox();
      if (!isEdited) {
        firestore.collection("assessments").doc().set({
          "answer": assesAns,
          "assessment": {
            "as_en": assesInEn,
            "as_si": assesInSi,
            "as_ta": assesInTa
          },
        }).then((value) {
          Get.back();
          Get.back();
          CustomDialogBox.buildOkDialog(
              description: "Assessment has been added");
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
          Get.back();
          Get.back();
          CustomDialogBox.buildOkDialog(
              description: "Assessment has been added");
        });
      }
    } catch (error) {
      Get.back();
      CustomDialogBox.buildOkDialog(description: error.toString());
    }
  }

  Future<void> deleteAssessment(BuildContext context, String assesId) async {
    try {
      CustomDialogBox.buildDialogBox();
      firestore.collection("assessments").doc(assesId).delete().then((value) {
        Get.back();
        CustomDialogBox.buildOkDialog(
            description: "Assessment has been Deleted");
      });
    } catch (e) {
      Get.back();
      CustomDialogBox.buildOkDialog(description: e.toString());
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
    CustomDialogBox.buildDialogBox();
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
            Get.back();
            Get.back();
            CustomDialogBox.buildOkDialog(description: "Assessment Completed");
          });
        });
      });
    } catch (e) {
      Get.back();
      CustomDialogBox.buildOkDialog(description: "$e");
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

  Future<DocumentSnapshot<Map<String, dynamic>>> getTotalRequests(
      String campaignId) {
    final Future<DocumentSnapshot<Map<String, dynamic>>> donorSnapshot =
        FirebaseFirestore.instance
            .collection("campaigns")
            .doc(campaignId)
            .collection("summery")
            .doc('totalRequest')
            .get();

    return donorSnapshot;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getCompletedRequests(
      String campaignId) {
    final Future<DocumentSnapshot<Map<String, dynamic>>> donorSnapshot =
        FirebaseFirestore.instance
            .collection("campaigns")
            .doc(campaignId)
            .collection("summery")
            .doc('completedRequest')
            .get();

    return donorSnapshot;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getRejectedRequests(
      String campaignId) {
    final Future<DocumentSnapshot<Map<String, dynamic>>> donorSnapshot =
        FirebaseFirestore.instance
            .collection("campaigns")
            .doc(campaignId)
            .collection("summery")
            .doc('rejectedRequest')
            .get();

    return donorSnapshot;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getGroupA(String campaignId) {
    final Future<DocumentSnapshot<Map<String, dynamic>>> donorSnapshot =
        FirebaseFirestore.instance
            .collection("campaigns")
            .doc(campaignId)
            .collection("summery")
            .doc('completedRequest')
            .collection("group")
            .doc("a")
            .get();

    return donorSnapshot;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getGroupB(String campaignId) {
    final Future<DocumentSnapshot<Map<String, dynamic>>> donorSnapshot =
        FirebaseFirestore.instance
            .collection("campaigns")
            .doc(campaignId)
            .collection("summery")
            .doc('completedRequest')
            .collection("group")
            .doc("b")
            .get();

    return donorSnapshot;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getGroupAB(String campaignId) {
    final Future<DocumentSnapshot<Map<String, dynamic>>> donorSnapshot =
        FirebaseFirestore.instance
            .collection("campaigns")
            .doc(campaignId)
            .collection("summery")
            .doc('completedRequest')
            .collection("group")
            .doc("ab")
            .get();

    return donorSnapshot;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getGroupO(String campaignId) {
    final Future<DocumentSnapshot<Map<String, dynamic>>> donorSnapshot =
        FirebaseFirestore.instance
            .collection("campaigns")
            .doc(campaignId)
            .collection("summery")
            .doc('completedRequest')
            .collection("group")
            .doc("o")
            .get();

    return donorSnapshot;
  }

  Stream<QuerySnapshot> getAllDonorsCollection() {
    return allDonorsStream;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getDonorHistoryById(
      String donorId) {
    final Future<QuerySnapshot<Map<String, dynamic>>> donorSnapshot =
        FirebaseFirestore.instance
            .collection("donors")
            .doc(donorId)
            .collection("history")
            .get();

    return donorSnapshot;
  }

  Future<void> sendPoster(PlatformFile file, String expDate) async {
    String filename = DateTime.now().microsecondsSinceEpoch.toString();

    try {
      CustomDialogBox.buildDialogBox();

      fbs.TaskSnapshot upload = await fbs.FirebaseStorage.instance
          .ref("posters")
          .child("$filename.${file.extension}")
          .putData(file.bytes!,
              fbs.SettableMetadata(contentType: 'image/${file.extension}'));

      String url = await upload.ref.getDownloadURL();
      int publishedAt = DateTime.now().millisecondsSinceEpoch;

      await firestore.collection("posters").doc().set({
        "url": url,
        "fileName": "$filename.${file.extension}",
        "expireDate": expDate,
        "publishedAt": publishedAt
      }).then((value) {
        Get.back();
        CustomDialogBox.buildOkDialog(description: "Poster has been Sent");
      });
    } catch (e) {
      Get.back();
      CustomDialogBox.buildOkDialog(description: "$e");
    }
  }

  Future<void> sendCampaignPromotion(
      {required PlatformFile file,
      required String location,
      required String address,
      required String startDate,
      required int startTime,
      required int endTime}) async {
    String filename = DateTime.now().microsecondsSinceEpoch.toString();

    try {
      CustomDialogBox.buildDialogBox();

      fbs.TaskSnapshot upload = await fbs.FirebaseStorage.instance
          .ref("campaigns")
          .child("$filename.${file.extension}")
          .putData(file.bytes!,
              fbs.SettableMetadata(contentType: 'image/${file.extension}'));

      String url = await upload.ref.getDownloadURL();
      int publishedAt = DateTime.now().millisecondsSinceEpoch;

      await firestore.collection("campaignPromo").doc().set({
        "url": url,
        "location": location,
        "startDate": startDate,
        "startTime": startTime,
        "endTime": endTime,
        "address": address,
        "publishedAt": publishedAt
      }).then((value) {
        Get.back();
        CustomDialogBox.buildOkDialog(description: "Poster has been Sent");
      });
    } catch (e) {
      Get.back();
      CustomDialogBox.buildOkDialog(description: "$e");
    }
  }

  Stream<QuerySnapshot> getAllPosters() {
    final Stream<QuerySnapshot> posterStream = FirebaseFirestore.instance
        .collection('posters')
        .orderBy('publishedAt', descending: true)
        .snapshots();
    return posterStream;
  }

  Stream<QuerySnapshot> getAllCampaignPromo() {
    final Stream<QuerySnapshot> posterStream = FirebaseFirestore.instance
        .collection('campaignPromo')
        .orderBy('publishedAt', descending: true)
        .snapshots();
    return posterStream;
  }

  Future<void> sendDonationRequest(
      {required String bloodGroup,
      required String location,
      required String address,
      required String startDate,
      required int startTime,
      required int endTime}) async {
    try {
      CustomDialogBox.buildDialogBox();

      int publishedAt = DateTime.now().millisecondsSinceEpoch;

      await firestore.collection("donationRequests").doc().set({
        "bloodGroup": bloodGroup,
        "location": location,
        "startDate": startDate,
        "startTime": startTime,
        "endTime": endTime,
        "address": address,
        "publishedAt": publishedAt
      }).then((value) {
        Get.back();
        CustomDialogBox.buildOkDialog(description: "Request has been Sent");
      });
    } catch (e) {
      Get.back();
      CustomDialogBox.buildOkDialog(description: "$e");
    }
  }

  Stream<QuerySnapshot> getAllRequests() {
    final Stream<QuerySnapshot> requestStream = FirebaseFirestore.instance
        .collection('donationRequests')
        .orderBy('publishedAt', descending: true)
        .snapshots();
    return requestStream;
  }

  void deletePoster(String id, String url) {
    CustomDialogBox.buildDialogBox();
    firestore.collection("posters").doc(id).delete().then((value) {
      Get.back();
    });
  }

  void deleteCampaignPromo(String id, String url) {
    CustomDialogBox.buildDialogBox();
    firestore.collection("campaignPromo").doc(id).delete().then((value) {
      Get.back();
    });
  }

  void deleteDonationRequest(String id) {
    CustomDialogBox.buildDialogBox();
    firestore.collection("donationRequests").doc(id).delete().then((value) {
      Get.back();
    });
  }
}
