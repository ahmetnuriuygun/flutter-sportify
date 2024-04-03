import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActivityOverviewCard extends StatefulWidget{
  const ActivityOverviewCard({super.key,required this.type,required this.duration});

  final String type;
  final int duration;
  @override
  OverviewCard createState() => OverviewCard();
}

class OverviewCard extends State<ActivityOverviewCard>{
  @override
  Widget build(BuildContext context){
    return ListTile(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: Colors.black)),
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
        '${widget.type} ~ ${widget.duration~/60} hour ${widget.duration%60} min',
        style: const TextStyle(fontWeight: FontWeight.w700),
      ),
    );
  }
}