import 'package:blood_donor_web_admin/screens/staff/tabs/campaign_tab.dart';
import 'package:blood_donor_web_admin/screens/staff/tabs/poster_tab.dart';
import 'package:blood_donor_web_admin/screens/staff/tabs/request_tab.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
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
                    child: Text("",
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
                text: "Notices",
                icon: Icon(Icons.call_received),
              ),
              Tab(
                text: "Campaign promotions",
                icon: Icon(Icons.done),
              ),
              Tab(
                text: "Requests",
                icon: Icon(Icons.web_outlined),
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [PosterTab(), CampaignTab(), RequestTab()],
        ),
      ),
    );
  }
}
