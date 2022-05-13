// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';

class ProfileModelData {
  String profileName = 'Profile Name';
  String userName = '@username';
  AssetImage image =  AssetImage("assets/images/profile2.png");

  ProfileModelData(
      {required this.profileName,
        required this.userName,
        required this.image,
        });
}
