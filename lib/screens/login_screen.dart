import 'dart:async';

import 'package:amp_auth/repository/login_repository.dart';
import 'package:amp_auth/repository/profile_repository.dart';
import 'package:amp_auth/screens/create_profile_screen.dart';
import 'package:amp_auth/screens/edit_profile_screen.dart';
import 'package:amp_auth/utils/app_theme.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:amp_auth/utils/size_config.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();
  StreamSubscription hubSubscription;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("in here");
     hubSubscription = Amplify.Hub.listen([HubChannel.Auth], (hubEvent) {
      switch(hubEvent.eventName) {
        case "SIGNED_IN": {

          print("USER IS SIGNED IN");
        }
        break;
        case "SIGNED_OUT": {
          print("USER IS SIGNED OUT");
        }
        break;
        case "SESSION_EXPIRED": {
          print("USER IS SIGNED IN");
        }
        break;
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    hubSubscription.cancel();

  }



  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ChangeNotifierProvider(create: (_)=> LoginRepository(),
    child: Consumer(builder: (_,LoginRepository loginRep,child){
      return Scaffold(
          appBar: AppBar(title: Text("Login to account"),centerTitle: true,elevation: 0.0,),
          body: SingleChildScrollView(
            child: Container(
              color: ThemeColor.bgColor,
              height: SizeConfig.screenHeight,
              child: Column(
                children: [

                  Container(
                      child:Column(
                        children: [
                          Text('More ',style: TextStyle(fontSize: 35,fontFamily: 'Pacifico',color: Colors.white),),
                          Text('life',style: TextStyle(fontSize: 40,fontFamily: 'Pacifico',color: Colors.white),),

                        ],
                      )
                  ),
                  Form(
                      key: _formKey,
                      child: Container(

                        padding: EdgeInsets.symmetric(horizontal: 30,vertical: 20),
                        child: Column(
                          children: <Widget>[

                            Container(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: TextFormField(
                                controller: loginRep.usernameController,
                                style: TextStyle(color: ThemeColor.white),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey[700], width: 2.toWidth),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.toWidth),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey[700], width: 2.toWidth),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.toWidth),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: ThemeColor.primary, width: 2.toWidth),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.toWidth),
                                    ),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey[700], width: 2.toWidth),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.toWidth),
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15.toWidth,
                                    vertical: 20.toHeight,
                                  ),
                                  hintText: "Please enter Username",
                                  hintStyle: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 15.toFont,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a username';
                                  }
                                  return null;
                                },
                              ),
                            ),

                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: TextFormField(
                                controller: loginRep.passwordController,
                                obscureText: true,
                                style: TextStyle(color: ThemeColor.white),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey[700], width: 2.toWidth),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.toWidth),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey[700], width: 2.toWidth),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.toWidth),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: ThemeColor.primary, width: 2.toWidth),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.toWidth),
                                    ),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey[700], width: 2.toWidth),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.toWidth),
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15.toWidth,
                                    vertical: 20.toHeight,
                                  ),
                                  hintText: 'Please enter a password',
                                  hintStyle: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 15.toFont,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a password';
                                  }
                                  return null;
                                },
                              ),
                            ),

                         loginRep.loading? Container(
                           padding: EdgeInsets.all(10),
                           margin: EdgeInsets.all(20),
                           child: Center(child: CircularProgressIndicator()),
                         ) :   Container(
                              margin: EdgeInsets.all(20),
                              width: SizeConfig.screenWidth,
                              height: 50.toHeight,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(

                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment(0.8, 0.0), // 10% of the width, so there are ten blinds.
                                  colors: [ThemeColor.primary,ThemeColor.secondary], // red to yellow
                                  tileMode: TileMode.repeated, // repeats the gradient over the canvas
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),

                              ),
                              child: TextButton(

                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    loginRep.login().then((bool isSignedIn){
                                      if(isSignedIn) {
                                        print("signed In");

                                        Navigator.push(context, MaterialPageRoute(builder: (context){
                                          return ChangeNotifierProvider(create: (_)=>ProfileRepository.instance(),

                                           child: CreateProfileScreen());
                                        }));


                                      }
                                    });

                                  }
                                },
                                child:Text("Log In",style: TextStyle(fontSize: 20,color: Colors.white),
                                ),
                              ),
                            ),


                            loginRep.googleLoading? Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.all(20),
                              child: Center(child: CircularProgressIndicator()),
                            ) :  Container(
                              margin: EdgeInsets.all(20),
                              width: SizeConfig.screenWidth,
                              height: 80.toHeight,
                              padding: EdgeInsets.all(20),
                              child: ElevatedButton(

                                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(ThemeColor.secondary),
                                ),
                                child: Text("Sign in With Google",style: TextStyle(fontSize: 18),),
                                onPressed: (){
                                  loginRep.googleSignIn();
                                },
                              ),

                            ),
                            TextButton(onPressed: (){
                              try {
                                Amplify.Auth.signOut();
                              } on AuthException catch (e) {
                                print(e.message);
                              }
                            }, child: Text("Log out"))

                          ],
                        ),
                      )),
                ],
              ),
            ),
          )
      );
    },),);
  }
}
