// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_null_comparison, avoid_print, non_constant_identifier_names, prefer_final_fields

import 'package:fake_tweet/Functions/date.dart';
import 'package:fake_tweet/Functions/share_screenshot.dart';
import 'package:fake_tweet/Functions/time.dart';
import 'package:fake_tweet/WIDGETS/commentbox.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';
import 'package:typed_data/typed_data.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:typed_data';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

import 'MODEL/data_model.dart';
import 'listview_commentbox.dart';



class TWEET extends StatefulWidget {
  const TWEET({Key? key}) : super(key: key);

  @override
  State<TWEET> createState() => _TWEETState();
}

class _TWEETState extends State<TWEET> {



  final ScreenshotController _screenshotController = ScreenshotController();

  final SHARE_SCREENSHOT _share_screenshot = SHARE_SCREENSHOT();

  List<MODELDATA> _list = <MODELDATA>[];

  bool valuefirst = false;
  bool isVisibleMainImage = true;
  bool isVisibleProtectedIcon = false;
  bool isVisibleVerifiedIcon = true;
  bool isVisibleRetweet = true;
  bool isVisibleHeart = true;

  final ImagePicker _profileImage = ImagePicker();
  PickedFile? _profileImagePick;
  final ImagePicker _mainImage = ImagePicker();
  PickedFile? _mainImagePick;

  late TextEditingController textEditingController = TextEditingController();
  String profileName = 'ProfileName';
  String userName = '@username';
  String mainTweet = 'Main Tweet';
  String twitterAndroid = 'Twitter for Android';

