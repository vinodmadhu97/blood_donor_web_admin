
import 'package:blood_donor_web_admin/constants/constants.dart';
import 'package:blood_donor_web_admin/screens/staff/staff_login_screen.dart';
import 'package:flutter/material.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({Key? key}) : super(key: key);

  @override
  _AdminLoginScreenState createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  @override
  Widget build(BuildContext context) {
    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: const InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
    );

    final password = TextFormField(
      autofocus: false,
      initialValue: '',
      obscureText: true,
      decoration: const InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
    );

    final loginButton = Container(
      width: MediaQuery.of(context).size.width / 2.5,
      child: ElevatedButton(
        onPressed: () {
          /*Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AdminDashboardScreen()),
          );*/
        },
        child: const Text('LOGIN',
            style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
      ),
    );

    final staffLogin = ElevatedButton(
      child: const Text(
        'STAFF LOGIN',
        style: TextStyle(
          color: Constants.appColorWhite,
        ),
      ),
      onPressed: () {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => const StaffLoginScreen()));
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
                    staffLogin,
                    const SizedBox(height: 62.0),
                    const Center(
                        child: Text(
                      "ADMIN LOGIN",
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
