// ignore_for_file: camel_case_types, prefer_const_constructors

import 'package:flutter/material.dart';

class SELECT_DATE extends StatefulWidget {
  const SELECT_DATE({Key? key}) : super(key: key);



  @override
  State<SELECT_DATE> createState() => _SELECT_DATEState();


}

class _SELECT_DATEState extends State<SELECT_DATE> {


  String date = "04 May 2022";

  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        selectDate(context);
        print("click");
      },
      child: Text(
        "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
        style: TextStyle(
          fontSize: 16,
        ),
      ),

    );
  }

  selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
      helpText: "Select Fake Date",
      initialEntryMode: DatePickerEntryMode.calendar,
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
      });
    }
  }
}

