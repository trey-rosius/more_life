import 'package:amp_auth/models/Comment.dart';
import 'package:amp_auth/models/Post.dart';
import 'package:amp_auth/models/User.dart';
import 'package:amp_auth/repository/comments_repository.dart';
import 'package:amp_auth/repository/profile_repository.dart';
import 'package:amp_auth/utils/app_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
class CommentsScreen extends StatefulWidget {
     CommentsScreen({this.userId,this.post});
     final String userId;
     final Post post;
  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.black,
      appBar: AppBar(title: Text("Post"),),
      body: FutureProvider.value(value: CommentsRepository.instance().queryAllCommentsForPost(widget.post.id),
        catchError: (context,error){
        print(error.toString());
        },
        child: Consumer(builder: (key,List<Comment> commentList, child){
            if(commentList != null){
              return ListView.builder(itemBuilder: (context,index){
               return index == 0 ?
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child:  Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        FutureProvider.value(value: ProfileRepository.instance().getUserProfile(widget.post.userID),
                            catchError: (context,error){
                              print(error);
                            },child: Consumer(builder: (_,User user,child){
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
                                          Text(timeago.format(widget.post.createdOn.getDateTimeInUtc()),style: TextStyle(color: Colors.grey),)
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

                ):
                   Container();
              },itemCount: commentList.length+1,);
            }else{
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
        },),
      )
    );
  }
}
