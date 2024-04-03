class Activity {
  final String id;

  final DateTime date;
  final String type;
  final int duration;
  final int intensity;
  final bool done;

  Activity(
      {required this.id,
      required this.date,
      required this.type,
      required this.duration,
      required this.intensity,
      required this.done});

  Map<String, dynamic> toJson() => {
        'date': date,
        'type': type,
        'duration': duration,
        'intensity': intensity,
        'done': done,
      };
}
