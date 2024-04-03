
import 'package:ahmet_uygun_eindproject/firebase/firebase_functions.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateActivity extends StatefulWidget {
  const CreateActivity({super.key});

  @override
  CreateForm createState() => CreateForm();
}

class CreateForm extends State<CreateActivity> {
  String type = 'Running Training';
  DateTime selectedDate = DateTime.now();
  int duration = 30;
  int intensity = 7;

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.all(10),
          child: Form(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Create an activity',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  const SizedBox(height: 30),
                  DropdownButtonFormField(
                    decoration: const InputDecoration(
                      labelText: 'Type',
                    ),
                    value: type,
                    items: const [
                      DropdownMenuItem(
                          value: 'Running Training', child: Text('Running')),
                      DropdownMenuItem(
                          value: 'Swimming Training', child: Text(' Swimming')),
                      DropdownMenuItem(
                          value: 'Bike Training', child: Text('Bike')),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Choose an activity';
                      }
                      return null;
                    },
                    onChanged: (String? value) {
                      setState(() {
                        type = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  DateTimeFormField(
                    decoration: const InputDecoration(
                      labelText: 'Enter Date',
                    ),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2030),
                    initialPickerDateTime: DateTime.now(),
                    validator: (value) {
                      if (value == null) {
                        return 'Choose an date';
                      }
                      return null;
                    },
                    onChanged: (DateTime? value) {
                      selectedDate = value!;
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    decoration:
                        const InputDecoration(labelText: 'Duration(min)'),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field could not be blank';
                      }
                      return null;
                    },
                    onChanged: (String? value) {
                      setState(() {
                        duration = int.parse(value!);
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField(
                    decoration: const InputDecoration(
                      labelText: 'Intensity',
                    ),
                    value: intensity,
                    items: const [
                      DropdownMenuItem(
                          value: 5, child: Text('Light')),
                      DropdownMenuItem(
                          value: 7, child: Text('Moderate')),
                      DropdownMenuItem(
                          value: 9, child: Text('Vigorous')),
                    ],
                    validator: (value) {
                      if (value == null) {
                        return 'Choose an intensity';
                      }
                      return null;
                    },
                    onChanged: (int? value) {
                      setState(() {
                        intensity = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text(
                          'Close',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.greenAccent),
                          onPressed: () => {
                            createActivity(type, selectedDate, duration,intensity),
                                Navigator.of(context).pop()
                              },
                          child: const Text(
                            'Submit',
                            style: TextStyle(color: Colors.white),
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
