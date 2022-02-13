import 'package:blood_donor_web_admin/models/blood_donor.dart';
import 'package:blood_donor_web_admin/screens/staff/donor_profile_screen.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/constants.dart';

class RegisteredDonorsList extends StatelessWidget {
  const RegisteredDonorsList({Key? key}) : super(key: key);

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
              "Campaigns",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBox(
              width: double.infinity,
              child: DataTable2(
                columnSpacing: Constants.defaultPadding,
                minWidth: 600,
                columns: [
                  DataColumn(
                    label: Text("Donor ID"),
                  ),
                  DataColumn(
                    label: Text("Name"),
                  ),
                  DataColumn(
                    label: Text("NIC"),
                  ),
                  DataColumn(
                    label: Text("Address"),
                  ),
                  DataColumn(
                    label: Text("DOB"),
                  ),
                  DataColumn(
                    label: Text("Phone"),
                  ),
                  DataColumn(
                    label: Text("Status"),
                  ),
                  DataColumn(
                    label: Text(" "),
                  ),
                ],
                rows: List.generate(
                  Constants().bloodDonorsList.length,
                  (index) => availableCampaignsDataRow(
                      Constants().bloodDonorsList[index], context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  DataRow availableCampaignsDataRow(BloodDonor fileInfo, BuildContext context) {
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
        DataCell(Text(fileInfo.nic!)),
        DataCell(Text(fileInfo.address!)),
        DataCell(
          Text(fileInfo.dob!),
        ),
        DataCell(
          Text(fileInfo.phone!),
        ),
        DataCell(
          Text(fileInfo.status!),
        ),
        DataCell(ElevatedButton(
          child: Text("More"),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => DonorProfileScreen()));
          },
        )),
      ],
    );
  }
}
