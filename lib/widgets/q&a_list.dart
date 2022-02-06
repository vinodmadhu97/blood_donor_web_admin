import 'package:blood_donor_web_admin/constants/constants.dart';
import 'package:blood_donor_web_admin/models/campaign.dart';
import 'package:blood_donor_web_admin/models/question.dart';
import 'package:blood_donor_web_admin/models/request.dart';
import 'package:blood_donor_web_admin/screens/staff/single_campaign_screen.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class QAList extends StatelessWidget {
  const QAList({
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
              "Donor Report",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBox(
              width: double.infinity,
              child: DataTable2(
                columnSpacing: Constants.defaultPadding,
                minWidth: 600,
                columns: [
                  DataColumn(
                    label: Text("No"),
                  ),
                  DataColumn(
                    label: Text("Question"),
                  ),
                  DataColumn(
                    label: Text("Answer"),
                  ),
                  /*DataColumn(
                    label: Text(" "),
                  ),*/
                ],
                rows: List.generate(
                  Constants().qaList.length,
                  (index) =>
                      requestDataRow(Constants().qaList[index],context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  DataRow requestDataRow(Question fileInfo,BuildContext context) {
    return DataRow(
      cells: [
        DataCell(Text(fileInfo.qno!)),
        DataCell(Text(fileInfo.question!)),
        DataCell(Text(fileInfo.answer!)),
        /*DataCell(ElevatedButton(
          child: Text("Action"),
          onPressed: (){*//*Navigator.of(context).push(MaterialPageRoute(builder: (_)=>SingleCampaignScreen(campaignId: fileInfo.campaignId!)));*//*},
        )),*/
      ],
    );
  }
}
