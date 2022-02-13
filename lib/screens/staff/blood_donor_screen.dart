import 'package:blood_donor_web_admin/widgets/header.dart';
import 'package:blood_donor_web_admin/widgets/registered_donors_list.dart';
import 'package:flutter/material.dart';

class BloodDonorScreen extends StatelessWidget {
  const BloodDonorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [Header(), RegisteredDonorsList()],
      ),
    );
  }
}
