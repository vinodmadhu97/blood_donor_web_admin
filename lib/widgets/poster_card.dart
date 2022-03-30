import 'package:blood_donor_web_admin/constants/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../constants/custom_dialog_box.dart';

class PosterCard extends StatelessWidget {
  final String docId;
  final String url;
  const PosterCard({Key? key, required this.docId, required this.url})
      : super(key: key);

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
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: url,
            placeholder: (context, url) => const SpinKitCircle(
              color: Constants.appColorBrownRed,
              size: 50,
            ),
            errorWidget: (context, url, error) =>
                Image.asset("assets/images/profile_avatar.jpg"),
          ),
        ),
      ),
    );
  }
}
