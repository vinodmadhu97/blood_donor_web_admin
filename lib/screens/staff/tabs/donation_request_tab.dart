import 'package:blood_donor_web_admin/widgets/campaign_request_list.dart';
import 'package:flutter/material.dart';

import '../../../widgets/header.dart';

class DonationRequestTab extends StatelessWidget {
  final String campaignId;

  DonationRequestTab({Key? key, required this.campaignId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(children: [Expanded(flex: 1, child: Header())]),
          CampaignsRequestList()
        ],
      ),
    );
  }
}
