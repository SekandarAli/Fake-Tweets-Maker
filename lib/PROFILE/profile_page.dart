// ignore_for_file: prefer_const_constructors

import 'package:fake_tweet/PROFILE/profile_commentbox.dart';
import 'package:fake_tweet/tweet.dart';
import 'package:flutter/material.dart';

import '../MODEL/data_model.dart';
import '../MODEL/profile_model.dart';
import '../WIDGETS/commentbox.dart';

class PROFILEPAGE extends StatefulWidget {
  const PROFILEPAGE({Key? key}) : super(key: key);

  @override
  State<PROFILEPAGE> createState() => _PROFILEPAGEState();
}

class _PROFILEPAGEState extends State<PROFILEPAGE> {
  final List<ProfileModelData> _list = <ProfileModelData>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Profile'),
      ),
      body: ProfileCommentBox(list: _list),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          var count = 1;
          for (int i = 0; i < count; i++) {
            getData();
          }

          count++;
        },
        label: const Text('Add Profile'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }

  Future<void> getData() async {
    _list.add(ProfileModelData(
      profileName: "Profile Name",
      userName: "@username",
      image: AssetImage("assets/images/profile2.png"),
    ));

    setState(() {});
  }
}
