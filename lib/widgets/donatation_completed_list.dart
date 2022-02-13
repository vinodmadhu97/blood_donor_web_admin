import 'package:blood_donor_web_admin/constants/constants.dart';
import 'package:blood_donor_web_admin/screens/staff/donation_profile_screen.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../models/completed_donor.dart';

class DonationCompletedList extends StatelessWidget {
  const DonationCompletedList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        padding: EdgeInsets.all(Constants.defaultPadding),
        decoration: BoxDecoration(
          color: Constants.appColorWhite,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Completed",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBox(
              width: double.infinity,
              child: DataTable2(
                columnSpacing: Constants.defaultPadding,
                minWidth: 600,
                columns: [
                  DataColumn(
                    label: Text("Donor Id"),
                  ),
                  DataColumn(
                    label: Text("Name"),
                  ),
                  DataColumn(
                    label: Text("Status"),
                  ),
                  DataColumn(
                    label: Text(" "),
                  ),
                ],
                rows: List.generate(
                  Constants().completedDonorList.length,
                  (index) => donationCompletedDataRow(
                      Constants().completedDonorList[index], context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  DataRow donationCompletedDataRow(
      CompletedDonor fileInfo, BuildContext context) {
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
                child: Text(fileInfo.donorId!),
              ),
            ],
          ),
        ),
        DataCell(Text(fileInfo.name!)),
        DataCell(Text(fileInfo.status!)),
        DataCell(ElevatedButton(
          child: Text("View"),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => DonationProfilePage()));
          },
        )),
      ],
    );
  }
}
