import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';

class Chart extends StatelessWidget {
  const Chart({
    Key? key,
  }) : super(key: key);

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
              sections: Constants().paiChartSelectionDatas,
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: Constants.defaultPadding),
                Text(
                  "330",
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: Constants.appColorBrownRed,
                        fontWeight: FontWeight.w600,
                        height: 0.5,
                      ),
                ),
                Text("of 350 Donations")
              ],
            ),
          ),
        ],
      ),
    );
  }
}
