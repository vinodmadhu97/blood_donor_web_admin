import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';

class Chart extends StatelessWidget {
  final double aCount;
  final double bCount;
  final double abCount;
  final double oCount;
  final int totalRequest;
  final int completedRequest;
  Chart(
      {Key? key,
      required this.abCount,
      required this.bCount,
      required this.aCount,
      required this.oCount,
      required this.completedRequest,
      required this.totalRequest})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Stack(
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: 120,
              startDegreeOffset: -90,
              sections: [
                PieChartSectionData(
                  color: Color(0xffff2400),
                  value: aCount,
                  showTitle: false,
                  radius: 25,
                ),
                PieChartSectionData(
                  color: Color(0xFFFFA113),
                  value: bCount,
                  showTitle: false,
                  radius: 25,
                ),
                PieChartSectionData(
                  color: Color(0xFF800000),
                  value: abCount,
                  showTitle: false,
                  radius: 25,
                ),
                PieChartSectionData(
                  color: Color(0xFF007EE5),
                  value: oCount,
                  showTitle: false,
                  radius: 25,
                ),
                PieChartSectionData(
                  color: Colors.grey.withOpacity(0.1),
                  showTitle: false,
                  radius: 25,
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: Constants.defaultPadding),
                Text(
                  "$completedRequest",
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: Constants.appColorBrownRed,
                        fontWeight: FontWeight.w600,
                        height: 0.5,
                      ),
                ),
                Text("Success of $totalRequest Donations")
              ],
            ),
          ),
        ],
      ),
    );
  }
}
