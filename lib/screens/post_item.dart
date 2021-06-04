import 'package:amp_auth/models/Post.dart';
import 'package:amp_auth/utils/app_theme.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
class PostItem extends StatefulWidget {
  PostItem(this.userId,this.post);
  final String userId;
  final Post post;

  @override
  _PostItemState createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  Future<GetUrlResult> resultDownload;
  void getUrl() async{
   // resultDownload = await Amplify.Storage.getUrl(key: widget.post.postImageUrl);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    resultDownload = Amplify.Storage.getUrl(key: widget.post.postImageUrl);


    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(

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
                              imageUrl: widget.post.user.profilePicUrl??"",
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
                    children: [
                      Text(widget.post.user.username??"",style: TextStyle(fontSize: 16,color: Colors.white),),
                      Text(timeago.format(widget.post.createdOn.getDateTimeInUtc()),style: TextStyle(color: Colors.grey),)
                    ],
                  )
                ],
              ),
            ),
            Text(widget.post.content),
            Container(


              child: ClipRRect(
                    borderRadius:
                    BorderRadius.circular(
                        5),
                    child:  CachedNetworkImage(

                        height: 200.0,
                        fit: BoxFit.cover,
                        imageUrl: widget.post.postImageUrl??"",
                        placeholder: (context,
                            url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context,
                            url, ex) =>
                            Container(


                              child: Icon(Icons.image,size: 200,),
                            )),
                  ),
            ),

          ],
        ),
      ),
    );
  }
}
