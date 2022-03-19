import 'package:blood_donor_web_admin/constants/constants.dart';
import 'package:blood_donor_web_admin/models/history_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class ProfileHistoryDataList extends StatelessWidget {
  final DocumentSnapshot snapshot;
  ProfileHistoryDataList({Key? key, required this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    print(data);
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
              "Assessment History",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBox(
              width: double.infinity,
              child: DataTable2(
                  columnSpacing: Constants.defaultPadding,
                  minWidth: 600,
                  columns: [
                    DataColumn(
                      label: Text("Assessment"),
                    ),
                    DataColumn(
                      label: Text("Result"),
                    ),
                  ],
                  rows: [
                    DataRow(cells: [
                      DataCell(Text("Donor name and Id Is verified")),
                      DataCell(Text(data['isVerified'])),
                    ]),
                    DataRow(cells: [
                      DataCell(Text("Barcode")),
                      DataCell(Text(data['barcode'])),
                    ]),
                    DataRow(cells: [
                      DataCell(Text("Weight")),
                      DataCell(Text(data['weight'])),
                    ]),
                    DataRow(cells: [
                      DataCell(Text("Last Meal(<4 hrs)?")),
                      DataCell(Text(data['lastMeal'])),
                    ]),
                    DataRow(cells: [
                      DataCell(Text("Any Allergies or Medications")),
                      DataCell(Text(data['allergies'])),
                    ]),
                    DataRow(cells: [
                      DataCell(Text("Adequate overnight sleep? (>6hrs)")),
                      DataCell(Text(data['isSlept'])),
                    ]),
                    DataRow(cells: [
                      DataCell(Text("Ever Hospitalized?")),
                      DataCell(Text(data['hospitalized'])),
                    ]),
                    DataRow(cells: [
                      DataCell(Text("High risk Behaviors")),
                      DataCell(Text(data['isRisk'])),
                    ]),
                    DataRow(cells: [
                      DataCell(Text("CVS status pulse")),
                      DataCell(Text(data['cvs'])),
                    ]),
                    DataRow(cells: [
                      DataCell(Text("BP")),
                      DataCell(Text(data['bp'])),
                    ]),
                    DataRow(cells: [
                      DataCell(Text("Remark")),
                      DataCell(Text(data['remark'])),
                    ]),
                  ]
                  /*List.generate(
                  Constants().historyDataList.length,
                  (index) => availableCampaignsDataRow(
                      Constants().historyDataList[index], context),
                ),*/
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
