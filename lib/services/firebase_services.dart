import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../constants/constants.dart';
import '../screens/admin/admin_dashboard_screen.dart';
import 'http_services.dart';

class FirebaseServices {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final Stream<QuerySnapshot> staffStream =
      FirebaseFirestore.instance.collection('staff').snapshots();

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
}
