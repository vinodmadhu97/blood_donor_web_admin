import 'package:blood_donor_web_admin/constants/constants.dart';
import 'package:blood_donor_web_admin/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:nanoid/async.dart';

import '../../../widgets/app_input_field.dart';

class CreateStaffTab extends StatelessWidget {
  TextEditingController staffNameController = TextEditingController();
  GlobalKey<FormState> staffNameKey = GlobalKey<FormState>();
  TextEditingController staffEmailController = TextEditingController();
  GlobalKey<FormState> staffEmailKey = GlobalKey<FormState>();
  TextEditingController staffPhoneController = TextEditingController();
  GlobalKey<FormState> staffPhoneKey = GlobalKey<FormState>();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CreateStaffTab({Key? key}) : super(key: key);

  bool _isValidate() {
    if (!staffNameKey.currentState!.validate()) {
      return false;
    } else if (!staffEmailKey.currentState!.validate()) {
      return false;
    } else if (!staffPhoneKey.currentState!.validate()) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        children: [
          Expanded(flex: 1, child: Container()),
          Expanded(
              flex: 1,
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Create New Staff",
                    style: TextStyle(
                        color: Constants.appColorBrownRed, fontSize: 20),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  AppInputField(
                      formKey: staffNameKey,
                      controller: staffNameController,
                      inputType: TextInputType.text,
                      validator: MultiValidator([
                        RequiredValidator(errorText: "Name Required"),
                      ]),
                      hintText: "Name"),
                  SizedBox(
                    height: 30,
                  ),
                  AppInputField(
                      formKey: staffEmailKey,
                      controller: staffEmailController,
                      inputType: TextInputType.text,
                      validator: MultiValidator([
                        RequiredValidator(errorText: "Email Required"),
                      ]),
                      hintText: "Email"),
                  SizedBox(
                    height: 30,
                  ),
                  AppInputField(
                      formKey: staffPhoneKey,
                      controller: staffPhoneController,
                      inputType: TextInputType.text,
                      validator: MultiValidator([
                        RequiredValidator(errorText: "Phone Required"),
                      ]),
                      hintText: "Phone"),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Constants.appColorBrownRed),
                      child: Center(
                          child: Text(
                        "CREATE",
                        style: TextStyle(color: Constants.appColorWhite),
                      )),
                    ),
                    onTap: () async {
                      var password = await nanoid(8);
                      if (_isValidate()) {
                        await FirebaseServices().registerNewStaff(
                            context,
                            staffEmailController.text.trim(),
                            password,
                            staffNameController.text.trim(),
                            staffPhoneController.text.trim());
                      }
                    },
                  )
                ],
              )),
          Expanded(flex: 1, child: Container())
        ],
      ),
    );
  }
}
