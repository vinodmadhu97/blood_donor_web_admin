import 'package:blood_donor_web_admin/screens/admin/admin_dashboard_screen.dart';
import 'package:blood_donor_web_admin/screens/staff/staff_dashboard_screen.dart';
import 'package:blood_donor_web_admin/screens/staff/staff_login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'constants/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GetStorage loggedUser = GetStorage('loggedUser');
  await GetStorage.init('loggedUser');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final Future<FirebaseApp> _firebaseInitialize = Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyDwqEY2gSo1HRopn2XQJ6Oad05PZnupUIM",
        appId: "1:683663062206:web:862613e1a22ebf26699aef",
        messagingSenderId: "683663062206",
        projectId: "donor-app-83ae2",
        authDomain: "donor-app-83ae2.firebaseapp.com",
        storageBucket: "donor-app-83ae2.appspot.com",
        measurementId: "G-BRP4V2Q4QF"),
  );
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Constants.appColorbrownRedSwatch,
          primaryColor: Constants.appColorBrownRed),
      home: FutureBuilder(
        future: _firebaseInitialize,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox(
              child: SpinKitCircle(
                color: Constants.appColorBrownRed,
              ),
              width: 60,
              height: 60,
            );
          } else {
            var loggedUser = GetStorage('loggedUser');
            print("------------------>${loggedUser.read("token")}");
            print("------------------>${loggedUser.read("userType")}");
            if (loggedUser.read("token") == null) {
              return StaffLoginScreen();
            } else {
              if (loggedUser.read("userType") == "staff") {
                return StaffDashboardScreen();
              } else if (loggedUser.read("userType") == "admin") {
                return AdminDashboardScreen();
              } else {
                return StaffLoginScreen();
              }
            }
          }
        },
      ),
    );
  }

  Future<IdTokenResult?> checkUser() async {
    if (FirebaseAuth.instance.currentUser == null) {
      return null;
    }
    return FirebaseAuth.instance.currentUser!.getIdTokenResult();
  }
}
