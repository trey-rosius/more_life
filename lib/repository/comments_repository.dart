import 'dart:io';
import 'dart:typed_data';

import 'package:amp_auth/models/Comment.dart';
import 'package:amp_auth/models/Post.dart';
import 'package:amp_auth/models/User.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';

import 'package:image_cropper/image_cropper.dart';

import 'package:uuid/uuid.dart';

class CommentsRepository extends ChangeNotifier {

   CommentsRepository.instance();



  final commentController = TextEditingController();



  S3UploadFileOptions? options;
  bool _loading = false;
  String? _userId;


  String? get userId => _userId;

   set userId(String? value) {
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

    commentController.dispose();



    super.dispose();
  }

  Future<List<Comment>>queryAllCommentsForPost(String postId) async{
    List<Comment> comments= await Amplify.DataStore.query(Comment.classType,
        where: Comment.POSTID.eq(postId),
        sortBy: [Comment.CREATEDON.descending()]);

    print("comments are "+comments.toString());
    return comments;
  }

  Future<bool> createComment(String userId,Post post) async{
    loading = true;
    /**
     * first retrieve user model
     */
    try {


      Comment comment = Comment(commentText: commentController.text.trim(),userId: userId,
          postID:post.id,post: post,createdOn: TemporalDateTime.now(),  updatedOn: TemporalDateTime.now());

      await Amplify.DataStore.save(comment);
      loading = false;
      return true;
    }catch(ex){
      print(ex.toString());
      loading = false;
      return false;
    }
  }



}