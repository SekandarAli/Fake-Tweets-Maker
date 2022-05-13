// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, prefer_final_fields

import 'package:fake_tweet/FUnctions/screenshot.dart';
import 'package:fake_tweet/PROFILE/profile_page.dart';
import 'package:fake_tweet/listview_commentbox.dart';
import 'package:fake_tweet/tweet.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'MODEL/data_model.dart';
import 'WIDGETS/commentbox.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ScreenshotController _screenshotController = ScreenshotController();

  final SCREENSHOT _screenshot = SCREENSHOT();


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // darkTheme: ThemeData.dark(),
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "FAKE TWEET",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            GestureDetector(
                onTap: () async {
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
                child: Icon(Icons.save)),
            SizedBox(width: 15),
            Icon(Icons.refresh),
            SizedBox(width: 15),
            GestureDetector(
                onTap: () async {
                  await Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                        return PROFILEPAGE();
                      }));
                },
                child: Icon(Icons.person)),
            PopupMenuButton<int>(
              onSelected: (item) => handleClick(item),
              itemBuilder: (context) => [
                PopupMenuItem<int>(value: 0, child: GestureDetector(

                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return PROFILEPAGE();
                          }));
                    },
                    child: Text('Profile'))),
                PopupMenuItem<int>(value: 4, child: Text('Themes')),
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
            child: TWEET(),
          ),
        ),
      ),
    );
  }

  handleClick(int item) {
    switch (item) {
      case 0:
        break;
      case 1:
        break;
      case 2:
        break;
      case 3:
        break;
    }
  }
}
