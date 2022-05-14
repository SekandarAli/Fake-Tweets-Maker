// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class PreviousData extends StatelessWidget {
  const PreviousData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final savedProfileName =
        ModalRoute.of(context)!.settings.arguments.toString();

    return Scaffold(
      appBar: AppBar(
          title: Text("Previous Data")),
      body: Center(
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              savedProfileName,
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
