import 'package:blood_donor_web_admin/constants/constants.dart';
import 'package:blood_donor_web_admin/widgets/campaign_request_list.dart';
import 'package:blood_donor_web_admin/widgets/header.dart';
import 'package:flutter/material.dart';

class SingleCampaignScreen extends StatelessWidget {
  final String campaignId;

  SingleCampaignScreen({Key? key, required this.campaignId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(campaignId),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
            child: Row(
              children: [
                Expanded(flex:2,child: Text("ID : hfjd94n3",style: TextStyle(color: Constants.appColorBrownRed,fontSize: 30),),),
                Expanded(flex:3,child: Text("Location : Maharagama",style:TextStyle(color: Constants.appColorBrownRed,fontSize: 30))),
                Expanded(flex:8,child: Header())
              ],
            ),
          ),

          CampaignsRequestList()

        ],
      ),
    );
  }
}
