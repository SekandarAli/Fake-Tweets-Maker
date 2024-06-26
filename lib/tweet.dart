// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_null_comparison, avoid_print, non_constant_identifier_names, prefer_final_fields, must_be_immutable, prefer_const_constructors_in_immutables

import 'package:fake_tweet/Functions/date.dart';
import 'package:fake_tweet/Functions/share_screenshot.dart';
import 'package:fake_tweet/Functions/time.dart';
import 'package:fake_tweet/PROFILE/profile_page.dart';
import 'package:fake_tweet/WIDGETS/CommentBox.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:screenshot/screenshot.dart';

import 'FUnctions/screenshot.dart';
import 'MODEL/model_tweet.dart';

class TWEET extends StatefulWidget {
  TWEET({Key? key}) : super(key: key);

  @override
  State<TWEET> createState() => _TWEETState();
}

class _TWEETState extends State<TWEET> {
  final ScreenshotController _screenshotController = ScreenshotController();
  final SHARE_SCREENSHOT _share_screenshot = SHARE_SCREENSHOT();
  final SCREENSHOT _screenshot = SCREENSHOT();

  List<ModelTweet> _list = <ModelTweet>[];

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
  String? profileName = 'ProfileName';
  String? userName = '@username';
  String? mainTweet = 'Main Tweet';
  String? twitterAndroid = 'Twitter for Android';
  String? reTweets = '25';
  String? quoteTweets = '18';
  String? likes = '257';

  ModelTweet? task;

  int count = 0;
  MemoryImage? profileImage;
  MemoryImage? mainTweetImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Text("FAKE TWEET",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 27)),
        actions: [
          IconButton(
            icon: Icon(
              Icons.save_outlined,
              color: Colors.black,
              size: 35,
            ),
            onPressed: () async {
              final image = await _screenshotController.capture();
              if (image == null) return;
              _screenshot.saveImage(image);
              Fluttertoast.showToast(
                  msg: "Screenshot Successfully Saved to Gallery",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 17);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: Colors.black,
              size: 35,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.person_outline,
              color: Colors.black,
              size: 35,
            ),
            onPressed: () async {
              final List<dynamic> newValue = await Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) {
                return ProfilePage();
              }));

              setState(() {
                profileName = newValue[0];
                userName = newValue[1];
                mainTweet = newValue[2];
                twitterAndroid = newValue[3];
                reTweets = newValue[4];
                quoteTweets = newValue[5];
                likes = newValue[6];
                profileImage = newValue[7];
                mainTweetImage = newValue[8];
              });
            },
          ),
          PopupMenuButton<int>(
            icon: Icon(
              Icons.more_vert,
              color: Colors.black,
              size: 35,
            ),
            onSelected: (item) => handleClick(item),
            itemBuilder: (context) => [
              PopupMenuItem<int>(value: 0, child: Text('Themes')),
              PopupMenuItem<int>(value: 1, child: Text('Rate App')),
              PopupMenuItem<int>(value: 2, child: Text('Invite')),
              PopupMenuItem<int>(value: 3, child: Text('Mail Us')),
            ],
          ),
        ],
      ),
      body: Screenshot(
        controller: _screenshotController,
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(12),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    child: IntrinsicWidth(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ///Profile Icon

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
                                    radius: 30,
                                    backgroundImage: profileImage == null
                                        ? AssetImage(
                                            "assets/images/profile.jpg")
                                        : profileImage != null
                                            ? profileImage as ImageProvider
                                            : Image.file(File(
                                                    _profileImagePick!.path))
                                                as ImageProvider),
                              ),

                              SizedBox(width: 10),
                              ///Profile name/Username

                              Flexible(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () async {
                                                var profile =
                                                    await openDialogue();
                                                if (profile!.isEmpty) {
                                                  return;
                                                } else {
                                                  var newTask = ModelTweet(
                                                    profileName: profile,
                                                  );

                                                  if (profile != null) {
                                                    setState(() {
                                                      profileName =
                                                          newTask.profileName!;
                                                    });
                                                    task!.save();
                                                  } else {}
                                                }
                                              },
                                              child: Text(
                                                profileName!,
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
                                            var newTask = ModelTweet(
                                              userNameGrey: user,
                                            );

                                            if (user != null) {
                                              setState(() {
                                                userName =
                                                    newTask.userNameGrey!;
                                              });
                                              task!.save();
                                            } else {}
                                          },
                                          child: Text(
                                            userName!,
                                            style: TextStyle(
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    ///  POP UP MENU BUTTON

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
                                            value: 3,
                                            child: Text('Quote a Tweet')),
                                        PopupMenuItem<int>(
                                            value: 4,
                                            child: Text('Likes Count')),
                                        PopupMenuItem<int>(
                                            value: 5,
                                            child: Text('Retweets Count')),
                                        PopupMenuItem<int>(
                                            value: 6,
                                            child: Text('Qt Tweets Count')),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),

                          ///Main Tweet

                          GestureDetector(
                            onTap: () async {
                              final tweet = await openDialogue();
                              if (tweet!.isEmpty) {
                                return;
                              }
                              setState(() => mainTweet = tweet);
                            },
                            child: Text(
                              mainTweet!,
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.normal,
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
                                    return bottomSheet2();
                                  }),
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                    height: MediaQuery.of(context).size.height*0.2,
                                    width: MediaQuery.of(context).size.width*0.9,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: mainTweetImage == null
                                              ? AssetImage(
                                                  "assets/images/cam.png")
                                              : mainTweetImage
                                                  as ImageProvider),
                                    )),
                              ),
                            ),

                          SizedBox(height: 10),
                          Row(
                            children: [
                              ///  TIME PICKER

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
                                  twitterAndroid!,
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
                                GestureDetector(
                                  onTap: () async {
                                    final retweet = await openDialogue();
                                    if (retweet!.isEmpty) {
                                      return;
                                    }
                                    setState(() => reTweets = retweet);
                                  },
                                  child: Text(
                                    reTweets!,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text(
                                  " Retweets   ",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    final quote = await openDialogue();
                                    if (quote!.isEmpty) {
                                      return;
                                    }
                                    setState(() => quoteTweets = quote);
                                  },
                                  child: Text(
                                    quoteTweets!,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text(
                                  " Quote Tweets   ",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    final lik = await openDialogue();
                                    if (lik!.isEmpty) {
                                      return;
                                    }
                                    setState(() => likes = lik);
                                  },
                                  child: Text(
                                    likes!,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
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

                          /// ICONS

                          Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (count < 3) {
                                      setState(() {
                                        getData();
                                        count++;
                                        print(count);
                                      });
                                    } else {
                                      print(count);
                                      Fluttertoast.showToast(
                                          msg:
                                              "Cannot Add more than 3 Comments",
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.BOTTOM,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 12);
                                    }
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
                                    final image =
                                        await _screenshotController.capture();
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
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),

                  // COMMENT ICON CLICK

                  CommentBox(list: _list),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //ALERT DIALOGUE FUNCTION

  Future<String?>

  openDialogue() => showDialog<String>(
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
    _list.add(ModelTweet(
      profileName: "ProfileName",
      userNameGrey: "@username",
      userNameBlue: "@username",
      time: "2m",
      typeReply: "Type Reply",
      // image: AssetImage("assets/images/profile.jpg")
    ));

    setState(() {});
  }
}
