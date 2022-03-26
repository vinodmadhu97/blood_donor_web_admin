import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/custom_dialog_box.dart';

class PosterCard extends StatelessWidget {
  const PosterCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 150,
      child: InkWell(
        onTap: () {
          CustomDialogBox.buildOkWithCancelDialog(
              description: "Do you want to Delete?",
              okOnclick: () {
                Get.back();
                print("deleted");
              });
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            "assets/images/poster-2.jpg",
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
