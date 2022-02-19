/*
import 'package:blood_donor_web_admin/constants/responsive.dart';
import 'package:blood_donor_web_admin/controller/menu_controller.dart';
import 'package:blood_donor_web_admin/screens/staff/available_campaigns.dart';
import 'package:blood_donor_web_admin/screens/staff/staff_home_screen.dart';
import 'package:blood_donor_web_admin/widgets/slide_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class StaffDashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuController>().scaffoldKey,
      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: AvailableCampaign(),
            ),
          ],
        ),
      ),
    );
  }
}*/
import 'package:blood_donor_web_admin/constants/constants.dart';
import 'package:blood_donor_web_admin/screens/admin/tabs/about_admin_tab.dart';
import 'package:blood_donor_web_admin/screens/admin/tabs/create_staff_tab.dart';
import 'package:blood_donor_web_admin/screens/admin/tabs/current_staff_tab.dart';
import 'package:flutter/material.dart';

class AdminDashboardScreen extends StatefulWidget {
  @override
  AdminDashboardScreenState createState() => AdminDashboardScreenState();
}

class AdminDashboardScreenState extends State<AdminDashboardScreen> {
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
                  flex: 2,
                  child: Text(
                    "",
                    style:
                        TextStyle(color: Constants.appColorWhite, fontSize: 30),
                  ),
                ),
                Expanded(
                    flex: 3,
                    child: Text("Admin",
                        style: TextStyle(
                            color: Constants.appColorWhite, fontSize: 30))),
              ],
            ),
          ),
          centerTitle: true,
          bottom: TabBar(
            labelColor: Constants.appColorWhite,
            //indicatorColor: Constants.appColorGray,
            tabs: [
              Tab(
                text: "Current Staff",
                icon: Icon(Icons.call_received),
              ),
              Tab(
                text: "Create Staff",
                icon: Icon(Icons.done),
              ),
              Tab(
                text: "About",
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
