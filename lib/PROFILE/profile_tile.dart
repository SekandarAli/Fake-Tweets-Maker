// // ignore_for_file: must_be_immutable, prefer_const_constructors
//
// import 'dart:convert';
// import 'dart:io';
// import 'dart:typed_data';
//
// import 'package:fake_tweet/MODEL/model_tweet.dart';
// import 'package:fake_tweet/PROFILE/profile_add_data.dart';
// import 'package:fake_tweet/image_utility.dart';
// import 'package:flutter/material.dart';
//
// class ProfileTile extends StatefulWidget {
//   ProfileTile(this.task, this.index, {Key? key}) : super(key: key);
//
//   ModelTweet task;
//   int index;
//
//   @override
//   State<ProfileTile> createState() => _ProfileTileState();
// }
//
// class _ProfileTileState extends State<ProfileTile> {
//   late ModelTweet expense;
//
//   Image? path_04;
//
//   @override
//   Widget build(BuildContext context) {
//
//     if(widget.task.image !=null ){
//       path_04 = ImageUtility.imageFromBase64String(widget.task.mainTweetImage!);
//     }
//     else {
//     }
//
//
//     return Card(
//       color: Colors.white,
//       child: ExpansionTile(
//         leading: CircleAvatar(
//           radius: 28,
//           backgroundImage: widget.task.image == null
//               ? AssetImage("assets/images/profile.jpg")
//               : path_04!.image,
//
//         ),
//
//
//
//         title: Text(
//           widget.task.profileName!,
//           maxLines: 2,
//           style: TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.bold,
//             fontSize: 20,
//           ),
//         ),
//         subtitle: Row(
//           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//         widget.task.userNameBlue.toString(),
//               maxLines: 2,
//               style: TextStyle(color: Colors.blue, fontSize: 15),
//             ),
//             SizedBox(
//               width: 60,
//             ),
//           ],
//         ),
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               TextButton.icon(
//                 onPressed: () {
//                   showDialog(
//                       context: context,
//                       builder: (_) => AlertDialog(
//                         insetPadding: EdgeInsets.only(top: 40),
//                         contentPadding: EdgeInsets.zero,
//                         clipBehavior: Clip.antiAliasWithSaveLayer,
//                         shape: RoundedRectangleBorder(
//                             borderRadius:
//                             BorderRadius.all(Radius.circular(10.0))),
//                         content: Builder(
//                           builder: (context) {
//                             return SizedBox(
//                               height: double.infinity,
//                               width: double.infinity,
//                               child: ProfileAddData(
//                                 task: widget.task,
//                               ),
//                             );
//                           },
//                         ),
//                       ));
//                 },
//                 icon: Icon(
//                   Icons.edit,
//                 ),
//                 label: Text(
//                   "Edit",
//                   style: TextStyle(),
//                 ),
//               ),
//               TextButton.icon(
//                 onPressed: () {
//                   showDialog(
//                       context: context,
//                       builder: (_) => AlertDialog(
//                         insetPadding: EdgeInsets.only(top: 40),
//                         contentPadding: EdgeInsets.zero,
//                         clipBehavior: Clip.antiAliasWithSaveLayer,
//                         shape: RoundedRectangleBorder(
//                             borderRadius:
//                             BorderRadius.all(Radius.circular(10.0))),
//                         content: Builder(
//                           builder: (context) {
//                             return SizedBox(
//                               height: double.infinity,
//                               width: double.infinity,
//                               child: ProfileAddData(
//                                 task: widget.task,
//                               ),
//                             );
//                           },
//                         ),
//                       ));
//                 },
//                 icon: Icon(
//                   Icons.details,
//                 ),
//                 label: Text(
//                   "Detail",
//                   style: TextStyle(),
//                 ),
//               ),
//               TextButton.icon(
//                 onPressed: () {
//                   widget.task.delete();
//                 },
//                 icon: Icon(
//                   Icons.delete,
//                   color: Colors.red,
//                 ),
//                 label: Text(
//                   "Delete",
//                   style: TextStyle(
//                     color: Colors.red,
//                   ),
//                 ),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }

// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:fake_tweet/MODEL/model_tweet.dart';
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

  Image? aa;

  @override
  Widget build(BuildContext context) {
    if (widget.task!.profileImage != null) {


      profileImagePath =
          ImageUtility.imageFromBase64String(widget.task!.profileImage!);




    } else {
      // profileImagePath = Image.asset("assets/images/verified.png");
      // Fluttertoast.showToast(
      //     msg:
      //     "Profile Image cannot be Empty",
      //     toastLength: Toast.LENGTH_LONG,
      //     gravity: ToastGravity.BOTTOM,
      //     backgroundColor: Colors.red,
      //     textColor: Colors.white,
      //     fontSize: 12);

      String profileImageString = "iVBORw0KGgoAAAANSUhEUgAAAOEAAADhCAMAAAAJbSJIAAAAM1BMVEXk5ueutLfn6eqrsbTp6+zg4uOwtrnJzc/j5earsbW0uby4vcDQ09XGyszU19jd3+G/xMamCvwDAAAFLklEQVR4nO2d2bLbIAxAbYE3sDH//7WFbPfexG4MiCAcnWmnrzkjIRaD2jQMwzAMwzAMwzAMwzAMwzAMwzAMwzAMwzAMwzAMw5wQkHJczewxZh2lhNK/CBOQo1n0JIT74/H/qMV0Z7GU3aCcVPuEE1XDCtVLAhgtpme7H0s1N1U7QjO0L8F7llzGeh1hEG/8Lo7TUmmuSrOfns9xnGXpXxsONPpA/B6OqqstjC6Ax/0ujkNdYQQbKNi2k64qiiEZ+ohi35X+2YcZw/WujmslYewiAliVYrxgJYrdwUmwXsU+RdApUi83oNIE27YvrfB/ZPg8+BJETXnqh9CVzBbTQHgojgiCvtqU9thFJg/CKz3VIMKMEkIXxIWqIpIg2SkjYj+xC816mrJae2aiWGykxRNsW0UwiJghJDljYI5CD8GRiCtIsJxizYUPQ2pzItZy5pcisTRdk/a9m4amtNNfBuQkdVhSaYqfpNTSFGfb9GRIakrE2Pm+GFLaCQPqiu0OpWP+HMPQQcgQMiQprWXNmsVwIjQjYi/ZrhAqNTCgr2gu0Jnz85RSSjso0HkMFZ0YZjKkc26a/jlmh9JiDyDxi9oeorTYAzZkwwoMz19pzj9bnH/GP/+qbchjSGflneWYhtTuKdMOmNKZcJ5TjInQKcYXnESd/jQxy0ENpULTNGOGgxpap/oyw9pbUAqhfx2Dbkhovvfgz4iUzoM9+GlK6/Mh4q29hyC1mwro30hpVVLPF9wYQr71RazOeM5/cw81iBRD+A03aM9/C/obbrKjbYSpCmIVG3qT/Q8oeUo3Rz0IL7vI1tEbCB9pSiu8I/aV8x3Kg/BGWrWp4ZVs0nZfmAoEG4h/61yHYIJiFSl6Q0Vk6tTW1N8kYp8hdOkfHYYMXd2Qft+8CYwqYDSKvqIh+MCF8Wgca2u/cwdgeW3TtuVn6+1oBs3yLo5C2JpK6CvQzGpfUkz9UG/87gCsi5o2LIXolxN0FbwAsjOLEr+YJmXn7iR6N0BCt5p5cMxm7eAsfS+/CACQf4CTpKjzgkvr2cVarVTf96372yut7XLJ1sa7lv6VcfgYrWaxqr3Wlo1S6pvStr22sxOtTNPLzdY3nj20bPP+ejFdJYkLsjGLdtPBEbe/mr2bQKiXWJDroA+vtzc0p9aahuwqHMDYrQEXHEw9jwQl3drMpts9JBU1SdktPe5FBRdJQ6bwXBpa57ib2A8kukQDzMjh++Uo7Fo6Wd02Pkf4fknqoo4HtvAIjsqUcjx6DIPgWCaOML9rKI/oqD9/lgNrn+eF+p7j8tnzHBiR7+kdUGw/+V1Kzkc75mMy6U+FMaxjPibiM1U1uGM+puInHpmALZCgP4pt7i840MV8+0R1zPsRB6UTcqpizncYwZ89syDydfyWCwXB1l8/zRNGWbTG/GHKUm9AkxHMc/EGSk3z2+ArEhPEV5TUBLEvUGFcjEUH80J/jveTGOAJEljJbILWGQT3zRYiwuKsUXN1EEJAzBhRJFll7mBUG7KD8EqPkKekBREaL8hMDZLQSG6AQjtHPYmvTQnX0TtpC1SYCe2YdkkyLP3jj5BSbKiuR585eQhTgoje6yIb0Yb0C+mV6EYvebqw5SDy2WmubogZiF2AVxPC2FpDf8H2Q9QWo6IkjUxTWVEI3WY/wrCeSuqJ+eRWzXR/JXwgVjUMozbCOfoEZiSiKVGepqv5CJ8RyR4D7xBeamqa7z3BJ/z17JxuBPdv93d/a2Ki878MMAzDMAzDMAzDMAzDMF/KP09VUmxBAiI3AAAAAElFTkSuQmCC";

      profileImagePath =
          ImageUtility.imageFromBase64String(profileImageString);


    }

    if (widget.task!.mainTweetImage != null) {
      mainImagePath =
          ImageUtility.imageFromBase64String(widget.task!.mainTweetImage!);
    } else {

      String mainImageString = "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";
      mainImagePath =  ImageUtility.imageFromBase64String(mainImageString);
    }

    return GestureDetector(
      onTap: () {

        Navigator.pop(context, [
          widget.task!.profileName,
          widget.task!.userNameGrey,
          widget.task!.mainTweetText,
          widget.task!.twitterForAndroid,
          widget.task!.reTweets,
          widget.task!.quoteTweets,
          widget.task!.likesCount,
          profileImagePath!.image,
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

                                        // if (isVisibleVerifiedIcon)
                                        //   CircleAvatar(
                                        //     radius: 7,
                                        //     backgroundImage: AssetImage(
                                        //         "assets/images/verified.png"),
                                        //   ),
                                        // SizedBox(width: 2),
                                        // if (isVisibleProtectedIcon)
                                        //   CircleAvatar(
                                        //     radius: 7,
                                        //     backgroundColor: Colors.white,
                                        //     backgroundImage: AssetImage(
                                        //         "assets/images/lock.png"),
                                        //   ),
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
                                              )),
                                        ),
                                        PopupMenuItem(
                                          value: "Edit",
                                          child: GestureDetector(
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (_) => AlertDialog(
                                                          insetPadding:
                                                              EdgeInsets.only(
                                                                  top: 40),
                                                          contentPadding:
                                                              EdgeInsets.zero,
                                                          clipBehavior: Clip
                                                              .antiAliasWithSaveLayer,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          10.0))),
                                                          content: Builder(
                                                            builder: (context) {
                                                              return SizedBox(
                                                                height: double
                                                                    .infinity,
                                                                width: double
                                                                    .infinity,
                                                                child:
                                                                    ProfileAddData(
                                                                  task: widget
                                                                      .task,
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ));
                                              },
                                              child: Text(
                                                "Edit",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blue),
                                              )),
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
                                              )),
                                        ),
                                      ];
                                    }),
                                // PopupMenuButton<int>(
                                //   elevation: 20,
                                //   onSelected: (item) => handleClick(item),
                                //   itemBuilder: (context) => [
                                //     PopupMenuItem<int>(
                                //       value: 0,
                                //       child: Row(
                                //         mainAxisAlignment:
                                //             MainAxisAlignment.spaceBetween,
                                //         children: [
                                //           GestureDetector(
                                //             onTap: () {
                                //               setState(() {
                                //                 isVisibleVerifiedIcon =
                                //                     !isVisibleVerifiedIcon;
                                //                 Navigator.pop(context);
                                //               });
                                //             },
                                //             child: isVisibleVerifiedIcon
                                //                 ? Text("Hide Verified Icon")
                                //                 : Text("Add Verified Icon"),
                                //           ),
                                //           // Checkbox(
                                //           //   checkColor: Colors.greenAccent,
                                //           //   activeColor: Colors.red,
                                //           //   value: valuefirst,
                                //           //   onChanged: (value) {
                                //           //     setState(() {
                                //           //       valuefirst = value!;
                                //           //     });
                                //           //   },
                                //           // ),
                                //         ],
                                //       ),
                                //     ),
                                //     PopupMenuItem<int>(
                                //       value: 1,
                                //       child: GestureDetector(
                                //         onTap: () {
                                //           setState(() {
                                //             isVisibleProtectedIcon =
                                //                 !isVisibleProtectedIcon;
                                //             Navigator.pop(context);
                                //           });
                                //         },
                                //         child: isVisibleProtectedIcon
                                //             ? Text("Hide Protected Icon")
                                //             : Text("Add Protected Icon"),
                                //       ),
                                //     ),
                                //     PopupMenuItem<int>(
                                //         value: 2,
                                //         child: GestureDetector(
                                //           onTap: () {
                                //             setState(() {
                                //               isVisibleMainImage =
                                //                   !isVisibleMainImage;
                                //               Navigator.pop(context);
                                //             });
                                //           },
                                //           child: isVisibleMainImage
                                //               ? Text("Hide Image")
                                //               : Text("Add Image"),
                                //         )),
                                //     PopupMenuItem<int>(
                                //         value: 3, child: Text('Quote a Tweet')),
                                //     PopupMenuItem<int>(
                                //         value: 4, child: Text('Likes Count')),
                                //     PopupMenuItem<int>(
                                //         value: 5,
                                //         child: Text('Retweets Count')),
                                //     PopupMenuItem<int>(
                                //         value: 6,
                                //         child: Text('Qt Tweets Count')),
                                //   ],
                                // ),
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
                            )),
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
