
import 'package:blood_donor_web_admin/constants/constants.dart';
import 'package:blood_donor_web_admin/screens/staff/available_campaigns_screen.dart';
import 'package:blood_donor_web_admin/screens/staff/create_new_campaign_screen.dart';
import 'package:flutter/material.dart';
import 'drawer_list_tile.dart';
class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Constants.appColorBrownRed,
      child: ListView(
        children: [
          DrawerHeader(
            child: Column(children: [
              Image.asset("assets/images/logo.png",width: 80,height: 80,),
              Text("Donor",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Constants.appColorWhite),)
            ]),
          ),

          DrawerListTile(
            title: "Available campaigns",
            svgSrc: "assets/icons/menu_dashbord.svg",
            press: () =>AvailableCampaign()

          ),

          DrawerListTile(
            title: "Create new campaigns",
            svgSrc: "assets/icons/qr-code.svg",
            press: ()=>CreateNewCampaign()

          ),


          DrawerListTile(
            title: "Notifications",
            svgSrc: "assets/icons/menu_notification.svg",
            press: () {},
          ),
         
        ],
      ),
    );
  }
}