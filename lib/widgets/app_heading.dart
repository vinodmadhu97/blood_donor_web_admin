import 'package:flutter/material.dart';

import '../constants/widget_size.dart';

class AppHeading extends StatelessWidget {
  final String text;
  WidgetSize? widgetSize;
  Color? color;
  FontWeight? fontWeight;
  double? fontSize;
  AppHeading(
      {Key? key,
      required this.text,
      this.widgetSize = WidgetSize.large,
      this.color = Colors.black,
      this.fontWeight = FontWeight.w600,
      this.fontSize = 36.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (widgetSize == WidgetSize.large) {
      fontSize = 36.0;
    } else if (widgetSize == WidgetSize.medium) {
      fontSize = 24.0;
    } else {
      fontSize = 20.0;
    }
    return Text(
      text,
      style:
          TextStyle(color: color, fontWeight: fontWeight, fontSize: fontSize),
    );
  }
}
