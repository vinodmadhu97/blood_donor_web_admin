import 'package:blood_donor_web_admin/screens/staff/staff_dashboard_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'constants/constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Constants.appColorbrownRedSwatch,
          primaryColor: Constants.appColorBrownRed),
      home: FutureBuilder(
        future: _firebaseInitialize,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
              child: CircularProgressIndicator(),
              width: 60,
              height: 60,
            );
          } else {
            return StaffDashboardScreen();
          }
        },
      ),
    );
  }
}
