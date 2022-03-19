import 'package:blood_donor_web_admin/constants/constants.dart';
import 'package:blood_donor_web_admin/models/question_answer.dart';
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
    Map<String, dynamic> assessResult = snapshot.data[0].data();

    List<QuestionAnswer> answers = assessResult.entries
        .map((value) =>
            QuestionAnswer(questionId: value.key, answer: value.value))
        .toList();

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
                columns: const [
                  /*DataColumn(
                    label: Text("No"),
                  ),*/
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
                  answers.length,
                  (index) => requestDataRow(answers[index], context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  DataRow requestDataRow(QuestionAnswer fileInfo, BuildContext context) {
    return DataRow(
      cells: [
        DataCell(Text(fileInfo.questionId)),
        DataCell(Text(fileInfo.answer)),
        /*DataCell(Text(fileInfo.answer!)),*/
      ],
    );
  }
}
