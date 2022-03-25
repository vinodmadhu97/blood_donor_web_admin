import 'package:blood_donor_web_admin/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TableShimmer extends StatelessWidget {
  const TableShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Container(
                        height: 50,
                        color: Constants.appColorGray,
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      flex: 2,
                      child: Container(
                        height: 50,
                        color: Constants.appColorGray,
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      flex: 1,
                      child: Container(
                        height: 50,
                        color: Constants.appColorGray,
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      flex: 1,
                      child: Container(
                        height: 50,
                        color: Constants.appColorGray,
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      flex: 2,
                      child: Container(
                        height: 50,
                        color: Constants.appColorGray,
                      )),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                width: MediaQuery.of(context).size.width,
                height: 20,
                color: Constants.appColorGray,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 50),
                width: MediaQuery.of(context).size.width,
                height: 20,
                color: Constants.appColorGray,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 50),
                width: MediaQuery.of(context).size.width,
                height: 20,
                color: Constants.appColorGray,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 50),
                width: MediaQuery.of(context).size.width,
                height: 20,
                color: Constants.appColorGray,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 50),
                width: MediaQuery.of(context).size.width,
                height: 20,
                color: Constants.appColorGray,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 50),
                width: MediaQuery.of(context).size.width,
                height: 20,
                color: Constants.appColorGray,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 50),
                width: MediaQuery.of(context).size.width,
                height: 20,
                color: Constants.appColorGray,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 50),
                width: MediaQuery.of(context).size.width,
                height: 20,
                color: Constants.appColorGray,
              )
            ],
          ),
        ),
        baseColor: Colors.grey.shade500,
        highlightColor: Colors.grey.shade200);
  }
}
