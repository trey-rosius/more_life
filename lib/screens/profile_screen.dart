import 'package:amp_auth/models/User.dart';
import 'package:amp_auth/repository/profile_repository.dart';
import 'package:amp_auth/screens/edit_profile_screen.dart';
import 'package:amp_auth/utils/app_theme.dart';
import 'package:amp_auth/utils/size_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
                  height: 250.toHeight,
                  padding: EdgeInsets.only(top: 3),

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
                      ),

                    ],
                  ),
                ),
              );
            }else{
              return SliverToBoxAdapter(child: SizedBox(),);
            }
    },)),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 50.toHeight,
                    width: SizeConfig.screenWidth/2.5,
                    child: ElevatedButton(
                      style: ButtonStyle(

                        backgroundColor: MaterialStateProperty.all(ThemeColor.secondary),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                      ),
                        onPressed: (){

                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            // return RegisterScreen();
                            //return LoginScreen();

                            return ChangeNotifierProvider(create: (_)=>ProfileRepository.instance(),
                              child: EditProfileScreen(),);


                          }));

                    }, child: Text("Edit Profile")),
                  ),
                  Container(
                    height: 50.toHeight,
                    width: SizeConfig.screenWidth/2.5,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(ThemeColor.primary),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                        ),
                        onPressed: (){

                        }, child: Text("Ratings")),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    elevation: 10,
                    color: ThemeColor.primary,
                    child: Container(

                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(


                            decoration: BoxDecoration(
                                color: Colors.black,
                              borderRadius: BorderRadius.circular(10)
                            ),
                            padding:EdgeInsets.all(15),
                            child: SvgPicture.asset(
                              'assets/svg/trophy.svg',
                              fit: BoxFit.cover,
                              height: 30,
                              width: 30,
                              color: Colors.white,

                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            child:Text("Achievements",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 16),),
                          ),
                          Container(
                            child: Stack(
                              children: [
                                Container(
                                    margin: EdgeInsets.only(left: 5),
                                  padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(20)
                                    ),

                                    child: Text("🥰")),
                                Container(
                                    margin: EdgeInsets.only(left: 30),
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(20)
                                    ),

                                    child: Text("❤️")),
                                Container(
                                    margin: EdgeInsets.only(left: 50),
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(20)
                                    ),

                                    child: Text('😡')),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}