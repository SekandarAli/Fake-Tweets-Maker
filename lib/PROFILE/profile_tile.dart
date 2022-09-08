// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:fake_tweet/MODEL/model_tweet.dart';
import 'package:fake_tweet/WIDGETS/StringImage.dart';
import 'package:fake_tweet/image_utility.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../Functions/date.dart';
import '../Functions/time.dart';
import 'profile_add_data.dart';

class ProfileTile extends StatefulWidget {
  ModelTweet? task;
  int? index;

  String? tileProfileName;
  String? tileUserName;
  String? tileMainTweet;
  String? tileReTweet;
  String? tileQuoteTweet;
  String? tileLike;
  MemoryImage? tileProfileImage;
  MemoryImage? tileMainTweetImage;

  ProfileTile(
      {this.tileProfileName,
      this.tileLike,
      this.tileMainTweet,
      this.tileQuoteTweet,
      this.tileReTweet,
      this.tileUserName,
      this.tileProfileImage,
      this.tileMainTweetImage,
      this.task,
      this.index,
      Key? key})
      : super(key: key);

  @override
  State<ProfileTile> createState() => _ProfileTileState();
}

class _ProfileTileState extends State<ProfileTile> {
  Image? profileImagePath;
  Image? mainImagePath;

  @override
  Widget build(BuildContext context) {
    if (widget.task!.profileImage != null) {
      profileImagePath =
          ImageUtility.imageFromBase64String(widget.task!.profileImage!);
    } else {
      profileImagePath =
          ImageUtility.imageFromBase64String(StringImage().profileImageString);
    }

    if (widget.task!.mainTweetImage != null) {
      mainImagePath =
          ImageUtility.imageFromBase64String(widget.task!.mainTweetImage!);
    } else {
      mainImagePath =
          ImageUtility.imageFromBase64String(StringImage().mainImageString);
    }

    return GestureDetector(
      onTap: () {
        Navigator.pop(context, [
          ///index 0
          widget.task!.profileName,

          ///index 1
          widget.task!.userNameGrey,

          ///index 2
          widget.task!.mainTweetText,

          ///index 3
          widget.task!.twitterForAndroid,

          ///index 4
          widget.task!.reTweets,

          ///index 5
          widget.task!.quoteTweets,

          ///index 6
          widget.task!.likesCount,

          ///index 7
          profileImagePath!.image,

          ///index 8
          mainImagePath!.image,
        ]);
      },
      child: Card(
        child: Container(
          margin: EdgeInsets.all(15),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child: IntrinsicWidth(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Profile Icon

                      Row(
                        children: [
                          CircleAvatar(
                            radius: 27,
                            backgroundImage: widget.task!.profileImage == null
                                ? AssetImage("assets/images/profile.jpg")
                                : profileImagePath!.image,
                          ),
                          SizedBox(width: 10),
                          Flexible(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          widget.task!.profileName!,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 4),
                                        CircleAvatar(
                                          radius: 7,
                                          backgroundImage: AssetImage(
                                              "assets/images/verified.png"),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      widget.task!.userNameGrey!,
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),

                                //  POP UP MENU BUTTON

                                PopupMenuButton(
                                    onSelected: (value) {},
                                    itemBuilder: (BuildContext context) {
                                      return [
                                        PopupMenuItem(
                                          value: "Save to Home",
                                          child: GestureDetector(
                                            onTap: () {
                                              // Navigator.of(context).pop(
                                              //     widget.task.mainTweetText);
                                              // if (kDebugMode) {
                                              //   print(widget
                                              //       .task.mainTweetText);
                                              // }
                                            },
                                            child: Text(
                                              "Back",
                                              // "Save to Home",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        PopupMenuItem(
                                          value: "Edit",
                                          child: GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (_) => AlertDialog(
                                                  insetPadding:
                                                      EdgeInsets.only(top: 40),
                                                  contentPadding:
                                                      EdgeInsets.zero,
                                                  clipBehavior: Clip
                                                      .antiAliasWithSaveLayer,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(10.0),
                                                    ),
                                                  ),
                                                  content: Builder(
                                                    builder: (context) {
                                                      return SizedBox(
                                                        height: double.infinity,
                                                        width: double.infinity,
                                                        child: ProfileAddData(
                                                          task: widget.task,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Text(
                                              "Edit",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue),
                                            ),
                                          ),
                                        ),
                                        PopupMenuItem(
                                          value: "Delete",
                                          child: GestureDetector(
                                            onTap: () {
                                              widget.task!.delete();
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "Delete",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.red),
                                            ),
                                          ),
                                        ),
                                      ];
                                    }),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),

                      //Main Tweet

                      Text(
                        widget.task!.mainTweetText!,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.normal,
                        ),
                      ),

                      SizedBox(height: 10),

                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: 180,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: widget.task!.mainTweetImage == null
                                    ? AssetImage("assets/images/cam.png")
                                    : mainImagePath!.image,
                                fit: BoxFit.fill),
                          ),
                        ),
                      ),

                      SizedBox(height: 10),
                      Row(
                        children: [
                          //  TIME PICKER

                          SELECT_TIME(),

                          Text(
                            " · ",
                            style: TextStyle(
                              fontSize: 30,
                            ),
                          ),

                          //DATE PICKER

                          SELECT_DATE(),

                          Text(
                            " · ",
                            style: TextStyle(
                              fontSize: 30,
                            ),
                          ),
                          Text(
                            widget.task!.twitterForAndroid!,
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 6, bottom: 6),
                        child: Row(
                          children: [
                            Text(
                              widget.task!.reTweets!,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              " Retweets   ",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              widget.task!.quoteTweets!,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              " Quote Tweets   ",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              widget.task!.likesCount!,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              " Like",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//NEW
