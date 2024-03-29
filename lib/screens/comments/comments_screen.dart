import 'package:amp_auth/models/Comment.dart';
import 'package:amp_auth/models/Post.dart';
import 'package:amp_auth/models/User.dart';

import 'package:amp_auth/repository/comments_repository.dart';
import 'package:amp_auth/repository/profile_repository.dart';

import 'package:amp_auth/screens/comments/comment_item.dart';
import 'package:amp_auth/screens/comments/post_comment_item.dart';

import 'package:amp_auth/utils/app_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
class CommentsScreen extends StatefulWidget {
     CommentsScreen({required this.userId,required this.post});
     final String userId;
     final Post post;
  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {

  Widget buildInput(CommentsRepository commentsRepository) {

    return
      Container(
        // color: Colors.red,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Row(
              children: <Widget>[
                // Button send image
                Container(
                  margin: EdgeInsets.only(left: 10.0),
                  decoration: BoxDecoration(
                      color: ThemeColor.primary,
                      shape: BoxShape.circle),
                  child: IconButton(
                    icon: new Icon(Icons.camera_alt),
                    //  onPressed: ()=>getImageFromCamera(chatRepo),
                    onPressed:() {


                    },
                    color: Colors.white,
                  ),
                ),





                // Edit text
                Flexible(
                  child: Container(
                    // margin: EdgeInsets.symmetric(horizontal: 10.0,vertical: 15.0),
                    //  padding: EdgeInsets.symmetric(vertical: 10.0),


                    child: Scrollbar(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        reverse: true,
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          child: TextField(
                            maxLines: null,
                            onChanged: (String text) {
                              if (text.trim().length > 0) {

                              } else {



                              }
                            },


                            style: TextStyle(color: Colors.white, fontSize: 15.0),
                            controller: commentsRepository.commentController,
                            decoration: InputDecoration(
                              hintText: 'leave a comment....',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Button send message
                Container(
                  margin: new EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: BoxDecoration(
                      color: ThemeColor.secondary,
                      shape: BoxShape.circle),
                  child: Center(
                    child: new IconButton(
                      icon: new Icon(Icons.arrow_forward),
                      onPressed: () {
                   if(commentsRepository.commentController.text.length > 0){
                     commentsRepository.createComment(widget.userId,widget.post).then((_){
                       commentsRepository.commentController.clear();
                     });

                   }
                      },
                      color: Colors.white,
                    ),
                  ),
                ),

              ],


            ),
          ],
        ),
      );
  }
  @override
  Widget build(BuildContext context) {
    var commentsRepo = context.watch<CommentsRepository>();
    return Scaffold(
      backgroundColor: ThemeColor.black,
      appBar: AppBar(title: Text("Comments",),centerTitle: true,),
      body: Column(
        children: [
          FutureProvider.value(value: CommentsRepository.instance().queryAllCommentsForPost(widget.post.id),
            catchError: (context,error){
            print(error.toString());
            },
            initialData: [],
            child: Consumer(builder: (key,List<Comment>? commentList, child){
                if(commentList != null){
                 print("in here"+commentList.toString());
                  return Flexible(
                    child: ListView.builder(

                      itemBuilder: (context,index){

                        if(index == 0){
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            child:  Container(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  FutureProvider.value(value: ProfileRepository.instance().getUserProfile(widget.post.userID!),
                                      catchError: (context,error){
                                        print(error);
                                      },initialData: null,
                                      child: Consumer(builder: (_,User? user,child){
                                        if(user != null){
                                          return  Container(

                                            child: Row(
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(width: 2,color: ThemeColor.secondary),
                                                      borderRadius: BorderRadius.circular(100)
                                                  ),
                                                  child: ClipOval(
                                                      child: ClipRRect(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                        child:  CachedNetworkImage(
                                                            width: 40.0,
                                                            height: 40.0,
                                                            fit: BoxFit.cover,
                                                            imageUrl: user.profilePicUrl??"",
                                                            placeholder: (context,
                                                                url) =>
                                                                CircularProgressIndicator(),
                                                            errorWidget: (context,
                                                                url, ex) =>
                                                                CircleAvatar(
                                                                  backgroundColor:
                                                                  Theme.of(
                                                                      context)
                                                                      .accentColor,

                                                                  child: Icon(
                                                                    Icons
                                                                        .account_circle,
                                                                    color:
                                                                    Colors.white,

                                                                  ),
                                                                )),
                                                      )),
                                                ),
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(user.username,style: TextStyle(fontSize: 16,color: Colors.white)),
                                                    Text(timeago.format(widget.post.createdOn!.getDateTimeInUtc()),style: TextStyle(color: Colors.grey),)
                                                  ],
                                                )
                                              ],
                                            ),
                                          );
                                        }else{
                                          return Container(
                                              height: 40,
                                              width: 40,
                                              child: CircularProgressIndicator()
                                          );
                                        }
                                      })),


                                  Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [ThemeColor.primary, ThemeColor.secondary],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),

                                      borderRadius: BorderRadius.only(topRight: Radius.circular(10.0),topLeft: Radius.circular(10.0),
                                          bottomLeft: Radius.circular(10.0),bottomRight: Radius.circular(10.0)),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(child: Container(
                                                padding: EdgeInsets.all(10),
                                                child: Text(widget.post.content,style: TextStyle(color: Colors.white),))),
                                            Container(


                                              child: ClipRRect(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    5),
                                                child:  CachedNetworkImage(

                                                    height: 100.0,
                                                    width: 100.0,
                                                    fit: BoxFit.cover,
                                                    imageUrl: widget.post.postImageUrl??"",
                                                    placeholder: (context,
                                                        url) =>
                                                        CircularProgressIndicator(),
                                                    errorWidget: (context,
                                                        url, ex) =>
                                                        Container(


                                                          child: Icon(Icons.image,size: 100,),
                                                        )),
                                              ),
                                            ),
                                          ],
                                        ),

                                      ],
                                    ),
                                  ),


                                ],
                              ),
                            ),

                          );
                        }else{
                          index -= 1;
                          return CommentItem(widget.userId,commentList[index]);
                        }

                      },itemCount: commentList.length+1,),
                  );
                }else{
                  return Flexible(
                    child: Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  );
                }
            },),
          ),
          buildInput(commentsRepo)
        ],
      )
    );
  }
}
