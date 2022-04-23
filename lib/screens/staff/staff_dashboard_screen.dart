import 'package:blood_donor_web_admin/constants/constants.dart';
import 'package:blood_donor_web_admin/constants/custom_dialog_box.dart';
import 'package:blood_donor_web_admin/screens/staff/assessments_screen.dart';
import 'package:blood_donor_web_admin/screens/staff/blood_donor_screen.dart';
import 'package:blood_donor_web_admin/screens/staff/create_new_campaign_screen.dart';
import 'package:blood_donor_web_admin/screens/staff/notification_screen.dart';
import 'package:blood_donor_web_admin/screens/staff/staff_account_screen.dart';
import 'package:blood_donor_web_admin/screens/staff/staff_login_screen.dart';
import 'package:blood_donor_web_admin/widgets/profile_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';

import '../../services/firebase_services.dart';
import 'available_campaigns_screen.dart';

class StaffDashboardScreen extends StatefulWidget {
  @override
  StaffDashboardScreenState createState() => StaffDashboardScreenState();
}

class StaffDashboardScreenState extends State<StaffDashboardScreen>
    with SingleTickerProviderStateMixin {
  var userId = FirebaseAuth.instance.currentUser?.uid;
  late TabController tabController;
  int active = 0;
  @override
  void initState() {
    super.initState();
    tabController = new TabController(vsync: this, length: 6, initialIndex: 0)
      ..addListener(() {
        setState(() {
          active = tabController.index;
        });
      });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading:
            MediaQuery.of(context).size.width < 1300 ? true : false,
        title: Text(
          "Dashboard",
          style: TextStyle(color: Constants.appColorWhite, fontSize: 25),
        ),
        actions: <Widget>[
          ProfileCard(
            staffId: userId,
          ),
          SizedBox(width: 32),
          Container(
            child: IconButton(
              padding: EdgeInsets.all(0),
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                CustomDialogBox.buildOkWithCancelDialog(
                    description: "Do you want to Logout?", okOnclick: logOut);
              },
            ),
          ),
          SizedBox(width: 32),
        ],

        // automaticallyImplyLeading: false,
      ),
      body: Row(
        children: <Widget>[
          MediaQuery.of(context).size.width < 1300
              ? Container()
              : Card(
                  elevation: 2.0,
                  child: Container(
                      margin: EdgeInsets.all(0),
                      height: MediaQuery.of(context).size.height,
                      width: 300,
                      color: Colors.white,
                      child: listDrawerItems(false)),
                ),
          Container(
            width: MediaQuery.of(context).size.width < 1300
                ? MediaQuery.of(context).size.width
                : MediaQuery.of(context).size.width - 310,
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: tabController,
              children: [
                AvailableCampaign(),
                CreateNewCampaign(),
                AssessmentScreen(),
                BloodDonorScreen(),
                NotificationScreen(),
                StaffAccountScreen()
              ],
            ),
          )
        ],
      ),
      drawer: Padding(
          padding: EdgeInsets.only(top: 56),
          child: Drawer(
            child: listDrawerItems(true),
            backgroundColor: Constants.appColorBrownRed,
          )),
    );
  }

  Widget listDrawerItems(bool drawerStatus) {
    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        FlatButton(
          color: tabController.index == 0 ? Colors.grey[100] : Colors.white,
          //color: Colors.grey[100],
          onPressed: () {
            tabController.animateTo(0);
            drawerStatus ? Navigator.pop(context) : print("");
          },

          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.only(top: 22, bottom: 22, right: 22),
              child: Row(children: [
                SvgPicture.asset(
                  "assets/icons/menu_dashbord.svg",
                  color: Constants.appColorGray,
                  height: 20,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Available Campaigns",
                  style: TextStyle(
                      fontSize: 18, color: Constants.appColorBrownRed),
                ),
              ]),
            ),
          ),
        ),
        FlatButton(
          color: tabController.index == 1 ? Colors.grey[100] : Colors.white,
          onPressed: () {
            print(tabController.index);
            tabController.animateTo(1);
            drawerStatus ? Navigator.pop(context) : print("");
          },
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.only(top: 22, bottom: 22, right: 22),
              child: Row(children: [
                SvgPicture.asset(
                  "assets/icons/qr-code.svg",
                  color: Constants.appColorGray,
                  height: 20,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Create Campaigns",
                  style: TextStyle(
                      fontSize: 18, color: Constants.appColorBrownRed),
                ),
              ]),
            ),
          ),
        ),
        FlatButton(
          color: tabController.index == 2 ? Colors.grey[100] : Colors.white,
          onPressed: () {
            print(tabController.index);
            tabController.animateTo(2);
            drawerStatus ? Navigator.pop(context) : print("");
          },
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.only(top: 22, bottom: 22, right: 22),
              child: Row(children: [
                SvgPicture.asset(
                  "assets/icons/qr-code.svg",
                  color: Constants.appColorGray,
                  height: 20,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Assessments",
                  style: TextStyle(
                      fontSize: 18, color: Constants.appColorBrownRed),
                ),
              ]),
            ),
          ),
        ),
        FlatButton(
          color: tabController.index == 3 ? Colors.grey[100] : Colors.white,
          onPressed: () {
            tabController.animateTo(3);
            drawerStatus ? Navigator.pop(context) : print("");
          },
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.only(top: 22, bottom: 22, right: 22),
              child: Row(children: [
                SvgPicture.asset(
                  "assets/icons/campaign-logo.svg",
                  color: Constants.appColorGray,
                  height: 20,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Donors",
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'HelveticaNeue',
                      color: Constants.appColorBrownRed),
                ),
              ]),
            ),
          ),
        ),
        FlatButton(
          color: tabController.index == 4 ? Colors.grey[100] : Colors.white,
          onPressed: () {
            tabController.animateTo(4);
            drawerStatus ? Navigator.pop(context) : print("");
          },
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.only(top: 22, bottom: 22, right: 22),
              child: Row(children: [
                SvgPicture.asset(
                  "assets/icons/menu_notification.svg",
                  color: Constants.appColorGray,
                  height: 20,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Notifications",
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'HelveticaNeue',
                      color: Constants.appColorBrownRed),
                ),
              ]),
            ),
          ),
        ),
        FlatButton(
          color: tabController.index == 5 ? Colors.grey[100] : Colors.white,
          onPressed: () {
            tabController.animateTo(5);
            drawerStatus ? Navigator.pop(context) : print("");
          },
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.only(top: 22, bottom: 22, right: 22),
              child: Row(children: [
                Icon(
                  Icons.person,
                  color: Constants.appColorGray,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Account",
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'HelveticaNeue',
                      color: Constants.appColorBrownRed),
                ),
              ]),
            ),
          ),
        ),
      ],
    );
  }
}
