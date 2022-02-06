import 'package:blood_donor_web_admin/widgets/available_campaigns_list.dart';
import 'package:blood_donor_web_admin/widgets/header.dart';
import 'package:flutter/material.dart';

class AvailableCampaign extends StatelessWidget {
  const AvailableCampaign({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
             Header(),
            AvailableCampaignsList(),
        ],
      ),
    );
  }
}
