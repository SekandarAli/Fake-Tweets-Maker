// ignore_for_file: must_be_immutable, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:io';
import 'package:fake_tweet/MODEL/model_tweet.dart';
import 'package:fake_tweet/image_utility.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';

class ProfileAddData extends StatefulWidget {
  ProfileAddData({this.task, Key? key}) : super(key: key);

  ModelTweet? task;

  @override
  State<ProfileAddData> createState() => _ProfileAddDataState();
}

class _ProfileAddDataState extends State<ProfileAddData> {
  final ImagePicker imagePickerProfile = ImagePicker();
  final ImagePicker imagePickerMainImage = ImagePicker();

  String? profileImagePick;
  String? mainImagePick;

  Image? profileImagePath;
  Image? mainImagePath;

  String? profileImagePathString;
  String? mainImagePathString;

  void takePhotoProfile(ImageSource source) async {
    XFile? pickedImage = await imagePickerProfile.pickImage(source: source);
    if (pickedImage != null) {
      profileImagePathString =
          ImageUtility.base64String(File(pickedImage.path).readAsBytesSync());
    }

    setState(() {
      profileImagePick = profileImagePathString;
      profileImagePath = ImageUtility.imageFromBase64String(profileImagePick!);
    });
  }

  void takePhotoImage(ImageSource source) async {
    XFile? pickedImage = await imagePickerMainImage.pickImage(source: source);
    if (pickedImage != null) {
      mainImagePathString =
          ImageUtility.base64String(File(pickedImage.path).readAsBytesSync());
    }

    setState(() {
      mainImagePick = mainImagePathString;
      mainImagePath = ImageUtility.imageFromBase64String(mainImagePick!);
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController profileName = TextEditingController(
        text: widget.task == null ? "ProfileName" : widget.task!.profileName);

    TextEditingController userNameGrey = TextEditingController(
        text: widget.task == null ? "@username" : widget.task!.userNameGrey);

    TextEditingController userNameBlue = TextEditingController(
        text: widget.task == null ? "@username" : widget.task!.userNameBlue);

    TextEditingController mainTweetText = TextEditingController(
        text: widget.task == null ? "Main Tweet" : widget.task!.mainTweetText);

    TextEditingController twitterForAndroid = TextEditingController(
        text: widget.task == null
            ? "Twitter For Android"
            : widget.task!.twitterForAndroid);

    TextEditingController reTweets = TextEditingController(
        text: widget.task == null ? "25" : widget.task!.reTweets);

    TextEditingController quoteTweets = TextEditingController(
        text: widget.task == null ? "12" : widget.task!.quoteTweets);

    TextEditingController likesCount = TextEditingController(
        text: widget.task == null ? "153" : widget.task!.likesCount);

    return SingleChildScrollView(
      child: Container(
        color: Colors.grey.shade200,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 70,
                child: Container(
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.close,
                          color: Colors.black,
                          size: 35,
                        ),
                      ),
                      Text(
                        "Add Fake Profile",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          var newTask = ModelTweet(
                            profileName: profileName.text.toString(),
                            userNameBlue: userNameBlue.text.toString(),
                            userNameGrey: userNameGrey.text.toString(),
                            mainTweetText: mainTweetText.text.toString(),
                            twitterForAndroid:
                                twitterForAndroid.text.toString(),
                            reTweets: reTweets.text.toString(),
                            quoteTweets: quoteTweets.text.toString(),
                            likesCount: likesCount.text.toString(),
                            profileImage: profileImagePick,
                            mainTweetImage: mainImagePick,
                          );

                          Box<ModelTweet> taskBox =
                              Hive.box<ModelTweet>("modelTweet");

                          if (widget.task != null) {
                            widget.task!.profileName = newTask.profileName;
                            widget.task!.userNameGrey = newTask.userNameGrey;
                            widget.task!.userNameBlue = newTask.userNameBlue;
                            widget.task!.mainTweetText = newTask.mainTweetText;
                            widget.task!.twitterForAndroid =
                                newTask.twitterForAndroid;
                            widget.task!.reTweets = newTask.reTweets;
                            widget.task!.quoteTweets = newTask.quoteTweets;
                            widget.task!.likesCount = newTask.likesCount;
                            widget.task!.profileImage = newTask.profileImage;
                            widget.task!.mainTweetImage =
                                newTask.mainTweetImage;

                            widget.task!.save();

                            Navigator.pop(context);
                          } else {
                            await taskBox.add(newTask);
                            Navigator.pop(context);
                          }
                        },
                        child: Text(
                          "Save",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () async {
                      await showModalBottomSheet(
                        context: context,
                        builder: ((builder) {
                          return bottomSheetProfile();
                        }),
                      );
                    },
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.blue,
                      backgroundImage: profileImagePick != null
                          ? profileImagePath!.image
                          : AssetImage("assets/images/profile.jpg"),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await showModalBottomSheet(
                        context: context,
                        builder: ((builder) {
                          return bottomSheetImage();
                        }),
                      );
                    },
                    child: CircleAvatar(
                      radius: 70,
                      backgroundColor: Colors.blue,
                      backgroundImage: mainImagePick != null
                          ? mainImagePath!.image
                          : AssetImage("assets/images/cam.png"),
                    ),
                  ),
                  //
                  // GestureDetector(
                  //   onTap: () {
                  //     showModalBottomSheet(
                  //       context: context,
                  //       builder: ((builder) {
                  //         return bottomSheetImage();
                  //       }),
                  //     );
                  //   },
                  //   child: ClipRRect(
                  //     borderRadius: BorderRadius.circular(30),
                  //     child: Container(
                  //         height: 150,
                  //         decoration: BoxDecoration(
                  //           image: DecorationImage(
                  //               image: mainImagePick != null
                  //                   ? mainImagePath!.image
                  //                   : AssetImage("assets/images/cam.png")),
                  //         )),
                  //   ),
                  // ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  TextField(
                    controller: profileName,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none,
                        ),
                        hintText: "Profile Name"),
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                  ),
                  TextField(
                    controller: userNameGrey,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.person_pin,
                          color: Colors.black,
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none,
                        ),
                        hintText: "UserName Black"),
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                  ),
                  // TextField(
                  //   controller: userNameBlue,
                  //   style: TextStyle(
                  //     color: Colors.blue
                  //   ),
                  //   decoration: InputDecoration(
                  //       prefixIcon: Icon(
                  //         Icons.person_pin,
                  //         color: Colors.blue,
                  //       ),
                  //       fillColor: Colors.white,
                  //       filled: true,
                  //       border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(5),
                  //         borderSide: BorderSide.none,
                  //       ),
                  //       hintText: "UserName Blue"),
                  // ),
                  // Divider(
                  //   height: 1,
                  //   thickness: 1,
                  // ),

                  SizedBox(height: 20),
                  TextField(
                    controller: mainTweetText,
                    keyboardType: TextInputType.multiline,
                    maxLines: 2,
                    maxLength: 500,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.description,
                          color: Colors.black,
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none,
                        ),
                        hintText: "Main Tweet"),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: twitterForAndroid,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.settings_applications_rounded,
                          color: Colors.black,
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none,
                        ),
                        hintText: "Twitter for..."),
                  ),
                  SizedBox(height: 20),

                  TextField(
                    controller: reTweets,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.redo,
                          color: Colors.black,
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none,
                        ),
                        hintText: "ReTweets"),
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                  ),
                  TextField(
                    controller: quoteTweets,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.format_quote,
                          color: Colors.black,
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none,
                        ),
                        hintText: "Quote Tweets"),
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                  ),
                  TextField(
                    controller: likesCount,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.thumb_up,
                          color: Colors.black,
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none,
                        ),
                        hintText: "Likes Count"),
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomSheetProfile() {
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
                  takePhotoProfile(ImageSource.camera);
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
                  takePhotoProfile(ImageSource.gallery);
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

  Widget bottomSheetImage() {
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
                  takePhotoImage(ImageSource.camera);
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
                  takePhotoImage(ImageSource.gallery);
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
}
