import 'package:blood_donor_web_admin/constants/constants.dart';
import 'package:blood_donor_web_admin/models/history_data.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class ProfileHistoryDataList extends StatelessWidget {
  const ProfileHistoryDataList({
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
              "History",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBox(
              width: double.infinity,
              child: DataTable2(
                columnSpacing: Constants.defaultPadding,
                minWidth: 600,
                columns: [
                  DataColumn(
                    label: Text(""),
                  ),
                  DataColumn(
                    label: Text(""),
                  ),
                ],
                rows: List.generate(
                  Constants().historyDataList.length,
                  (index) => availableCampaignsDataRow(
                      Constants().historyDataList[index], context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  DataRow availableCampaignsDataRow(
      HistoryData fileInfo, BuildContext context) {
    return DataRow(
      cells: [
        DataCell(Text(fileInfo.type)),
        DataCell(Text(fileInfo.result)),
      ],
    );
  }
}
