import 'package:amp_auth/models/Comment.dart';
import 'package:amp_auth/models/Post.dart';
import 'package:amp_auth/models/User.dart';
import 'package:amp_auth/repository/comments_repository.dart';
import 'package:amp_auth/repository/profile_repository.dart';
import 'package:amp_auth/screens/comments/comments_screen.dart';
import 'package:amp_auth/utils/app_theme.dart';
import 'package:amp_auth/utils/size_config.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
class CommentItem extends StatelessWidget {
  CommentItem (this.userId,this.comment);
  final String userId;
  final Comment comment;


  @override
  Widget build(BuildContext context) {

    return Container(

      margin: EdgeInsets.only(left: 40,right: 10),
      child:  Container(
        padding: EdgeInsets.only(left: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureProvider.value(value: ProfileRepository.instance().getUserProfile(comment.userId),
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
                                      width: 30.0,
                                      height: 30.0,
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
                              Text(user.username,style: TextStyle(fontSize: 13,color: Colors.white)),
                              Text(timeago.format(comment.createdOn.getDateTimeInUtc()),style: TextStyle(color: Colors.grey),)
                            ],
                          )
                        ],
                      ),
                    );
                  }else{
                    return  Container(
                        height: 40,
                        width: 40,
                        child: CircularProgressIndicator()
                    );
                  }
                })),


            Container(
                padding: EdgeInsets.only(left: 50.toWidth),
                child: Text(comment.commentText,style: TextStyle(color: Colors.white),))


          ],
        ),
      ),

    );
  }
}
