import 'package:ahmet_uygun_eindproject/firebase/firebase_functions.dart';
import 'package:ahmet_uygun_eindproject/widget/activity_detail_card.dart';
import 'package:flutter/material.dart';

class ActivityCard extends StatefulWidget {
  const ActivityCard(
      {super.key,
      required this.id,
      required this.date,
      required this.type,
      required this.duration,
      required this.index,
      required this.intensity,
      required this.done});

  final String id;
  final DateTime date;
  final String type;
  final int duration;
  final int index;
  final int intensity;
  final bool done;

  @override
  Card createState() => Card();
}

class Card extends State<ActivityCard> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: _buildConditionalTrailing(widget.done),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: Colors.black)),
      onTap: () {
        showDialog(
            context: context,
            builder: (context) => ActivityCardDetail(
                  id: widget.id,
                  date: widget.date,
                  type: widget.type,
                  duration: widget.duration,
                  intensity: widget.intensity,
                  done: widget.done,
                ));
      },
      leading: Builder(
        builder: (context) {
          if (widget.type == 'Swimming Training') {
            return const Icon(
              Icons.pool_outlined,
              color: Colors.black,
            );
          }
          if (widget.type == 'Running Training') {
            return const Icon(
              Icons.directions_run_outlined,
              color: Colors.black,
            );
          } else {
            return const Icon(
              Icons.directions_bike_outlined,
              color: Colors.black,
            );
          }
        },
      ),
      title: Text(
        '${dayToString(widget.date.weekday)} ${timeToString(widget.date.hour)} ',
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        '${widget.type} ~ ${widget.duration.toString()} min',
        style: const TextStyle(fontWeight: FontWeight.w700),
      ),
    );
  }

  String dayToString(int dayInt) {
    dynamic day;
    switch (dayInt) {
      case 1:
        day = 'Monday';
        break;
      case 2:
        day = 'Tuesday';
        break;
      case 3:
        day = 'Wednesday';
        break;
      case 4:
        day = 'Thursday';
        break;
      case 5:
        day = 'Friday';
        break;
      case 6:
        day = 'Saturday';
        break;
      default:
        day = 'Sunday';
    }
    return day;
  }

  String timeToString(int hour) {
    dynamic time;
    if (hour >= 0 && hour < 6) {
      time = 'Night';
    }
    if (hour >= 6 && hour < 12) {
      time = 'Morning';
    }
    if (hour >= 12 && hour < 17) {
      time = 'Afternoon';
    }
    if (hour >= 17 && hour <= 23) {
      time = 'Evening';
    }
    return time;
  }

  Widget _buildConditionalTrailing(bool condition) {
    return condition
        ? const Icon(Icons.check_circle, color: Colors.green)
        : IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Close')),
                    TextButton(
                        onPressed: () {
                          updateActivity(widget.id);
                          Navigator.of(context).pop();
                        },
                        child: const Text('Done ✅')),
                  ],
                  title: const Text('WELL DONE'),
                  content: const Text('We knew that you can do it!'),
                  contentPadding: const EdgeInsets.all(20.0),
                ),
              );
            },
            icon: const Icon(
              Icons.check_circle_outlined,
              color: Colors.green,
            ));
  }
}
