import 'package:blood_donor_web_admin/constants/constants.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class DonorProfileDataList extends StatelessWidget {
  const DonorProfileDataList({
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
            Row(
              children: [
                Text("Donor ID : 5839483"),
                Spacer(
                  flex: 1,
                ),
                Text("NIC : 972000272v"),
                Spacer(
                  flex: 1,
                ),
                Text("DOB : 1997/07/18"),
                Spacer(
                  flex: 1,
                ),
                Text("Gender : Male"),
                Spacer(
                  flex: 1,
                ),
                Text("Last Donation Date : 2022/01/22"),
              ],
            ),
            /*Text(
              "Profile",
              style: Theme.of(context).textTheme.subtitle1,
            ),*/
            SizedBox(
              width: double.infinity,
              child: DataTable2(
                columnSpacing: Constants.defaultPadding,
                minWidth: 600,
                columns: [
                  DataColumn(
                    label: Text("Id"),
                  ),
                  DataColumn(
                    label: Text("Location"),
                  ),
                  DataColumn(
                    label: Text("Date"),
                  ),
                  DataColumn(
                    label: Text(""),
                  ),
                ],
                rows: List.generate(
                  Constants().bloodDonorsList[0].donationHistory!.length,
                  (index) => availableCampaignsDataRow(
                      Constants().bloodDonorsList[0].donationHistory![index],
                      context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  DataRow availableCampaignsDataRow(String fileInfo, BuildContext context) {
    return DataRow(
      cells: [
        DataCell(Text("campaign id")),
        DataCell(Text("campaign location")),
        DataCell(Text("date")),
        DataCell(ElevatedButton(
          child: Text("view"),
          onPressed: () {
            print("go to that specific history");
          },
        )),
      ],
    );
  }
}
