import 'package:ahmet_uygun_eindproject/Activity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final docActivity = FirebaseFirestore.instance.collection('activities');

Future createActivity(
    String type, DateTime date, int duration, int intensity) async {

  bool done = !date.isAfter(DateTime.now());

  final activity = Activity(
      id: "",
      date: date,
      type: type,
      duration: duration,
      intensity: intensity,
      done: done);

  final json = activity.toJson();

  await docActivity.add(json);
}

Future<void> updateActivity(String activityId) async {
  try{
    await docActivity
        .doc(activityId)
        .update({'done': true,'date' : DateTime.now()});
  }
  catch(e) {
    print('Error updation activity: $e');

  }

}


Future<void> deleteActivity(String activityId) async {
  try {
    await docActivity.doc(activityId).delete();
    print('Activity deleted successfully');
  } catch (e) {
    print('Error deleting activity: $e');
  }
}

Future<List<Activity>> readActivity() async {
  final docActivity = FirebaseFirestore.instance.collection('activities');
  List<Activity> activities = [];

  await docActivity.get().then((event) {
    for (var doc in event.docs) {
      activities.add(Activity(
          id: doc.id,
          date: doc.data()['date'].toDate() as DateTime,
          type: doc.data()['type'] as String,
          duration: doc.data()['duration'] as int,
          intensity: doc.data()['intensity'] as int,
          done: doc.data()['done'] as bool));
    }
  });
  return activities;
}


