// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';

class MODELDATA {
  String profileName = 'ProfileName';
  String userNameGrey = '@username';
  String userNameBlue = '@username';
  String time = '20m';
  String typeReply = 'Type Reply';
  AssetImage image;

  MODELDATA(
      {required this.profileName,
      required this.userNameGrey,
      required this.userNameBlue,
      required this.time,
      required this.image,
      required this.typeReply});
}
