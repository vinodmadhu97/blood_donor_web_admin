import 'package:blood_donor_web_admin/constants/constants.dart';
import 'package:blood_donor_web_admin/models/campaign.dart';
import 'package:blood_donor_web_admin/screens/staff/single_campaign_screen.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AvailableCampaignsList extends StatelessWidget {
  const AvailableCampaignsList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        padding: EdgeInsets.all(Constants.defaultPadding),
        decoration: BoxDecoration(
          color: Constants.appColorWhite,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Campaigns",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBox(
              width: double.infinity,
              child: DataTable2(
                columnSpacing: Constants.defaultPadding,
                minWidth: 600,
                columns: [
                  DataColumn(
                    label: Text("Campaign ID"),
                  ),
                  DataColumn(
                    label: Text("Location"),
                  ),
                  DataColumn(
                    label: Text("Date"),
                  ),
                  DataColumn(
                    label: Text("Time"),
                  ),
                  DataColumn(
                    label: Text("Status"),
                  ),
                  DataColumn(
                    label: Text(" "),
                  ),
                ],
                rows: List.generate(
                  Constants().campaignsList.length,
                  (index) =>
                      availableCampaignsDataRow(Constants().campaignsList[index],context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  DataRow availableCampaignsDataRow(Campaign fileInfo,BuildContext context) {
    return DataRow(
      cells: [
        DataCell(
          Row(
            children: [
              SvgPicture.asset(
                "assets/icons/campaign-logo.svg",
                height: 30,
                width: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Constants.defaultPadding),
                child: Text(fileInfo.campaignId!),
              ),
            ],
          ),
        ),
        DataCell(Text(fileInfo.title!)),
        DataCell(Text(fileInfo.date!)),
        DataCell(Text(fileInfo.time!)),
        DataCell(
          Text(fileInfo.status!),
        ),
        DataCell(ElevatedButton(
          child: Text("View"),
          onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (_)=>SingleCampaignScreen(campaignId: fileInfo.campaignId!)));},
        )),
      ],
    );
  }
}
