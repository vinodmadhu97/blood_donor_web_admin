import 'package:blood_donor_web_admin/constants/constants.dart';
import 'package:blood_donor_web_admin/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../../widgets/app_input_field.dart';

class AboutAdminTab extends StatelessWidget {
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> passwordKey = GlobalKey<FormState>();

  TextEditingController confirmPasswordController = TextEditingController();
  GlobalKey<FormState> confirmPasswordKey = GlobalKey<FormState>();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  AboutAdminTab({Key? key}) : super(key: key);

  bool _isValidate() {
    if (!passwordKey.currentState!.validate()) {
      return false;
    } else if (!confirmPasswordKey.currentState!.validate()) {
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
                    "Change Admin Password",
                    style: TextStyle(
                        color: Constants.appColorBrownRed, fontSize: 20),
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  AppInputField(
                      formKey: passwordKey,
                      controller: passwordController,
                      inputType: TextInputType.text,
                      obscure: true,
                      validator: MultiValidator([
                        RequiredValidator(errorText: "password required"),
                      ]),
                      hintText: "Password"),
                  SizedBox(
                    height: 40,
                  ),
                  Form(
                    key: confirmPasswordKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: TextFormField(
                          controller: confirmPasswordController,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Constants.appColorBlack, fontSize: 14),
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintStyle: TextStyle(
                                color: Constants.appColorGray, fontSize: 14),
                            hintText: "Confirm Password",
                            enabled: true,
                          ),
                          validator: (val) {
                            if (val!.isEmpty) return 'Re enter your password';
                            if (val != passwordController.text)
                              return 'Password does not matched';
                            return null;
                          }),
                    ),
                  ),
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
                        "SUBMIT",
                        style: TextStyle(color: Constants.appColorWhite),
                      )),
                    ),
                    onTap: () async {
                      if (_isValidate()) {
                        print("ok");
                        FirebaseServices().changeAdminPassword(
                            passwordController.text, context);
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
