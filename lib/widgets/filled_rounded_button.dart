
import 'package:blood_donor_web_admin/constants/constants.dart';
import 'package:blood_donor_web_admin/constants/widget_size.dart';


import 'package:flutter/material.dart';


class FilledRoundedButton extends StatelessWidget {
  final String text;
  final WidgetSize widgetSize;
  final Function clickEvent;
  Color? color;
  double? height;
  double? width;
  double? radius;
  double? fontSize;


  FilledRoundedButton({
    Key? key,
    required this.text,
    required this.widgetSize,
    required this.clickEvent,
    this.color = Constants.appColorBrownRed,
    this.height = 48.0,
    this.width =  110,
    this.radius = 24.0,
    this.fontSize = 16.0

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(widgetSize == WidgetSize.large){
      width = MediaQuery.of(context).size.width * 0.7;
      height = 48.0;
      radius = 24.0;
      fontSize = 16.0;

    }else if(widgetSize == WidgetSize.medium) {
      width = MediaQuery
          .of(context)
          .size
          .width * 0.5;
      height = 40.0;
      radius = 24.0;
      fontSize = 14.0;
    }else if(widgetSize == WidgetSize.maxSize){
      width = MediaQuery.of(context).size.width;
      height = 50;
    }else{
      width = MediaQuery.of(context).size.width * 0.3;
      height = 32.0;
      radius = 24.0;
      fontSize = 12.0;
    }

    return GestureDetector(
      onTap: (){clickEvent();},
      child: Container(
        alignment: Alignment.center,
        height: height,
        width: width,
        child: Text(text,style: TextStyle(fontSize: fontSize,color: Colors.white ),),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radius!)
        ),
      ),
    );
  }
}

