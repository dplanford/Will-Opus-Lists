import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';

//import 'package:cached_network_image/cached_network_image.dart';

/// A set of functions for encoding/decoding Base64 images.
/// TODO: Not yet used until I get image storage working!
/// With later image usage:
///   - for local only, a simple link to the local image should work for most needs. No Base64 encoding needed.
///   - once I need to online server-side transmit/store/load the image, these base64 funcs will be useful?
///
class WillOpusEncodingHelper {
  static Image imageFromUint8List(Uint8List data) {
    return Image.memory(data);
  }

  static Image imageFromBase64(String base64) {
    return Image.memory(uintListFromBase64(base64));
  }

  /*
  static CachedNetworkImage imageFromNetworkPath(String path) {
    return CachedNetworkImage(imageUrl: path);
  }
  */

  static Image imageFromPath(String path) {
    return (Image.file(File(path)));
  }

  static Uint8List uintListFromBase64(String base64) {
    return base64Decode(base64);
  }

  static Uint8List uint8ListFromFile(File file) {
    return Uint8List(0);
  }

  static Future<String> base64FromFile(File file) async {
    return base64Encode(await file.readAsBytes());
  }

  static Future<String> base64FromPath(String path) async {
    return base64Encode(await File(path).readAsBytes());
  }

  static String base64FromUint8List(Uint8List data) {
    return base64Encode(data);
  }
}
