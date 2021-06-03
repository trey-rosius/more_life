import 'package:amp_auth/repository/profile_repository.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class CreatePostScreen extends StatefulWidget {
  CreatePostScreen({this.userId});
  final String userId;
  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    var profilePicUrl= context.watch<String>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Create A Post'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            profilePicUrl != null ?ClipOval(
                child: ClipRRect(
                    borderRadius:
                    new BorderRadius.circular(
                        30),
                    child: CachedNetworkImage(
                        width: 40.0,
                        height: 40.0,
                        fit: BoxFit.cover,
                        imageUrl: profilePicUrl,
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
                              radius: 20.0,
                              child: Icon(
                                Icons
                                    .account_circle,
                                color:
                                Colors.white,
                                size: 20.0,
                              ),
                            )))) : Container(),
          ],
        ),
      ),
    );
  }
}
