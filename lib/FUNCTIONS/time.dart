// ignore_for_file: camel_case_types, prefer_const_constructors

import 'package:flutter/material.dart';

class SELECT_TIME extends StatefulWidget {
  const SELECT_TIME({Key? key}) : super(key: key);

  @override
  State<SELECT_TIME> createState() => _SELECT_TIMEState();
}

class _SELECT_TIMEState extends State<SELECT_TIME> {

  String time = "11:15";
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return    GestureDetector(
      onTap: () {
        selectTime(context);
      },
      child: Text(
        "${selectedTime.hour}:${selectedTime.minute}",
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }
  selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      helpText: "Select Fake Time",
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        selectedTime = timeOfDay;
      });
    }
  }
}

