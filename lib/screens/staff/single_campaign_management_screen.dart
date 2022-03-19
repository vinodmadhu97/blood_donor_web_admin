import 'package:blood_donor_web_admin/screens/staff/tabs/campaign_summary_tab.dart';
import 'package:blood_donor_web_admin/screens/staff/tabs/completed_donors_tab.dart';
import 'package:blood_donor_web_admin/screens/staff/tabs/donation_request_tab.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class SingleCampaignManagementScreen extends StatefulWidget {
  final String campaignId;
  final String location;
  SingleCampaignManagementScreen(
      {Key? key, required this.campaignId, required this.location})
      : super(key: key);

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
                    "ID : ${widget.campaignId}",
                    style:
                        TextStyle(color: Constants.appColorWhite, fontSize: 30),
                  ),
                ),
                Expanded(
                    flex: 3,
                    child: Text(widget.location,
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
            DonationRequestTab(
              campaignId: widget.campaignId,
            ),
            CompletedDonorsTab(
              campaignId: widget.campaignId,
            ),
            CampaignSummaryTab()
          ],
        ),
      ),
    );
  }
}
