import 'package:blood_donor_web_admin/widgets/blood_count_info_card.dart';
import 'package:blood_donor_web_admin/widgets/blood_group_info_card_grid_view.dart';
import 'package:blood_donor_web_admin/widgets/chart.dart';
import 'package:flutter/material.dart';

class CampaignSummaryTab extends StatelessWidget {
  CampaignSummaryTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Row(
              children: [
                BloodCountInfoCard(
                    title: "Total Requests",
                    svgSrc: "assets/icons/campaign-logo.svg",
                    amountOfFiles: "350",
                    numOfFiles: 220),
                SizedBox(
                  width: 50,
                ),
                BloodCountInfoCard(
                    title: "Completed Donations",
                    svgSrc: "assets/icons/campaign-logo.svg",
                    amountOfFiles: "350",
                    numOfFiles: 220),
                SizedBox(
                  width: 50,
                ),
                BloodCountInfoCard(
                    title: "Rejected Donations",
                    svgSrc: "assets/icons/campaign-logo.svg",
                    amountOfFiles: "20",
                    numOfFiles: 220)
              ],
            ),
            SizedBox(
              height: 30,
            ),
            BloodGroupInfoCardGridView(),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Expanded(flex: 2, child: Chart()),
                Expanded(
                    flex: 3,
                    child: Column(
                      children: const [
                        SizedBox(
                          child: BloodCountInfoCard(
                              title: "A (Rh positive)",
                              svgSrc: "assets/icons/campaign-logo.svg",
                              amountOfFiles: "70",
                              numOfFiles: 220),
                          width: 300,
                        ),
                        SizedBox(
                          child: BloodCountInfoCard(
                              title: "A (Rh negative)",
                              svgSrc: "assets/icons/campaign-logo.svg",
                              amountOfFiles: "50",
                              numOfFiles: 220),
                          width: 300,
                        ),
                        SizedBox(
                          child: BloodCountInfoCard(
                              title: "B (Rh positive)",
                              svgSrc: "assets/icons/campaign-logo.svg",
                              amountOfFiles: "30",
                              numOfFiles: 220),
                          width: 300,
                        ),
                        SizedBox(
                          child: BloodCountInfoCard(
                              title: "B (Rh negative)",
                              svgSrc: "assets/icons/campaign-logo.svg",
                              amountOfFiles: "50",
                              numOfFiles: 220),
                          width: 300,
                        ),
                        SizedBox(
                          child: BloodCountInfoCard(
                              title: "AB (Rh positive)",
                              svgSrc: "assets/icons/campaign-logo.svg",
                              amountOfFiles: "30",
                              numOfFiles: 220),
                          width: 300,
                        ),
                        SizedBox(
                          child: BloodCountInfoCard(
                              title: "AB (Rh negative)",
                              svgSrc: "assets/icons/campaign-logo.svg",
                              amountOfFiles: "35",
                              numOfFiles: 220),
                          width: 300,
                        ),
                        SizedBox(
                          child: BloodCountInfoCard(
                              title: "O (Rh positive)",
                              svgSrc: "assets/icons/campaign-logo.svg",
                              amountOfFiles: "50",
                              numOfFiles: 220),
                          width: 300,
                        ),
                        SizedBox(
                          child: BloodCountInfoCard(
                              title: "O (Rh negative)",
                              svgSrc: "assets/icons/campaign-logo.svg",
                              amountOfFiles: "20",
                              numOfFiles: 220),
                          width: 300,
                        ),
                      ],
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
