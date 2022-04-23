import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../constants/widget_size.dart';
import 'app_label.dart';

class RequestCardView extends StatelessWidget {
  final String group;
  final String location;
  final String address;
  final String date;
  final String startTime;
  final String endTime;

  RequestCardView(
      {Key? key,
      required this.group,
      required this.location,
      required this.address,
      required this.date,
      required this.startTime,
      required this.endTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
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
                      style: const TextStyle(
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
                          text: location,
                          widgetSize: WidgetSize.large,
                          textColor: Constants.appColorBrownRed,
                          fontWeight: FontWeight.w500,
                        ),
                        AppLabel(
                          text: address,
                          widgetSize: WidgetSize.medium,
                          textColor: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                        AppLabel(
                          text: "$date \nat $startTime.00 am - $endTime.00 pm",
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
        ));
  }
}
