import 'package:amp_auth/models/User.dart';
import 'package:amp_auth/repository/profile_repository.dart';
import 'package:amp_auth/utils/app_theme.dart';
import 'package:amp_auth/utils/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen(this.userId);
  final String userId;
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColor.black,
      body: CustomScrollView(
        slivers: [
          FutureProvider.value(value: ProfileRepository.instance().getUserProfile(widget.userId),
          catchError: (context,error){
            print(error);
          },child: Consumer(builder: (_,User user,child){
            if(user != null){
              return SliverToBoxAdapter(
                child: Container(
                  height: 300.toHeight,
                  padding: EdgeInsets.only(top: 30),

                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(width: 2,color: ThemeColor.secondary),
                            borderRadius: BorderRadius.circular(50)
                        ),
                        child: ClipOval(
                            child: ClipRRect(
                              borderRadius:
                              BorderRadius.circular(
                                  10),
                              child:  CachedNetworkImage(
                                  width: 120.0,
                                  height: 120.0,
                                  fit: BoxFit.cover,
                                  imageUrl: "",
                                  placeholder: (context,
                                      url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context,
                                      url, ex) =>
                                      CircleAvatar(
                                        radius: 30,
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
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(user.firstName,style: TextStyle(fontSize: 20,color: ThemeColor.secondary),),
                                Text(" "),
                                Text(user.lastName,style: TextStyle(fontSize: 20,color: ThemeColor.secondary),)
                              ],
                            ),
                            Container(
                              child: Text('@'+ user.username,style: TextStyle(fontSize: 18,color: ThemeColor.primary),),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }else{
              return SliverToBoxAdapter(child: SizedBox(),);
            }
    },))
        ],
      ),
    );
  }
}
