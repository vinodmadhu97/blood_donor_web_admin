import 'package:blood_donor_web_admin/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class AppInputField extends StatelessWidget {
  final GlobalKey<FormState>? formKey;
  final TextEditingController controller;
  final TextInputType inputType;
  final MultiValidator validator;
  final IconData? iconData;
  final bool enabled;
  final bool? obscure;
  final bool? isReadOnly;
  final String hintText;
  Color? color;

  AppInputField({
    Key? key,
    this.formKey,
    required this.controller,
    required this.inputType,
    required this.validator,
    this.iconData,
    this.enabled = true,
    this.obscure = false,
    this.isReadOnly = false,
    required this.hintText,
    this.color = Constants.appColorGray,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: TextFormField(
          controller: controller,
          textAlign: TextAlign.left,
          style: TextStyle(color: Constants.appColorBlack, fontSize: 14),
          keyboardType: inputType,
          obscureText: obscure!,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            icon: iconData != null
                ? Icon(
                    iconData,
                    color: color,
                    size: 20,
                  )
                : null,
            hintStyle: TextStyle(color: color, fontSize: 14),
            hintText: hintText,
            enabled: enabled,
          ),
          validator: validator),
    );
  }
}
