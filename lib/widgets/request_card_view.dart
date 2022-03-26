import 'package:blood_donor_web_admin/constants/custom_dialog_box.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../constants/widget_size.dart';
import 'app_label.dart';

class CampaignCardView extends StatelessWidget {
  final String group;
  final String imgUrl;
  final String title;
  final String location;
  final String time;

  CampaignCardView(
      {Key? key,
      required this.group,
      required this.title,
      required this.imgUrl,
      required this.location,
      required this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        CustomDialogBox.buildOkWithCancelDialog(
            description: "Do you want to Delete?",
            okOnclick: () {
              print("Delete");
            });
      },
      child: Card(
          elevation: 5,
          //shadowColor: Colors.red,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Container(
            width: double.infinity,
            height: 150,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                      alignment: Alignment.center,
                      height: double.infinity,
                      color: Constants.appColorBrownRed,
                      child: Text(
                        group,
                        style: TextStyle(
                            fontSize: 28,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 6.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          AppLabel(
                            text: title,
                            widgetSize: WidgetSize.large,
                            textColor: Constants.appColorBrownRed,
                            fontWeight: FontWeight.w500,
                          ),
                          AppLabel(
                            text: location,
                            widgetSize: WidgetSize.medium,
                            textColor: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                          AppLabel(
                            text: time,
                            widgetSize: WidgetSize.medium,
                            textColor: Constants.appColorBlack,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
