import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../firebase/firebase_functions.dart';

class ActivityCardDetail extends StatefulWidget {
  const ActivityCardDetail(
      {super.key,
      required this.id,
      required this.date,
      required this.type,
      required this.duration,
      required this.intensity,
      required this.done});

  final String id;
  final DateTime date;
  final String type;
  final int duration;
  final int intensity;
  final bool done;

  @override
  CardDetail createState() => CardDetail();
}

class CardDetail extends State<ActivityCardDetail> {
  double calculateCalorie(int intensity, int duration) {
    return (intensity * 3.5 * 67 * duration) / 200;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: _buildConditionalImage(widget.type),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.7), BlendMode.darken))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Text('${widget.type}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    )),
                const SizedBox(
                  height: 30,
                ),
                Text(
                    'Date : ${widget.date.toString().split(" ")[0].split("-")[1]} / ${widget.date.toString().split(" ")[0].split("-")[2]} / ${widget.date.toString().split(" ")[0].split("-")[0]}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    )),
                const SizedBox(
                  height: 30,
                ),
                Text('Duration : ${widget.duration} minutes',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    )),
                const SizedBox(
                  height: 30,
                ),
                Text.rich(TextSpan(children: [
                  TextSpan(
                      text: 'Intensity: ',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  WidgetSpan(
                    child: Icon(Icons.align_vertical_bottom,
                        color: Colors.green,
                        size: widget.intensity == 5 ? 38.0 : 18.0),
                  ),
                  WidgetSpan(
                    child: Icon(Icons.align_vertical_bottom,
                        color: Colors.orange,
                        size: widget.intensity == 7 ? 38.0 : 18.0),
                  ),
                  WidgetSpan(
                    child: Icon(Icons.align_vertical_bottom,
                        color: Colors.red,
                        size: widget.intensity == 9 ? 38.0 : 18.0),
                  )
                ])),
                const SizedBox(
                  height: 30,
                ),
                Text.rich(TextSpan(children: [
                  TextSpan(
                      text:
                          'Calorie Burned: ${calculateCalorie(widget.intensity, widget.duration).toStringAsFixed(2)} ',
                      style:
                          const TextStyle(color: Colors.white, fontSize: 20)),
                ])),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
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
                                    deleteActivity(widget.id);
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Delete')),
                            ],
                            title: const Text('Delete Activity'),
                            contentPadding: const EdgeInsets.all(20.0),
                          ),
                        );
                      },
                      child: const Text(
                        'Delete',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey),
                        onPressed: () => {Navigator.of(context).pop()},
                        child: const Text(
                          'Close',
                          style: TextStyle(color: Colors.white),
                        )),
                  ],
                )
              ],
            )));
  }

  int buildConditionalIntensitivyIcon(intensity) {
    return 5;
  }

  AssetImage _buildConditionalImage(String type) {
    AssetImage imageBackground;
    switch (type) {
      case 'Running Training':
        imageBackground = const AssetImage("assets/images/run.jpg");
      case "Swimming Training":
        imageBackground = const AssetImage("assets/images/swim.jpg");
      default:
        imageBackground = const AssetImage("assets/images/bike.jpg");
    }
    return imageBackground;
  }
}
