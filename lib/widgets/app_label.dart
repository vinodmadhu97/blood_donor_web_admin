import 'package:flutter/material.dart';

import '../constants/widget_size.dart';

class AppLabel extends StatelessWidget {
  final String text;
  final WidgetSize widgetSize;
  Color? textColor;
  FontWeight? fontWeight;
  double? fontSize;

  AppLabel(
      {required this.text,
      required this.widgetSize,
      this.textColor = Colors.black,
      this.fontSize = 16.0,
      this.fontWeight = FontWeight.normal});

  @override
  Widget build(BuildContext context) {
    if (widgetSize == WidgetSize.large) {
      fontSize = 16.0;
    } else if (widgetSize == WidgetSize.medium) {
      fontSize = 14.0;
    } else {
      fontSize = 12.0;
    }
    return Text(
      this.text,
      style: TextStyle(
        color: textColor,
        fontWeight: fontWeight,
        fontSize: fontSize,
      ),
    );
  }
}
