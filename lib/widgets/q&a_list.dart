import 'package:blood_donor_web_admin/constants/constants.dart';
import 'package:blood_donor_web_admin/models/question.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class QAList extends StatelessWidget {
  final AsyncSnapshot snapshot;
  const QAList({
    required this.snapshot,
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
                  snapshot.data.data().length,
                  (index) =>
                      requestDataRow(snapshot.data.data()[index], context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  DataRow requestDataRow(Question fileInfo, BuildContext context) {
    return DataRow(
      cells: [
        DataCell(Text(fileInfo.qno!)),
        DataCell(Text(fileInfo.question!)),
        DataCell(Text(fileInfo.answer!)),
      ],
    );
  }
}
