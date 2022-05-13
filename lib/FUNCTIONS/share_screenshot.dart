// ignore_for_file: camel_case_types
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

class SHARE_SCREENSHOT {
  Future shareImage(Uint8List bytes) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      var image = File('${directory.path}/image.png');
      image.writeAsBytesSync(bytes);
      await Share.shareFiles([image.path]);
    } catch (e) {
      print("Error is $e");
    }
  }
}
