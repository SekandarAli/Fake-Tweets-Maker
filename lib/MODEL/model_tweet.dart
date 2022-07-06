// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';

part 'model_tweet.g.dart';

@HiveType(typeId: 0)
class ModelTweet extends HiveObject {
  @HiveField(0)
  String? profileImage;

  @HiveField(1)
  String? profileName;

  @HiveField(2)
  String? userNameGrey;

  @HiveField(3)
  String? mainTweetText;

  @HiveField(4)
  String? mainTweetImage;

  @HiveField(5)
  String? twitterForAndroid;

  @HiveField(6)
  String? reTweets;

  @HiveField(7)
  String? quoteTweets;

  @HiveField(8)
  String? likesCount;

  @HiveField(9)
  String? userNameBlue;

  @HiveField(10)
  String? time;

  @HiveField(11)
  String? typeReply;

  @HiveField(12)
  Image? image;


  ModelTweet({
    this.profileImage,
    this.profileName,
    this.userNameGrey,
    this.userNameBlue,
    this.mainTweetText,
    this.mainTweetImage,
    this.twitterForAndroid,
    this.reTweets,
    this.quoteTweets,
    this.likesCount,
    this.time,
    this.typeReply,
    this.image,
  });
}
