import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../widget/activity_card.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  _TodoPage createState() => _TodoPage();
}

class _TodoPage extends State<TodoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'To Do',
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
          filteredDocs = snapshot.data!.docs.where((doc) {
            bool toDo = (doc['done'] as bool == false);
            return toDo;
          }).toList();

          return SafeArea(
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                        separatorBuilder: (BuildContext context, int index) =>
                            SizedBox(height: 10.0),
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
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
