import 'package:ahmet_uygun_eindproject/widget/activity_overview_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widget/monthly_chart.dart';
import '../widget/weekly_chart.dart';

class SummaryPage extends StatefulWidget {
  const SummaryPage({super.key});

  @override
  _SummaryPage createState() => _SummaryPage();
}

class IndividualBar {
  final int x;
  final double y;

  IndividualBar({required this.x, required this.y});
}

class _SummaryPage extends State<SummaryPage> {
  int selectedControl = 0;

  Map<dynamic, Widget> children = <dynamic, Widget>{
    0: const Text(
      'Week',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    1: const Text(
      'Month',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
  };

  DateTime weeklyPeriod = DateTime.now().subtract(const Duration(days: 7));
  DateTime monthlyPeriod = DateTime.now().subtract(const Duration(days: 30));
  DateTime yearlyPeriod = DateTime.now().subtract(const Duration(days: 365));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Summary',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.green[700],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('activities').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          List<QueryDocumentSnapshot> activities = [];
          Map<String, int> weeklyActivitiesSummary = {};
          Map<String, int> monthlyActivitiesSummary = {};

          if (selectedControl == 0) {
            activities = snapshot.data!.docs.where((doc) {
              DateTime activityDate = (doc['date'] as Timestamp).toDate();
              bool done = (doc['done'] as bool == true);
              return activityDate.isAfter(weeklyPeriod) && done;
            }).toList();

            for (var a in activities) {
              weeklyActivitiesSummary.update(
                  a['type'], (value) => a['duration'] + value,
                  ifAbsent: () => a['duration']);
            }
          }
          if (selectedControl == 1) {
            activities = snapshot.data!.docs.where((doc) {
              DateTime activityDate = (doc['date'] as Timestamp).toDate();
              bool done = (doc['done'] as bool == true);
              return activityDate.isAfter(monthlyPeriod) && done;
            }).toList();

            for (var a in activities) {
              monthlyActivitiesSummary.update(
                  a['type'], (value) => a['duration'] + value,
                  ifAbsent: () => a['duration']);
            }
          }

          return Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Center(
                    child: CupertinoSlidingSegmentedControl(
                      groupValue: selectedControl,
                      children: children,
                      padding: const EdgeInsets.all(10),
                      onValueChanged: (value) {
                        setState(() {
                          selectedControl = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  selectedControl == 0
                      ? Column(
                          children: <Widget>[
                            const Text(
                              "Overview of burned calories",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                                height: 200,
                                child: WeeklyBarGraph(
                                    weeklyActivities: activities)),
                            const SizedBox(
                              height: 30,
                            ),
                            const Text(
                              "Overview of Activities",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 20,
                            ),

                            ListView.separated(
                                shrinkWrap: true,
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        const SizedBox(
                                          height: 12,
                                        ),
                                padding: const EdgeInsets.all(8.0),
                                itemCount: weeklyActivitiesSummary.length,
                                itemBuilder: (BuildContext context, int index) {
                                  String key = weeklyActivitiesSummary.keys.elementAt(index);
                                  return ActivityOverviewCard(type: key, duration: weeklyActivitiesSummary[key]!);

                                }),

                            // Container(child: Text("here"))
                          ],
                        )
                      :
                  Column(
                    children: <Widget>[
                      const Text(
                        "Overview of burned calories",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                          height: 200,
                          child: MonthlyBarGraph(
                              monthlyActivities: activities)),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        "Overview of Activities",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder:
                              (BuildContext context, int index) =>
                          const SizedBox(
                            height: 12,
                          ),
                          padding: const EdgeInsets.all(8.0),
                          itemCount: monthlyActivitiesSummary.length,
                          itemBuilder: (BuildContext context, int index) {
                            String key = monthlyActivitiesSummary.keys.elementAt(index);
                            return ActivityOverviewCard(type: key, duration: monthlyActivitiesSummary[key]!);

                          }),

                      // Container(child: Text("here"))
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ));
        },
      ),
    );
  }
}
