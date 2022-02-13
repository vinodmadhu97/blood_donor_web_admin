import 'package:blood_donor_web_admin/widgets/progress_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/constants.dart';
import '../models/donation_summary.dart';

class BloodGroupInfoCard extends StatelessWidget {
  const BloodGroupInfoCard({
    Key? key,
    required this.donationInfo,
  }) : super(key: key);

  final DonationSummary donationInfo;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Container(
        padding: EdgeInsets.all(Constants.defaultPadding),
        decoration: BoxDecoration(
          color: Constants.appColorWhite,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(Constants.defaultPadding * 0.75),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: donationInfo.color!.withOpacity(0.1),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: SvgPicture.asset(
                    donationInfo.svgSrc!,
                    color: donationInfo.color,
                  ),
                ),
                Icon(Icons.more_vert, color: Colors.white54)
              ],
            ),
            Text(
              "Group : ${donationInfo.group!}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: donationInfo.color, fontSize: 20),
            ),
            Text(
              "Counts : ${donationInfo.count!}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: donationInfo.color, fontSize: 20),
            ),
            Text(
              "25%",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: donationInfo.color, fontSize: 20),
            ),
            ProgressLine(
              color: donationInfo.color,
              percentage: 25,
            ),
          ],
        ),
      ),
    );
  }
}
