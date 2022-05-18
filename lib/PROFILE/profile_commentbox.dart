// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:fake_tweet/MODEL/data_model.dart';
import 'package:fake_tweet/MODEL/profile_model.dart';
import 'package:fake_tweet/PROFILE/profile_previous_data.dart';
import 'package:fake_tweet/tweet.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileCommentBox extends StatefulWidget {
  final List<ProfileModelData> list;

  const ProfileCommentBox({Key? key, required this.list}) : super(key: key);

  @override
  State<ProfileCommentBox> createState() => _ProfileCommentBoxState();
}

class _ProfileCommentBoxState extends State<ProfileCommentBox> {
  final ImagePicker _profileImage = ImagePicker();
  PickedFile? _profileImagePick;

  late TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: widget.list.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PreviousData(),
                settings: RouteSettings(
                  arguments: widget.list[index].profileName,
                ),
              )),

//          Navigator.pop(context,widget.list[index].profileName),

          child: Padding(
            padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
            child: Card(
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: ((builder) {
                              return bottomSheet();
                            }),
                          );
                        },
                        child: CircleAvatar(
                          radius: 35,
                          backgroundImage: _profileImagePick != null
                              ? FileImage(File(_profileImagePick!.path))
                                  as ImageProvider
                              : AssetImage("assets/images/profile2.png"),
                        ),
                      ),
                      SizedBox(width: 20),
                      //Profile name/Username

                      Flexible(
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    final profile = await openDialogue();
                                    if (profile!.isEmpty) {
                                      return;
                                    }
                                    setState(() => widget
                                        .list[index].profileName = profile);
                                  },
                                  child: Text(
                                    widget.list[index].profileName,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                GestureDetector(
                                  onTap: () async {
                                    final user = await openDialogue();
                                    if (user!.isEmpty) {
                                      return;
                                    }
                                    setState(() =>
                                        widget.list[index].userName = user);
                                  },
                                  child: Text(
                                    widget.list[index].userName,
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.list.removeAt(index);
                          });
                        },
                        child: Icon(
                          Icons.delete,
                          size: 35,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20)
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  bottomSheet() {
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
}
