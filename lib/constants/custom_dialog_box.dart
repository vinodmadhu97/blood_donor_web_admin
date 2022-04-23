import 'package:blood_donor_web_admin/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class CustomDialogBox {
  static buildDialogBox({String? text}) {
    Get.defaultDialog(
        title: "",
        titlePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.all(30),
        barrierDismissible: false,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            SpinKitCircle(
              color: Constants.appColorBrownRed,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Please wait!",
              style: TextStyle(fontSize: 18),
            ),
          ],
        ));
  }

  static buildOkDialog({
    String title = "Alert",
    required String description,
    String confirmText = "Ok",
  }) {
    Get.defaultDialog(
        contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        title: title,
        middleText: description,
        backgroundColor: Colors.white,
        titleStyle: TextStyle(color: Constants.appColorBrownRed),
        middleTextStyle: TextStyle(color: Constants.appColorBlack),
        textConfirm: confirmText,
        confirmTextColor: Colors.white,
        buttonColor: Constants.appColorBrownRed,
        barrierDismissible: true,
        radius: 10,
        onConfirm: () {});
  }

  static buildOkWithCancelDialog(
      {String title = "Alert",
      required String description,
      String confirmText = "Ok",
      String cancelText = "Cancel",
      Widget? content,
      required Function okOnclick}) {
    Get.defaultDialog(
        contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        title: title,
        middleText: description,
        backgroundColor: Colors.white,
        titleStyle: TextStyle(color: Constants.appColorBrownRed),
        middleTextStyle: TextStyle(color: Constants.appColorBlack),
        textConfirm: confirmText,
        textCancel: cancelText,
        cancelTextColor: Constants.appColorBrownRed,
        confirmTextColor: Colors.white,
        buttonColor: Constants.appColorBrownRed,
        barrierDismissible: false,
        radius: 10,
        content: content,
        onConfirm: () {
          okOnclick();
        });
  }
}
