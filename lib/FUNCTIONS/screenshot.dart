import 'dart:typed_data';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SCREENSHOT {
  Future<String> saveImage(Uint8List bytes) async {
    await [Permission.storage].request();

    const name = "Fake Tweet";
    final result = await ImageGallerySaver.saveImage(bytes, name: name,quality: 100);

    return result['filePath'];
  }
}
