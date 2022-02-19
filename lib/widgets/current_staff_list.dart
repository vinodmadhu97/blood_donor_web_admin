import 'package:blood_donor_web_admin/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';

class CurrentStaffList extends StatelessWidget {
  const CurrentStaffList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseServices().getStaffCollection(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

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
                    "Staff Members",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: DataTable2(
                      columnSpacing: Constants.defaultPadding,
                      minWidth: 600,
                      columns: [
                        DataColumn(
                          label: Text("No"),
                        ),
                        DataColumn(
                          label: Text("Staff Id"),
                        ),
                        DataColumn(
                          label: Text("Name"),
                        ),
                        DataColumn(
                          label: Text("Email"),
                        ),
                        DataColumn(
                          label: Text("Phone"),
                        ),
                        DataColumn(
                          label: Text("Status"),
                        ),
                        DataColumn(
                          label: Text(""),
                        ),
                      ],
                      rows: List.generate(
                        snapshot.data!.docs.length,
                        (index) => currentStaffDataRow(
                            snapshot.data!.docs[index], context, index + 1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  DataRow currentStaffDataRow(
      QueryDocumentSnapshot snapshot, BuildContext context, int no) {
    return DataRow(
      cells: [
        DataCell(
          Text(no.toString()),
        ),
        DataCell(
          Text(snapshot['staffId']),
        ),
        DataCell(Text(snapshot['staffName'])),
        DataCell(Text(snapshot['staffEmail'])),
        DataCell(Text(snapshot['staffPhone'])),
        DataCell(Text(snapshot['enabled'] ? "Enabled" : "Disabled")),
        DataCell(ElevatedButton(
          child: Text(snapshot['enabled'] ? "Disable" : "Enable"),
          onPressed: () {
            //to disable
            if (snapshot['enabled']) {
              FirebaseServices().changeAvailabilityOfStaff(
                  snapshot['staffId'], snapshot['staffEmail'], context, true);
            } else {
              //to enable
              FirebaseServices().changeAvailabilityOfStaff(
                  snapshot['staffId'], snapshot['staffEmail'], context, false);
            }
          },
        )),
      ],
    );
  }
}
