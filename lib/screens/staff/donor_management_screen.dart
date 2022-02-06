import 'package:blood_donor_web_admin/constants/constants.dart';
import 'package:blood_donor_web_admin/widgets/app_input_field.dart';
import 'package:blood_donor_web_admin/widgets/q&a_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
class DonorManagementScreen extends StatefulWidget {
  @override
  _DonorManagementScreenState createState() => _DonorManagementScreenState();
}

class _DonorManagementScreenState extends State<DonorManagementScreen> {

  int counter = 0;
  bool verified = false;
  bool feelingWell = false;
  bool isSleep = false;
  bool lastMeal = false;
  bool hospitalised = false;
  bool allergies = false;
  bool riskBehaviours = false;
  bool deferral = false;

  TextEditingController barcodeController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController bloodGroupController = TextEditingController();
  TextEditingController cvsStatusController = TextEditingController();
  TextEditingController bpController = TextEditingController();
  TextEditingController deferralController = TextEditingController();
  TextEditingController rematksController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(

        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Constants.appColorBrownRed,Constants.appColorBrownRedLight],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 10.0,),
                        CircleAvatar(
                          radius: 65.0,
                          backgroundImage: AssetImage('assets/images/profile.jpg'),
                          backgroundColor: Colors.white,
                        ),
                        SizedBox(width: 10.0,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Vinod Madhushan',
                                style: TextStyle(
                                  color:Colors.white,
                                  fontSize: 20.0,
                                )),
                            SizedBox(height: 10.0,),
                            Text('No1 ,lane 5 ,Maharagama',
                              style: TextStyle(
                                color:Colors.white,
                                fontSize: 15.0,
                              ),),

                            SizedBox(height: 10.0,),

                            Text('071-1234567',
                              style: TextStyle(
                                color:Colors.white,
                                fontSize: 15.0,
                              ),)
                          ],
                        )
                      ]
                  ),
                ),
                SizedBox(height: 10,),
                Card(
                    child: Padding(
                      padding:EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                              child:Column(
                                children: [
                                  Text('Group',
                                    style: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 14.0
                                    ),),
                                  SizedBox(height: 5.0,),
                                  Text("A+",
                                    style: TextStyle(
                                      fontSize: 15.0,
                                    ),)
                                ],
                              )
                          ),

                          Container(
                            child: Column(
                                children: [
                                  Text('Birthday',
                                    style: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 14.0
                                    ),),
                                  SizedBox(height: 5.0,),
                                  Text('04/12/1997',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                    ),)
                                ]),
                          ),
                          Container(
                            child: Column(
                                children: [
                                  Text('NIC',
                                    style: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 14.0
                                    ),),
                                  SizedBox(height: 5.0,),
                                  Text('972000272V',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                    ),)
                                ]),
                          ),

                          Container(
                              child:Column(
                                children: [
                                  Text('Number of Donations',
                                    style: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 14.0
                                    ),),
                                  SizedBox(height: 5.0,),
                                  Text('04',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                    ),)
                                ],
                              )
                          ),

                          Container(
                              child:Column(
                                children: [
                                  Text('Last Donations Date',
                                    style: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 14.0
                                    ),),
                                  SizedBox(height: 5.0,),
                                  Text('15/11/2021',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                    ),)
                                ],
                              )
                          ),
                        ],
                      ),
                    )
                ),
                Container(
                  width: double.infinity,
                  child: QAList()
                ),
                SizedBox(height: 20,),
                Text("Registration",style: TextStyle(color: Constants.appColorBrownRed,fontSize: 30),),
                SizedBox(height: 20,),

                Container(

                  width: MediaQuery.of(context).size.width * 0.75,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text("Donor name and ID card details are verified?"),
                              SizedBox(width: 10,),
                              Container(
                                child: FlutterSwitch(
                                  width: 60.0,
                                  height: 25.0,
                                  valueFontSize: 10.0,
                                  toggleSize: 20.0,
                                  value: verified,
                                  activeText: "Yes",
                                  activeColor: Constants.appColorBrownRed,
                                  inactiveText: "No",
                                  borderRadius: 20.0,
                                  padding: 8.0,
                                  showOnOff: true,
                                  onToggle: (val) {
                                    setState(() {
                                      verified = val;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(width: 50,),
                              Text("barcode"),
                              SizedBox(width: 10,),
                              SizedBox(
                                height: 45,
                                width: 200,
                                child: TextField(

                                  controller: barcodeController,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Constants.appColorBlack, fontSize: 14),
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                        color: Constants.appColorGray, fontSize: 14),
                                    hintText: "Barcode number",
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        color: Constants.appColorBrownRed,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        color: Constants.appColorGray,
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 20,),
                          Text("Medical assesment",style: TextStyle(color: Constants.appColorBrownRed,fontSize: 20)),
                          SizedBox(height: 20,),

                          Row(

                            children: [
                              Row(
                                children: [
                                  Text("Weight(Kg)"),
                                  SizedBox(width: 10,),
                                  SizedBox(
                                    height: 40,
                                    width: 100,
                                    child: TextField(

                                      controller: weightController,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Constants.appColorBlack, fontSize: 14),
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        hintStyle: TextStyle(
                                            color: Constants.appColorGray, fontSize: 14),

                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Constants.appColorBrownRed,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Constants.appColorGray,
                                            width: 1.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )

                                ],
                              ),
                              SizedBox(width: 50,),
                              Row(
                                children: [
                                  Text("Blood Group"),
                                  SizedBox(width: 10,),
                                  SizedBox(
                                    height: 40,
                                    width: 100,
                                    child: TextField(

                                      controller: bloodGroupController,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Constants.appColorBlack, fontSize: 14),
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        hintStyle: TextStyle(
                                            color: Constants.appColorGray, fontSize: 14),

                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Constants.appColorBrownRed,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Constants.appColorGray,
                                            width: 1.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )

                                ],
                              ),
                            ],
                          ),

                          SizedBox(height: 20,),
                          Text("history",style: TextStyle(color: Constants.appColorGray,fontSize: 18),),
                          SizedBox(height: 20,),

                          Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      SizedBox(height: 50,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Feling well?"),
                                          SizedBox(width: 10,),
                                          Container(
                                            child: FlutterSwitch(
                                              width: 60.0,
                                              height: 25.0,
                                              valueFontSize: 10.0,
                                              toggleSize: 20.0,
                                              value: feelingWell,
                                              activeColor: Constants.appColorBrownRed,
                                              activeText: "Yes",
                                              inactiveText: "No",
                                              borderRadius: 20.0,
                                              padding: 8.0,
                                              showOnOff: true,
                                              onToggle: (val) {
                                                setState(() {
                                                  feelingWell = val;
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 20,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Last meal (<4hrs)?"),
                                          SizedBox(width: 10,),
                                          Container(
                                            child: FlutterSwitch(
                                              width: 60.0,
                                              height: 25.0,
                                              valueFontSize: 10.0,
                                              toggleSize: 20.0,
                                              value: lastMeal,
                                              activeColor: Constants.appColorBrownRed,
                                              activeText: "Yes",
                                              inactiveText: "No",
                                              borderRadius: 20.0,
                                              padding: 8.0,
                                              showOnOff: true,
                                              onToggle: (val) {
                                                setState(() {
                                                  lastMeal = val;
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 20,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Any Allergies or medications?"),
                                          SizedBox(width: 10,),
                                          Container(
                                            child: FlutterSwitch(
                                              width: 60.0,
                                              height: 25.0,
                                              valueFontSize: 10.0,
                                              toggleSize: 20.0,
                                              value: allergies,
                                              activeColor: Constants.appColorBrownRed,
                                              activeText: "Yes",
                                              inactiveText: "No",
                                              borderRadius: 20.0,
                                              padding: 8.0,
                                              showOnOff: true,
                                              onToggle: (val) {
                                                setState(() {
                                                  allergies = val;
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 50,),

                                      Row(
                                        children: [
                                          Row(
                                            children: [
                                              Text("CVS status pulse"),
                                              SizedBox(width: 10,),
                                              SizedBox(
                                                height: 40,
                                                width: 100,
                                                child: TextField(

                                                  controller: cvsStatusController,
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      color: Constants.appColorBlack, fontSize: 14),
                                                  keyboardType: TextInputType.text,
                                                  decoration: InputDecoration(
                                                    hintStyle: TextStyle(
                                                        color: Constants.appColorGray, fontSize: 14),

                                                    focusedBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(10.0),
                                                      borderSide: BorderSide(
                                                        color: Constants.appColorBrownRed,
                                                      ),
                                                    ),
                                                    enabledBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(10.0),
                                                      borderSide: BorderSide(
                                                        color: Constants.appColorGray,
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )

                                            ],
                                          ),
                                          SizedBox(width: 50,),
                                          Row(
                                            children: [
                                              Text("BP"),
                                              SizedBox(width: 10,),
                                              SizedBox(
                                                height: 40,
                                                width: 100,
                                                child: TextField(

                                                  controller: bpController,
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      color: Constants.appColorBlack, fontSize: 14),
                                                  keyboardType: TextInputType.text,
                                                  decoration: InputDecoration(
                                                    hintStyle: TextStyle(
                                                        color: Constants.appColorGray, fontSize: 14),

                                                    focusedBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(10.0),
                                                      borderSide: BorderSide(
                                                        color: Constants.appColorBrownRed,
                                                      ),
                                                    ),
                                                    enabledBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(10.0),
                                                      borderSide: BorderSide(
                                                        color: Constants.appColorGray,
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )

                                            ],
                                          ),
                                        ],
                                      )



                                    ],
                                  )
                              ),
                              SizedBox(width: 40,),
                              Expanded(
                                  flex: 1,
                                  child: Column(

                                    children: [

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Adequate overnight sleep?(>6hrs)"),
                                          SizedBox(width: 10,),
                                          Container(
                                            child: FlutterSwitch(
                                              width: 60.0,
                                              height: 25.0,
                                              valueFontSize: 10.0,
                                              toggleSize: 20.0,
                                              value: isSleep,
                                              activeColor: Constants.appColorBrownRed,
                                              activeText: "Yes",
                                              inactiveText: "No",
                                              borderRadius: 20.0,
                                              padding: 8.0,
                                              showOnOff: true,
                                              onToggle: (val) {
                                                setState(() {
                                                  isSleep = val;
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 20,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Ever Hospitalised?"),
                                          SizedBox(width: 10,),
                                          Container(
                                            child: FlutterSwitch(
                                              width: 60.0,
                                              height: 25.0,
                                              valueFontSize: 10.0,
                                              toggleSize: 20.0,
                                              value: hospitalised,
                                              activeColor: Constants.appColorBrownRed,
                                              activeText: "Yes",
                                              inactiveText: "No",
                                              borderRadius: 20.0,
                                              padding: 8.0,
                                              showOnOff: true,
                                              onToggle: (val) {
                                                setState(() {
                                                  hospitalised = val;
                                                });
                                              },
                                            ),
                                          ),

                                        ],
                                      ),
                                      SizedBox(height: 20,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("High risk behaviours?"),
                                          SizedBox(width: 10,),
                                          Container(
                                            child: FlutterSwitch(
                                              width: 60.0,
                                              height: 25.0,
                                              valueFontSize: 10.0,
                                              toggleSize: 20.0,
                                              value: riskBehaviours,
                                              activeColor: Constants.appColorBrownRed,
                                              activeText: "Yes",
                                              inactiveText: "No",
                                              borderRadius: 20.0,
                                              padding: 8.0,
                                              showOnOff: true,
                                              onToggle: (val) {
                                                setState(() {
                                                  riskBehaviours = val;
                                                });
                                              },
                                            ),
                                          ),

                                        ],
                                      ),
                                      SizedBox(height: 20,),


                                    ],
                                  )
                              )
                            ],
                          ),

                          SizedBox(height: 20,),

                          Row(

                            children: [
                              Text("Deferral?"),
                              SizedBox(width: 10,),
                              Container(
                                child: FlutterSwitch(
                                  width: 60.0,
                                  height: 25.0,
                                  valueFontSize: 10.0,
                                  toggleSize: 20.0,
                                  value: deferral,
                                  activeColor: Constants.appColorBrownRed,
                                  activeText: "Yes",
                                  inactiveText: "No",
                                  borderRadius: 20.0,
                                  padding: 8.0,
                                  showOnOff: true,
                                  onToggle: (val) {
                                    setState(() {
                                      deferral = val;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 20,),

                          Visibility(
                            visible: deferral,
                            child: Row(
                              children: [
                                Text("Reasons for deferral"),
                                SizedBox(width: 10,),
                                SizedBox(
                                  height: 40,
                                  width: 300,
                                  child: TextField(

                                    controller: deferralController,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Constants.appColorBlack, fontSize: 14),
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintStyle: TextStyle(
                                          color: Constants.appColorGray, fontSize: 14),

                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                          color: Constants.appColorBrownRed,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                          color: Constants.appColorGray,
                                          width: 1.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                )

                              ],
                            ),
                          ),
                          SizedBox(height: 20,),

                          Row(
                            children: [
                              Text("Remarks"),
                              SizedBox(width: 10,),
                              SizedBox(
                                height: 40,
                                width: 300,
                                child: TextField(

                                  controller: rematksController,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Constants.appColorBlack, fontSize: 14),
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                        color: Constants.appColorGray, fontSize: 14),

                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        color: Constants.appColorBrownRed,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        color: Constants.appColorGray,
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                ),
                              )

                            ],
                          ),

                          SizedBox(height: 20,),

                          Row(
                            children: [
                              Visibility(
                                  child: ElevatedButton(onPressed: (){print("Accepted");}, child: Text("Accept")),
                                visible: !deferral,
                              ),
                              SizedBox(width: 20,),
                              ElevatedButton(
                                  onPressed: (){print("Reject");},
                                  child: Text("Reject"),
                                  style: ElevatedButton.styleFrom(
                                    primary: !deferral ? Constants.appColorGray : Constants.appColorBrownRed
                                  )
                              )
                            ],
                          )


                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 500,)
              ],
            ),
          ],

        ),
      ),
    );
  }
}