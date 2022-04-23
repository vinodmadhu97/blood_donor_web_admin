import 'package:blood_donor_web_admin/screens/shimmers/table_shimmer.dart';
import 'package:blood_donor_web_admin/widgets/app_input_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../constants/constants.dart';
import '../../services/firebase_services.dart';

class AssessmentScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final assessmentEnFormKey = GlobalKey<FormState>();
  final assessmentSiFormKey = GlobalKey<FormState>();
  final assessmentTaFormKey = GlobalKey<FormState>();
  final assessmentAnsFormKey = GlobalKey<FormState>();
  TextEditingController assessmentEnController = TextEditingController();
  TextEditingController assessmentSiController = TextEditingController();
  TextEditingController assessmentTaController = TextEditingController();
  TextEditingController assessmentAnsController = TextEditingController();

  AssessmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(children: [
              Expanded(flex: 8, child: Container()),
              Expanded(
                  flex: 1,
                  child: Card(
                    child: ElevatedButton(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Row(
                          children: [
                            Icon(Icons.add),
                            SizedBox(
                              width: 4,
                            ),
                            Text("Add New")
                          ],
                        ),
                      ),
                      onPressed: () {
                        showAssessmentDialog(context, false, null);
                      },
                    ),
                  )),
            ]),
            StreamBuilder(
                stream: FirebaseServices().getAssesments(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return TableShimmer();
                  }

                  return Card(
                    elevation: 10,
                    child: Container(
                      padding: EdgeInsets.all(Constants.defaultPadding),
                      decoration: BoxDecoration(
                        color: Constants.appColorWhite,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Assessments",
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: DataTable2(
                              columnSpacing: Constants.defaultPadding,
                              minWidth: 600,
                              columns: [
                                DataColumn(
                                  label: Text("assessment"),
                                ),
                                DataColumn(
                                  label: Text("answer"),
                                ),
                                DataColumn(
                                  label: Text(""),
                                ),
                              ],
                              rows: List.generate(
                                snapshot.data!.docs.length,
                                (index) => availableAssessmentDataRow(
                                    snapshot.data!.docs[index],
                                    context,
                                    index + 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }

  DataRow availableAssessmentDataRow(
      QueryDocumentSnapshot snapshot, BuildContext context, int no) {
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
                child: Text(snapshot['assessment']['as_en']),
              ),
            ],
          ),
        ),
        DataCell(Text(snapshot['answer'])),
        DataCell(Row(
          children: [
            ElevatedButton(
              child: Text("Edit"),
              onPressed: () {
                assessmentEnController.text = snapshot['assessment']['as_en'];
                assessmentSiController.text = snapshot['assessment']['as_si'];
                assessmentTaController.text = snapshot['assessment']['as_ta'];
                assessmentAnsController.text = snapshot['answer'];
                showAssessmentDialog(context, true, snapshot.id);
              },
            ),
            SizedBox(
              width: 8,
            ),
            ElevatedButton(
              child: Text("Delete"),
              onPressed: () {
                /*Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => SingleCampaignManagementScreen()));*/
                FirebaseServices().deleteAssessment(context, snapshot.id);
              },
            )
          ],
        )),
      ],
    );
  }

  void showAssessmentDialog(
      BuildContext context, bool isEdit, String? assesId) {
    if (!isEdit) {
      assessmentEnController.clear();
      assessmentSiController.clear();
      assessmentTaController.clear();
      assessmentAnsController.clear();
    }

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                Positioned(
                  right: -40.0,
                  top: -40.0,
                  child: InkResponse(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: CircleAvatar(
                      child: Icon(
                        Icons.close,
                        color: Constants.appColorWhite,
                      ),
                      backgroundColor: Constants.appColorBrownRed,
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: AppInputField(
                        formKey: assessmentEnFormKey,
                        controller: assessmentEnController,
                        validator: MultiValidator(
                            [RequiredValidator(errorText: "Required")]),
                        hintText: 'Assessment in English',
                        inputType: TextInputType.text,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: AppInputField(
                        formKey: assessmentSiFormKey,
                        controller: assessmentSiController,
                        validator: MultiValidator(
                            [RequiredValidator(errorText: "Required")]),
                        hintText: 'Assessment in Sinhala',
                        inputType: TextInputType.text,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: AppInputField(
                        formKey: assessmentTaFormKey,
                        controller: assessmentTaController,
                        validator: MultiValidator(
                            [RequiredValidator(errorText: "Required")]),
                        hintText: 'Assessment in Tamil',
                        inputType: TextInputType.text,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: AppInputField(
                        formKey: assessmentAnsFormKey,
                        controller: assessmentAnsController,
                        validator: MultiValidator(
                            [RequiredValidator(errorText: "Required")]),
                        hintText: 'Answer',
                        inputType: TextInputType.text,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        child: isEdit ? Text("Edit") : Text("Submit"),
                        onPressed: () {
                          if (isValidate()) {
                            FirebaseServices().addOrEditAssessments(
                                context: context,
                                assesInEn: assessmentEnController.text.trim(),
                                assesInSi: assessmentSiController.text.trim(),
                                assesInTa: assessmentTaController.text.trim(),
                                assesAns: assessmentAnsController.text.trim(),
                                assesId: assesId,
                                isEdited: isEdit);
                          }
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        });
  }

  bool isValidate() {
    if (!assessmentEnFormKey.currentState!.validate()) {
      return false;
    } else if (!assessmentSiFormKey.currentState!.validate()) {
      return false;
    } else if (!assessmentTaFormKey.currentState!.validate()) {
      return false;
    } else if (!assessmentAnsFormKey.currentState!.validate()) {
      return false;
    } else {
      return true;
    }
  }
}
