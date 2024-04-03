import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../pages/Summary.dart';

class MonthlyBarData {
  final double firstWeekAmount;
  final double secondWeekAmount;
  final double thirdWeekAmount;
  final double fourthWeekAmount;

  MonthlyBarData(
      {required this.firstWeekAmount,
      required this.secondWeekAmount,
      required this.thirdWeekAmount,
      required this.fourthWeekAmount});

  List<IndividualBar> barData = [];

  void initializedBarData() {
    barData = [
      IndividualBar(x: 0, y: firstWeekAmount),
      IndividualBar(x: 1, y: secondWeekAmount),
      IndividualBar(x: 2, y: thirdWeekAmount),
      IndividualBar(x: 3, y: fourthWeekAmount),
    ];
  }
}

class MonthlyBarGraph extends StatelessWidget {
  final List monthlyActivities;

  const MonthlyBarGraph({super.key, required this.monthlyActivities});

  @override
  Widget build(BuildContext context) {
    double calculateCalorie(int intensity, int duration) {
      return (intensity * 3.5 * 67 * duration) / 200;
    }

    DateTime firstWeekPeriod =
        DateTime.now().subtract(const Duration(days: 28));
    DateTime secondWeekPeriod =
        DateTime.now().subtract(const Duration(days: 21));
    DateTime thirdWeekPeriod =
        DateTime.now().subtract(const Duration(days: 14));
    DateTime lastWeekPeriod = DateTime.now().subtract(const Duration(days: 7));

    double firstWeekCalorie = 0;
    double secondWeekCalorie = 0;
    double thirdWeekCalorie = 0;
    double fourthWeekCalorie = 0;

    for (var a in monthlyActivities) {

      DateTime activityDate = (a.data()['date'] as Timestamp).toDate();

      if (activityDate.isAfter(firstWeekPeriod) && activityDate.isBefore(secondWeekPeriod) ) {
        firstWeekCalorie += calculateCalorie(a.data()['intensity'], a.data()['duration']);
      } else if (activityDate.isAfter(secondWeekPeriod) && activityDate.isBefore(thirdWeekPeriod)) {
        secondWeekCalorie += calculateCalorie(a.data()['intensity'], a.data()['duration']);
      } else if (activityDate.isAfter(thirdWeekPeriod) && activityDate.isBefore(lastWeekPeriod)) {
        thirdWeekCalorie += calculateCalorie(a.data()['intensity'], a.data()['duration']);
      } else if (activityDate.isAfter(lastWeekPeriod)) {
        fourthWeekCalorie += calculateCalorie(a.data()['intensity'], a.data()['duration']);
      }

    }

    MonthlyBarData myBarData = MonthlyBarData(
        firstWeekAmount: firstWeekCalorie,
        secondWeekAmount: secondWeekCalorie,
        thirdWeekAmount: thirdWeekCalorie,
        fourthWeekAmount: fourthWeekCalorie);

    myBarData.initializedBarData();

    return BarChart(BarChartData(
      maxY: 3000,
      minY: 600,
      gridData: const FlGridData(
        show: false,
      ),
      borderData: FlBorderData(show: false),
      titlesData: FlTitlesData(
          show: true,
          topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                  showTitles: true, getTitlesWidget: getBottomTitles)
          )
      ),
      barGroups: myBarData.barData
          .map(
            (data) => BarChartGroupData(
              x: data.x,
              barRods: [
                BarChartRodData(
                  toY: data.y,
                  color: Colors.grey[800],
                  width: 25,
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            ),
          )
          .toList(),
    ));
  }

  Widget getBottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(
        color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 14);

    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text(
          'First',
          style: style,
        );
        break;
      case 1:
        text = const Text(
          'Second ',
          style: style,
        );
        break;
      case 2:
        text = const Text(
          'Third',
          style: style,
        );
        break;
      case 3:
        text = const Text(
          'Fourth',
          style: style,
        );
        break;

      default:
        text = const Text(
          "",
          style: style,
        );
        break;
    }
    return SideTitleWidget(axisSide: meta.axisSide, child: text);
  }
}
