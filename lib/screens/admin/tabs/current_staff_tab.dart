import 'package:blood_donor_web_admin/widgets/current_staff_list.dart';
import 'package:flutter/material.dart';

import '../../../widgets/header.dart';

class CurrentStaffTab extends StatelessWidget {
  const CurrentStaffTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(children: [Expanded(flex: 1, child: Header())]),
          CurrentStaffList()
        ],
      ),
    );
  }
}