  @override
  Widget build(BuildContext context) {

    final savedProfileName = ModalRoute.of(context)!.settings.arguments.toString();
    print(savedProfileName);

    return Padding(
      padding: EdgeInsets.all(12),
      child: Screenshot(
        controller: _screenshotController,
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
                        GestureDetector(
                          onTap: () async {
                            await showModalBottomSheet(
                              context: context,
                              builder: ((builder) {
                                return bottomSheet();
                              }),
                            );
                          },
                          child: CircleAvatar(
                            radius: 27,
                            backgroundImage: _profileImagePick != null
                                ? FileImage(File(_profileImagePick!.path))
                                    as ImageProvider
                                : AssetImage("assets/images/profile2.png"),
                          ),
                        ),

                        SizedBox(width: 10),
                        //Profile name/Username

                        Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          final profile = await openDialogue();
                                          if (profile!.isEmpty) {
                                            return;
                                          }
                                          setState(() => profileName = profile);
                                        },
                                        child: Text(
                                          profileName,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 4),
                                      if (isVisibleVerifiedIcon)
                                        CircleAvatar(
                                          radius: 7,
                                          backgroundImage: AssetImage(
                                              "assets/images/verified.png"),
                                        ),
                                      SizedBox(width: 2),
                                      if (isVisibleProtectedIcon)
                                        CircleAvatar(
                                          radius: 7,
                                          backgroundColor: Colors.white,
                                          backgroundImage: AssetImage(
                                              "assets/images/lock.png"),
                                        ),
                                    ],
                                  ),
                                  SizedBox(height: 2),
                                  GestureDetector(
                                    onTap: () async {
                                      final user = await openDialogue();
                                      if (user!.isEmpty) {
                                        return;
                                      }
                                      setState(() => userName = user);
                                    },
                                    child: Text(
                                      userName,
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              //  POP UP MENU BUTTON

                              PopupMenuButton<int>(
                                elevation: 20,
                                onSelected: (item) => handleClick(item),
                                itemBuilder: (context) => [
                                  PopupMenuItem<int>(
                                    value: 0,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              isVisibleVerifiedIcon =
                                                  !isVisibleVerifiedIcon;
                                              Navigator.pop(context);
                                            });
                                          },
                                          child: isVisibleVerifiedIcon
                                              ? Text("Hide Verified Icon")
                                              : Text("Add Verified Icon"),
                                        ),
                                        // Checkbox(
                                        //   checkColor: Colors.greenAccent,
                                        //   activeColor: Colors.red,
                                        //   value: valuefirst,
                                        //   onChanged: (value) {
                                        //     setState(() {
                                        //       valuefirst = value!;
                                        //     });
                                        //   },
                                        // ),
                                      ],
                                    ),
                                  ),
                                  PopupMenuItem<int>(
                                    value: 1,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isVisibleProtectedIcon =
                                              !isVisibleProtectedIcon;
                                          Navigator.pop(context);
                                        });
                                      },
                                      child: isVisibleProtectedIcon
                                          ? Text("Hide Protected Icon")
                                          : Text("Add Protected Icon"),
                                    ),
                                  ),
                                  PopupMenuItem<int>(
                                      value: 2,
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isVisibleMainImage =
                                                !isVisibleMainImage;
                                            Navigator.pop(context);
                                          });
                                        },
                                        child: isVisibleMainImage
                                            ? Text("Hide Image")
                                            : Text("Add Image"),
                                      )),
                                  PopupMenuItem<int>(
                                      value: 3, child: Text('Quote a Tweet')),
                                  PopupMenuItem<int>(
                                      value: 4, child: Text('Likes Count')),
                                  PopupMenuItem<int>(
                                      value: 5, child: Text('Retweets Count')),
                                  PopupMenuItem<int>(
                                      value: 6, child: Text('Qt Tweets Count')),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),

                    //Main Tweet

                    GestureDetector(
                      onTap: () async {
                        final tweet = await openDialogue();
                        if (tweet!.isEmpty) {
                          return;
                        }
                        setState(() => mainTweet = tweet);
                      },
                      child: Text(
                        mainTweet,
                        style: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),

                    if (isVisibleMainImage)
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: ((builder) {
                              // return bottomSheet();
                              return bottomSheet2();
                            }),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                              height: 180,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: _mainImagePick == null
                                        ? AssetImage("assets/images/cam.png")
                                        : Image.file(File(_mainImagePick!.path))
                                            .image,
                                    fit: BoxFit.fill),
                              )),
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
                        GestureDetector(
                          onTap: () async {
                            final twitter = await openDialogue();
                            if (twitter!.isEmpty) {
                              return;
                            }
                            setState(() => twitterAndroid = twitter);
                          },
                          child: Text(
                            twitterAndroid,
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
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
                            "25",
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
                            "18",
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
                            "785",
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
                    Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),

                    // ICONS

                    Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              var count = 1;
                              for (int i = 0; i < count; i++) {
                                getData();

                              }

                              count++;

                              print(count);

                            },
                            child: Icon(
                                    Icons.comment_outlined,
                                  ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isVisibleRetweet = !isVisibleRetweet;
                              });
                            },
                            child: isVisibleRetweet
                                ? Icon(
                                    Icons.repeat_outlined,
                                  )
                                : Icon(
                                    Icons.repeat_outlined,
                                    color: Colors.green,
                                  ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isVisibleHeart = !isVisibleHeart;
                              });
                            },
                            child: isVisibleHeart
                                ? Icon(
                                    Icons.favorite_outline,
                                  )
                                : Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  ),
                          ),
                          InkWell(
                            onTap: () async {
                              final image = await _screenshotController.capture();
                              if (image == null) return;
                              _share_screenshot.shareImage(image);
                            },
                            child: Icon(
                              Icons.share_outlined,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                    SizedBox(height:10),




                  ],
                ),
              ),
            ),


            // COMMENT ICON CLICK

            ListViewCommentBox(list:_list),
            // COMMENTBOX(list:_list),
          ],
        ),
      ),
    );
  }

  //ALERT DIALOGUE FUNCTION

  Future<String?> openDialogue() => showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Type Something here..."),
          content: TextField(
            controller: textEditingController,
            autofocus: true,
            decoration: InputDecoration(
              hintText: "Type here",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(textEditingController.text);
                textEditingController.clear();
              },
              child: Text("Done"),
            ),
          ],
        );
      });

  //PICK IMAGE FUNCTION USING BOTTOM SHEET

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: [
          Text(
            "CHOOSE IMAGE",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton.icon(
                onPressed: () {
                  takePhoto(ImageSource.camera);
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.camera,
                  color: Colors.black,
                ),
                label: Text(
                  "Camera",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.image,
                  color: Colors.black,
                ),
                label: Text(
                  "Gallery",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _profileImage.getImage(
      source: source,
    );

    setState(() {
      _profileImagePick = pickedFile!;
    });
  }

  Widget bottomSheet2() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: [
          Text(
            "CHOOSE IMAGE",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton.icon(
                onPressed: () {
                  takePhoto2(ImageSource.camera);
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.camera,
                  color: Colors.black,
                ),
                label: Text(
                  "Camera",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  takePhoto2(ImageSource.gallery);
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.image,
                  color: Colors.black,
                ),
                label: Text(
                  "Gallery",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void takePhoto2(ImageSource source) async {
    final pickedFile = await _mainImage.getImage(
      source: source,
    );
    setState(() {
      _mainImagePick = pickedFile!;
    });
  }

  //  POP UP MENU BUTTON Handler

  handleClick(int item) {
    switch (item) {
      case 0:
        break;
      case 1:
        break;
      // Add Image
      case 2:
        // GestureDetector(onTap: () {
        //   setState(() {
        //     print(isVisible);
        //     isVisible = !isVisible;
        //     print(isVisible);
        //   });
        // });

        break;
      case 3:
        break;
      case 4:
        break;
      case 5:
        break;
      case 6:
        break;
    }
  }

  Future<void> getData() async {
    _list.add(MODELDATA(
      profileName: "ProfileName",
      userNameGrey: "@username",
      userNameBlue: "@username",
      time: "2m",
      typeReply: "Type Reply",
      image: AssetImage("assets/images/profile2.png"),
    ));

    setState(() {});
  }
}
