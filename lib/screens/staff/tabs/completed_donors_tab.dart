import 'package:blood_donor_web_admin/widgets/donatation_completed_list.dart';
import 'package:flutter/material.dart';

import '../../../widgets/header.dart';

class CompletedDonorsTab extends StatelessWidget {
  CompletedDonorsTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(children: [Expanded(flex: 1, child: Header())]),
          DonationCompletedList()
        ],
      ),
    );
  }
}
