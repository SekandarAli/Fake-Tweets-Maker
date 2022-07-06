// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, must_be_immutable, use_key_in_widget_constructors

import 'package:fake_tweet/MODEL/model_tweet.dart';
import 'package:fake_tweet/PROFILE/profile_add_data.dart';
import 'package:fake_tweet/PROFILE/profile_tile.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage(
      {this.tileProfileName,
      this.tileLike,
      this.tileMainTweet,
      this.tileQuoteTweet,
      this.tileReTweet,
      this.tileProfileImage,
      this.tileUserName,

      Key? key});

  String? tileProfileName;
  String? tileUserName;
  String? tileMainTweet;
  String? tileReTweet;
  String? tileQuoteTweet;
  String? tileLike;

  MemoryImage? tileProfileImage;
  MemoryImage? tileMainTweetImage;


  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: ValueListenableBuilder<Box<ModelTweet>>(
          valueListenable: Hive.box<ModelTweet>("modelTweet").listenable(),
          builder: (context, box, _) {
            final _items = box.values.toList().cast<ModelTweet>();

            if (_items.isEmpty) {
              return SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_ios_outlined,
                              color: Colors.black,
                              size: 30,
                            ),
                          ),
                          Text(
                            "Fake Profiles",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(""),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 400,
                        child: Image.asset(
                          'assets/images/robot.png',
                          alignment: Alignment.center,
                        ),
                      ),
                      Text(
                        "No Profile Found",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(
                            Icons.arrow_back_ios_outlined,
                            color: Colors.black,
                            size: 30,
                          ),
                        ),
                        Text(
                          "Fake Profiles",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 35,
                            )),
                      ],
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        itemCount: box.values.length,
                        itemBuilder: (context, index) {
                          ModelTweet? currentTask = box.getAt(index);
                          return ProfileTile(
                            task: currentTask!,
                            index: index,
                            tileProfileName: widget.tileProfileName,
                            tileUserName: widget.tileUserName,
                            tileMainTweet: widget.tileMainTweet,
                            tileReTweet: widget.tileReTweet,
                            tileQuoteTweet: widget.tileQuoteTweet,
                            tileLike: widget.tileLike,
                            tileProfileImage:widget.tileProfileImage,
                            tileMainTweetImage :widget.tileMainTweetImage,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            showDialog(
                context: context,
                builder: (_) => AlertDialog(
                      insetPadding: EdgeInsets.only(top: 40),
                      contentPadding: EdgeInsets.zero,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      content: Builder(
                        builder: (context) {
                          return SizedBox(
                            height: double.infinity,
                            width: double.infinity,
                            child: ProfileAddData(),
                          );
                        },
                      ),
                    ));
          },
          label: Text(
            "Add Profile",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          icon: const Icon(Icons.add),
          backgroundColor: Colors.grey.shade800,
        ),
      ),
    );
  }
}
