import 'package:blood_donor_web_admin/constants/constants.dart';
import 'package:blood_donor_web_admin/constants/custom_dialog_box.dart';
import 'package:blood_donor_web_admin/screens/admin/tabs/about_admin_tab.dart';
import 'package:blood_donor_web_admin/screens/admin/tabs/create_staff_tab.dart';
import 'package:blood_donor_web_admin/screens/admin/tabs/current_staff_tab.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../../services/firebase_services.dart';
import '../staff/staff_login_screen.dart';

class AdminDashboardScreen extends StatefulWidget {
  @override
  AdminDashboardScreenState createState() => AdminDashboardScreenState();
}

class AdminDashboardScreenState extends State<AdminDashboardScreen> {
  void logOut() {
    print("logout");
    var result = FirebaseServices().adminLogout(context);
    var loggedUser = GetStorage('loggedUser');
    loggedUser.remove("token");
    loggedUser.remove("userType");
    if (result) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx) => StaffLoginScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Text("Admin",
                        style: TextStyle(
                            color: Constants.appColorWhite, fontSize: 30))),
                Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          child: IconButton(
                              padding: EdgeInsets.all(0),
                              icon: Icon(Icons.exit_to_app),
                              onPressed: () {
                                CustomDialogBox.buildOkWithCancelDialog(
                                  description: "Do you want to Log out?",
                                  okOnclick: logOut,
                                );
                              }),
                        )
                      ],
                    )),
              ],
            ),
          ),
          centerTitle: true,
          bottom: const TabBar(
            labelColor: Constants.appColorWhite,
            //indicatorColor: Constants.appColorGray,
            tabs: [
              Tab(
                text: "Registered Staff",
                icon: Icon(Icons.call_received),
              ),
              Tab(
                text: "Create New Staff",
                icon: Icon(Icons.done),
              ),
              Tab(
                text: "Account",
                icon: Icon(Icons.web_outlined),
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [CurrentStaffTab(), CreateStaffTab(), AboutAdminTab()],
        ),
      ),
    );
  }
}
