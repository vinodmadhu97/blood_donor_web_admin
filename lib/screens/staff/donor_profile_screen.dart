import 'package:blood_donor_web_admin/widgets/donor_profile_data_list.dart';
import 'package:flutter/material.dart';

import '../../widgets/profile_widget.dart';

class DonorProfileScreen extends StatefulWidget {
  @override
  _DonorProfileScreenState createState() => _DonorProfileScreenState();
}

class _DonorProfileScreenState extends State<DonorProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: [
        Expanded(flex: 1, child: Container()),
        Expanded(
          flex: 3,
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              SizedBox(
                height: 30,
              ),
              ProfileWidget(),
              const SizedBox(height: 24),
              Column(
                children: [
                  Text(
                    "Sarah Abs",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  const SizedBox(height: 4),
                  Text("No 13, Main Lane, Maharagama"),
                  const SizedBox(height: 4),
                  Text("0711234567")
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "A+",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                      SizedBox(height: 2),
                      Text(
                        "Group",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(height: 24, child: VerticalDivider()),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "04",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                      SizedBox(height: 2),
                      Text(
                        "donations",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              DonorProfileDataList(),
              SizedBox(
                height: 500,
              ),
            ],
          ),
        ),
        Expanded(flex: 1, child: Container()),
      ],
    ));
  }
}
