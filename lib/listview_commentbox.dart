// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:fake_tweet/MODEL/data_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ListViewCommentBox extends StatefulWidget {
  final List<MODELDATA> list;

  const ListViewCommentBox({
    Key? key,
    required this.list,
  }) : super(key: key);

  @override
  State<ListViewCommentBox> createState() => _ListViewCommentBoxState();
}

class _ListViewCommentBoxState extends State<ListViewCommentBox> {
  final ImagePicker _profileImage = ImagePicker();
  PickedFile? _profileImagePick;

  late TextEditingController textEditingController = TextEditingController();

  bool valuefirst = false;
  bool isVisibleMainImage = true;
  bool isVisibleProtectedIcon = false;
  bool isVisibleVerifiedIcon = true;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: widget.list.length,
        itemBuilder: (context, index) {
          return Row(
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
                  radius: 27,
                  backgroundImage: _profileImagePick != null
                      ? FileImage(File(_profileImagePick!.path)) as ImageProvider
                      : AssetImage("assets/images/profile.jpg"),
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
                                setState(() =>
                                    widget.list[index].profileName = profile);
                              },
                              child: Text(
                                widget.list[index].profileName,
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
                                backgroundImage:
                                    AssetImage("assets/images/verified.png"),
                              ),
                            SizedBox(width: 2),
                            if (isVisibleProtectedIcon)
                              CircleAvatar(
                                radius: 7,
                                backgroundColor: Colors.white,
                                backgroundImage:
                                    AssetImage("assets/images/lock.png"),
                              ),
                            SizedBox(width: 5),
                            GestureDetector(
                              onTap: () async {
                                final user = await openDialogue();
                                if (user!.isEmpty) {
                                  return;
                                }
                                setState(() =>
                                    widget.list[index].userNameGrey = user);
                              },
                              child: Text(
                                widget.list[index].userNameGrey,
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Text(
                              " · ",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              "2m",
                              style: TextStyle(
                                fontSize: 15,
                              ),
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
                            setState(
                                () => widget.list[index].userNameBlue = user);
                          },
                          child: Row(
                            children: [
                              Text(
                                "Replying to",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(width: 5),
                              Text(
                                widget.list[index].userNameBlue,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 8),
                        GestureDetector(
                          onTap: () async {
                            final reply = await openDialogue();
                            if (reply!.isEmpty) {
                              return;
                            }
                            setState(
                                () => widget.list[index].typeReply = reply);
                          },
                          child: Text(
                            widget.list[index].typeReply,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),

                        //COMMENT ICONS

                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.comment_outlined,
                                size: 18,
                              ),
                              Icon(
                                Icons.repeat_outlined,
                                size: 18,
                              ),
                              Icon(
                                Icons.favorite_outline,
                                size: 18,
                              ),
                              Icon(
                                Icons.share_outlined,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),

                    //  POP UP MENU BUTTON

                    PopupMenuButton(
                        itemBuilder: (context) => [
                              PopupMenuItem(
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
                                value: 0,
                              ),
                              PopupMenuItem(
                                child: GestureDetector(
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
                                value: 2,
                              ),
                              PopupMenuItem(
                                child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        widget.list.removeAt(index);
                                        Navigator.pop(context);
                                      });
                                    },
                                    child: Text("Delete")),
                                value: 3,
                              ),
                            ]),
                  ],
                ),
              ),
            ],
          );
        },
      ),
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

  void takePhoto(
    ImageSource source,
  ) async {
    final pickedFile = await _profileImage.getImage(
      source: source,
    );
    setState(() {
      _profileImagePick = pickedFile!;
    });

    // setState((){
    //   widget.list[0].image = _profileImagePick! as AssetImage;
    //   _profileImagePick = pickedFile!;
    // });
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
