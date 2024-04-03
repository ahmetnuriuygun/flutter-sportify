import 'package:cloud_firestore/cloud_firestore.dart';
import '../pages/Summary.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class WeeklyBarData {
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thurAmount;
  final double friAmount;
  final double satAmount;
  final double sunAmount;

  WeeklyBarData(
      {required this.monAmount,
      required this.tueAmount,
      required this.wedAmount,
      required this.thurAmount,
      required this.friAmount,
      required this.satAmount,
      required this.sunAmount});

  List<IndividualBar> barData = [];

  void initializedBarData() {
    barData = [
      IndividualBar(x: 0, y: monAmount),
      IndividualBar(x: 1, y: tueAmount),
      IndividualBar(x: 2, y: wedAmount),
      IndividualBar(x: 3, y: thurAmount),
      IndividualBar(x: 4, y: friAmount),
      IndividualBar(x: 5, y: satAmount),
      IndividualBar(x: 6, y: sunAmount),
    ];
  }
}

class WeeklyBarGraph extends StatelessWidget {
  final List weeklyActivities;

  const WeeklyBarGraph({super.key, required this.weeklyActivities});

  @override
  Widget build(BuildContext context) {

    Map<int, double> weeklySummary = {};

    double calculateCalorie(int intensity, int duration) {
      return (intensity * 3.5 * 67 * duration) / 200;
    }

    for (var a in weeklyActivities) {
      weeklySummary[(a.data()['date'] as Timestamp).toDate().weekday] = calculateCalorie(a.data()['intensity'], a.data()['duration']);
    }

    // for(var a in weeklyActivities){
    //   if(weeklyActivitiesSummary.containsKey((a.data()['type'] as String))){
    //     weeklyActivitiesSummary[(a.data()['type'] as String)] = a.data()['duration'] + weeklyActivitiesSummary[(a.data()['type'] as String)]! ;
    //
    //   }else{
    //     weeklyActivitiesSummary[(a.data()['type'] as String)] = a.data()['duration'] ;
    //
    //   }
    // }
    // for(var a in weeklyActivities){
    //   weeklyActivitiesSummary.update(a.data()['type'], (value) => a.data()['duration'] + value, ifAbsent: ()=> a.data()['duration']);
    // }


    // print(weeklyActivitiesSummary);

    WeeklyBarData myBarData = WeeklyBarData(
        monAmount: weeklySummary[1] == null ? 0 : weeklySummary[1]!,
        tueAmount: weeklySummary[2] == null ? 0 : weeklySummary[2]!,
        wedAmount: weeklySummary[3] == null ? 0 : weeklySummary[3]!,
        thurAmount: weeklySummary[4] == null ? 0 : weeklySummary[4]!,
        friAmount: weeklySummary[5] == null ? 0 : weeklySummary[5]!,
        satAmount: weeklySummary[6] == null ? 0 : weeklySummary[6]!,
        sunAmount: weeklySummary[7] == null ? 0 : weeklySummary[7]!);

    myBarData.initializedBarData();

    return


        BarChart(BarChartData(
        maxY: 1000,
        minY: 0,
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
                    showTitles: true, getTitlesWidget: getBottomTitles))),
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
      )
    );


  }

  Widget getBottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(
        color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 14);

    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text(
          'M',
          style: style,
        );
        break;
      case 1:
        text = const Text(
          'T',
          style: style,
        );
        break;
      case 2:
        text = const Text(
          'W',
          style: style,
        );
        break;
      case 3:
        text = const Text(
          'T',
          style: style,
        );
        break;
      case 4:
        text = const Text(
          'F',
          style: style,
        );
        break;
      case 5:
        text = const Text(
          'S',
          style: style,
        );
        break;
      case 6:
        text = const Text(
          'S',
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
