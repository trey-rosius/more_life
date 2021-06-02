import 'package:amp_auth/repository/profile_repository.dart';
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
    var profileRepo = context.read<ProfileRepository>();
    profileRepo.getUserProfile(widget.userId);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create A Post'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

          ],
        ),
      ),
    )
  }
}
