import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sofigram/utilities/constants.dart';
import 'package:uuid/uuid.dart';

class StorageService {
  static Future<String> uploadUserProfileImage(
      String url, File imageFile) async {
    String photoId = Uuid().v4();
    File image = await compressImage(photoId, imageFile);

    if(url.isNotEmpty){
      //updating
      RegExp exp = RegExp(r'userProfile_(.*).jpg');
      photoId = exp.firstMatch(url)[1];
      print(photoId);
    }

    StorageUploadTask uploadTask = storageref
        .child('images/users/userProfile_$photoId.jpg')
        .putFile(image);
        StorageTaskSnapshot storageSnap = await uploadTask.onComplete;
        String downloadUrl = await storageSnap.ref.getDownloadURL();
        return downloadUrl;
  }

  static Future<File> compressImage(String photoId, File image) async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    File compressedImageFile = await FlutterImageCompress.compressAndGetFile(
        image.absolute.path, '$path/img_$photoId.jpg',
        quality: 70);
    return compressedImageFile;
  }
}
