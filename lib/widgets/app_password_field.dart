import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../constants/constants.dart';

class AppPasswordField extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController controller;
  final TextInputType inputType;
  final MultiValidator validator;
  final IconData iconData;
  final String hintText;
  Color? color;
  AppPasswordField({
    Key? key,
    required this.formKey,
    required this.controller,
    required this.inputType,
    required this.validator,
    required this.iconData,
    required this.hintText,
    this.color = Constants.appColorGray,
  }) : super(key: key);

  @override
  _AppPasswordFieldState createState() => _AppPasswordFieldState();
}

class _AppPasswordFieldState extends State<AppPasswordField> {
  bool _isHidden = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: TextFormField(
            controller: widget.controller,
            textAlign: TextAlign.left,
            style: TextStyle(color: Constants.appColorBlack, fontSize: 14),
            keyboardType: widget.inputType,
            obscureText: _isHidden,
            decoration: InputDecoration(
              icon: Icon(
                widget.iconData,
                color: widget.color,
                size: 20,
              ),
              hintStyle: TextStyle(color: widget.color, fontSize: 14),
              hintText: widget.hintText,
              suffix: InkWell(
                  onTap: _togglePasswordView,
                  child: Icon(
                    _isHidden ? Icons.visibility : Icons.visibility_off,
                    color: Constants.appColorGray,
                  )),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: widget.color!),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: widget.color!),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: widget.color!),
              ),
            ),
            validator: widget.validator),
      ),
    );
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}
