import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/constants.dart';

class BloodCountInfoCard extends StatelessWidget {
  const BloodCountInfoCard({
    Key? key,
    required this.title,
    required this.svgSrc,
    required this.amountOfFiles,
    required this.numOfFiles,
  }) : super(key: key);

  final String title, svgSrc, amountOfFiles;
  final int numOfFiles;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Constants.defaultPadding),
      padding: EdgeInsets.all(Constants.defaultPadding),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: Constants.appColorBrownRed),
        borderRadius: const BorderRadius.all(
          Radius.circular(Constants.defaultPadding),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            height: 20,
            width: 20,
            child: SvgPicture.asset(svgSrc),
          ),
          SizedBox(
            width: 50,
          ),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            width: 50,
          ),
          Text(amountOfFiles)
        ],
      ),
    );
  }
}
