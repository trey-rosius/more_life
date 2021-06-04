import 'dart:io';
import 'dart:typed_data';

import 'package:amp_auth/models/User.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';

import 'package:image_cropper/image_cropper.dart';

import 'package:uuid/uuid.dart';

class ProfileRepository extends ChangeNotifier {

  ProfileRepository.instance();



  final firstNamesController = TextEditingController();
  final lastNamesController = TextEditingController();


  S3UploadFileOptions options;
  bool _loading = false;
  String _userId;
  String _username;
  String _email;


  String get email => _email;

  set email(String value) {
    _email = value;
    notifyListeners();
  }

  String get username => _username;

  set username(String value) {
    _username = value;
    notifyListeners();
  }

  String get userId => _userId;

  set userId(String value) {
    _userId = value;
    notifyListeners();
  }

  String _profilePic = "";
  String _profilePicKey ="";


  String get profilePicKey => _profilePicKey;

  set profilePicKey(String value) {
    _profilePicKey = value;
    notifyListeners();
  }

  String get profilePic => _profilePic;

  set profilePic(String value) {
    _profilePic = value;
    notifyListeners();
  }



  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }



  void showInSnackBar(BuildContext context,String value) {
    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
      ),
      backgroundColor: Theme.of(context).accentColor,
    ));
  }


  @override
  void dispose() {
    // TODO: implement dispose

    firstNamesController.dispose();
    lastNamesController.dispose();


    super.dispose();
  }

  Future<Null> cropImage(String imageFilePath,
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

      metadata['desc'] = 'A profile picture ';
      S3UploadFileOptions  options = S3UploadFileOptions(accessLevel: StorageAccessLevel.guest, metadata: metadata);
      try {
      UploadFileResult result  =  await Amplify.Storage.uploadFile(
            key: uuid,
            local: croppedFile,
            options: options
        );
      profilePicKey  = result.key;
      print("the key is "+profilePicKey);
      GetUrlResult resultDownload =
      await Amplify.Storage.getUrl(key: profilePicKey);
      print(resultDownload.url);
      profilePic = resultDownload.url;
      loading = false;

      } on StorageException catch (e) {
        print("error message is" + e.message);
       loading= false;
      }

    }
  }

  Future<String> retrieveEmail() async{
    var res = await Amplify.Auth.fetchUserAttributes();
    return res[4].value;
  }
  Future<AuthUser>retrieveCurrentUser() async{
    AuthUser authUser = await Amplify.Auth.getCurrentUser();
    return authUser;
  }


      // Handle your snapshot events...



  /// save user details to profile
  ///
  Future<void>saveUserProfileDetails() async{
  loading = true;
    User newUser = User(
        id:userId,username:username,firstName: firstNamesController.text.trim(),lastName: lastNamesController.text.trim(),
    profilePicUrl: profilePicKey,email: email,createdOn: TemporalDateTime.now(),isVerified: true);

    await Amplify.DataStore.save(newUser).then((_) => loading = false);





  }

Future<User>getUserProfile(String userId) async{

    List<User> user = await Amplify.DataStore.query(User.classType, where: User.ID.eq(userId));
    print(user[0]);

    return user[0];


}


}