import 'dart:io';

import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:uuid/uuid.dart';

class PostRepository extends ChangeNotifier{

  PostRepository.instance();

  bool _loading = false;


  bool get loading => _loading;
  String _postImageKey;
  String _postImageUrl;


  String get postImageKey => _postImageKey;

  set postImageKey(String value) {
    _postImageKey = value;
    notifyListeners();
  }
  String get postImageUrl => _postImageUrl;

  set postImageUrl(String value) {
    _postImageUrl = value;
    notifyListeners();
  }
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  final postTextController = TextEditingController();

  Future<Null> cropPostImage(String imageFilePath,
      BuildContext context, String targetPath) async {
    loading = true;
    var uuid =  Uuid().v1();

    File croppedFile = await ImageCropper.cropImage(
        sourcePath: imageFilePath,
        cropStyle: CropStyle.circle,
        aspectRatioPresets: Platform.isAndroid
            ? [CropAspectRatioPreset.square]
            : [
          CropAspectRatioPreset.square,
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: Theme.of(context).accentColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true),
        iosUiSettings: IOSUiSettings(
          title: 'Crop Image',
        ));
    if (croppedFile != null) {
      print("cropped file is" + croppedFile.path);
      loading = false;


      Map<String, String> metadata = <String, String>{};
      metadata['name'] = "user_$uuid";

      metadata['desc'] = 'post picture ';
      /**
       * Prepare to upload croppped image to s3
       */
      S3UploadFileOptions  options = S3UploadFileOptions(accessLevel: StorageAccessLevel.guest, metadata: metadata);
      try {
        UploadFileResult result  =  await Amplify.Storage.uploadFile(
            key: uuid,
            local: croppedFile,
            options: options
        );
        postImageKey  = result.key;
        print("the key is "+postImageKey);

        /**
         * Get url of the uploaded image to display on the frontend
         *
         */
        GetUrlResult resultDownload =
        await Amplify.Storage.getUrl(key: postImageKey);
        print(resultDownload.url);
        postImageUrl = resultDownload.url;
        loading = false;

      } on StorageException catch (e) {
        print("error message is" + e.message);
        loading= false;
      }

    }
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    postTextController.dispose();
  }


}