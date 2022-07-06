// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, prefer_final_fields

import 'package:fake_tweet/tweet.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'MODEL/model_tweet.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter<ModelTweet>(ModelTweetAdapter());
  await Hive.openBox<ModelTweet>("modelTweet");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // darkTheme: ThemeData.dark(),
      theme: ThemeData(appBarTheme: AppBarTheme(color: Colors.white70)),
      home: TWEET(),
    );
  }
}

/*
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
  */
