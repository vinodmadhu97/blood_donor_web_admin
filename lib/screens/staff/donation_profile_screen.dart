import 'package:blood_donor_web_admin/widgets/proifle_history_data_list.dart';
import 'package:flutter/material.dart';

import '../../widgets/profile_widget.dart';

class DonationProfilePage extends StatefulWidget {
  @override
  _DonationProfilePageState createState() => _DonationProfilePageState();
}

class _DonationProfilePageState extends State<DonationProfilePage> {
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
                  Text("972000272V")
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
              ProfileHistoryDataList(),
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
