import 'package:blood_donor_web_admin/screens/staff/tabs/campaign_summary_tab.dart';
import 'package:blood_donor_web_admin/screens/staff/tabs/completed_donors_tab.dart';
import 'package:blood_donor_web_admin/screens/staff/tabs/donation_request_tab.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class SingleCampaignManagementScreen extends StatefulWidget {
  const SingleCampaignManagementScreen({Key? key}) : super(key: key);

  @override
  State<SingleCampaignManagementScreen> createState() =>
      _SingleCampaignManagementScreenState();
}

class _SingleCampaignManagementScreenState
    extends State<SingleCampaignManagementScreen> {
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
                    "ID : hfjd94n3",
                    style:
                        TextStyle(color: Constants.appColorWhite, fontSize: 30),
                  ),
                ),
                Expanded(
                    flex: 3,
                    child: Text("Location : Maharagama",
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
                text: "Donation Requests",
                icon: Icon(Icons.call_received),
              ),
              Tab(
                text: "Completed Donors",
                icon: Icon(Icons.done),
              ),
              Tab(
                text: "Summary",
                icon: Icon(Icons.web_outlined),
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            DonationRequestTab(campaignId: "4949483984"),
            CompletedDonorsTab(),
            CampaignSummaryTab()
          ],
        ),
      ),
    );
  }
}
