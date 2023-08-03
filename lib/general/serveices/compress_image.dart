import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:filesize/filesize.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

Future<Uint8List> compressImage(File file) async {
  log(filesize(file.lengthSync().toString()));
  final list = await file.readAsBytes();
  var result = await FlutterImageCompress.compressWithList(
    list,
    minHeight: 650,
    minWidth: 500,
    quality: 70,
  );
  log(filesize(result.lengthInBytes.toString()));
  return result;
}
