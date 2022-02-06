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
import 'package:blood_donor_web_admin/screens/staff/create_new_campaign_screen.dart';
import 'package:blood_donor_web_admin/screens/staff/notification_screen.dart';
import 'package:blood_donor_web_admin/screens/staff/staff_login_screen.dart';
import 'package:blood_donor_web_admin/widgets/profile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'available_campaigns_screen.dart';
class StaffHomeScreen extends StatefulWidget {
  @override
  StaffHomeScreenState createState() => StaffHomeScreenState();
}

class StaffHomeScreenState extends State<StaffHomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int active = 0;
  @override
  void initState() {
    super.initState();
    tabController = new TabController(vsync: this, length: 3, initialIndex: 0)
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        automaticallyImplyLeading:
        MediaQuery.of(context).size.width < 1300 ? true : false,
        title: Text("Dashboard",style: TextStyle(color: Constants.appColorWhite,fontSize: 25),),
        actions: <Widget>[
          ProfileCard(),
          SizedBox(width: 32),
         
          Container(
            child: IconButton(
              padding: EdgeInsets.all(0),
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>StaffLoginScreen()));
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
                NotificationScreen()
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
          )
      ),
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
                    fontSize: 18,
                    color: Constants.appColorBrownRed
                  ),
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
                    fontSize: 18,
                      color: Constants.appColorBrownRed
                  ),
                ),
              ]),
            ),
          ),
        ),
        FlatButton(
          color: tabController.index == 2 ? Colors.grey[100] : Colors.white,
          onPressed: () {
            tabController.animateTo(2);
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
                      color: Constants.appColorBrownRed
                  ),
                ),
              ]),
            ),
          ),
        ),
      ],
    );
  }
}