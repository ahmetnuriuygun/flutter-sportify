import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import '../widget/activity_card.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  _ActivityPage createState() => _ActivityPage();
}

class _ActivityPage extends State<ActivityPage> {
  int selectedControl = 0;

  @override
  void initState(){
    super.initState();

  }

  Map<dynamic, Widget> children = <dynamic, Widget>{
    0: const Text(
      'Week',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    1: const Text(
      'Month',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    2: const Text(
      'Year',
      style: TextStyle(fontWeight: FontWeight.bold),
    )
  };

  DateTime weeklyPeriod = DateTime.now().subtract(const Duration(days: 7));
  DateTime monthlyPeriod = DateTime.now().subtract(const Duration(days: 30));
  DateTime yearlyPeriod = DateTime.now().subtract(const Duration(days: 365));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Activities',
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

          List<QueryDocumentSnapshot> filteredDocs = [];
          if (selectedControl == 0) {
            filteredDocs = snapshot.data!.docs.where((doc) {
              DateTime activityDate = (doc['date'] as Timestamp).toDate();
              bool done = (doc['done'] as bool == true);
              return activityDate.isAfter(weeklyPeriod) && done;
            }).toList();
          } else if (selectedControl == 1) {
            filteredDocs = snapshot.data!.docs.where((doc) {
              DateTime activityDate = (doc['date'] as Timestamp).toDate();
              bool done = (doc['done'] as bool == true);

              return activityDate.isAfter(monthlyPeriod) &&
                  activityDate.isBefore(weeklyPeriod) &&
                  done;
            }).toList();
          } else {
            filteredDocs = snapshot.data!.docs.where((doc) {
              DateTime activityDate = (doc['date'] as Timestamp).toDate();
              bool done = (doc['done'] as bool == true);

              return activityDate.isAfter(yearlyPeriod) &&
                  activityDate.isBefore(monthlyPeriod) &&
                  done;
            }).toList();
          }

          return SafeArea(
            child: Container(
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
                  Expanded(
                    child: ListView.separated(
                        separatorBuilder: (BuildContext context, int index) =>
                            SizedBox(height: 12.0),
                        // Adjust the height as needed
                        padding: EdgeInsets.all(8.0),
                        itemCount: filteredDocs.length,
                        itemBuilder: (BuildContext context, int index) {
                          var doc = filteredDocs[index];
                          return ActivityCard(
                            id: doc.id,
                            date: (doc['date'] as Timestamp).toDate(),
                            type: doc['type'],
                            duration: doc['duration'],
                            index: index,
                            intensity: doc['intensity'],
                            done: doc['done'],
                          );
                        }),
                  ),

                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
