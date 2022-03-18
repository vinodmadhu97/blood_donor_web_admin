import 'package:blood_donor_web_admin/constants/constants.dart';
import 'package:blood_donor_web_admin/services/firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../admin/admin_login_screen.dart';

class StaffLoginScreen extends StatefulWidget {
  const StaffLoginScreen({Key? key}) : super(key: key);

  @override
  _StaffLoginScreenState createState() => _StaffLoginScreenState();
}

class _StaffLoginScreenState extends State<StaffLoginScreen> {
  /*GlobalKey<FormState> _emailKey = GlobalKey<FormState>();

  GlobalKey<FormState> _passwordKey = GlobalKey<FormState>();
  final TextEditingController _emailController =
      TextEditingController(text: "username");

  final TextEditingController _passwordController =
      TextEditingController(text: "passowrd");*/

  String email = "";
  String password = "";

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    var email = TextFormField(
      /*key: _emailKey,
      controller: _emailController,*/
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: const InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
      onChanged: (value) {
        this.email = value;
      },
    );

    var password = TextFormField(
      /*key: _passwordKey,
      controller: _passwordController,*/
      autofocus: false,
      initialValue: '',
      obscureText: true,
      decoration: const InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
      onChanged: (value) {
        this.password = value;
      },
    );

    var loginButton = Container(
      width: MediaQuery.of(context).size.width / 2.5,
      child: ElevatedButton(
        onPressed: () async {
          FirebaseServices().staffLogin(this.email, this.password, context);
        },
        child: const Text('LOGIN',
            style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
      ),
    );

    var adminLogin = ElevatedButton(
      child: const Text(
        'ADMIN LOGIN',
        style: TextStyle(
          color: Constants.appColorWhite,
        ),
      ),
      onPressed: () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const AdminLoginScreen()));
      },
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                color: Constants.appColorWhite,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                color: Constants.appColorBrownRed,
              ),
            ],
          ),
          Center(
            child: Card(
              elevation: 2.0,
              child: Container(
                padding: const EdgeInsets.all(42),
                width: MediaQuery.of(context).size.width / 2.5,
                height: MediaQuery.of(context).size.height / 1.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    adminLogin,
                    const SizedBox(height: 62.0),
                    const Center(
                        child: Text(
                      "STAFF LOGIN",
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Constants.appColorBrownRed),
                    )),
                    const SizedBox(height: 48.0),
                    email,
                    const SizedBox(height: 8.0),
                    password,
                    const SizedBox(height: 24.0),
                    loginButton,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
