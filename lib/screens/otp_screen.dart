import 'package:amp_auth/repository/login_repository.dart';
import 'package:amp_auth/repository/profile_repository.dart';
import 'package:amp_auth/screens/create_profile_screen.dart';
import 'package:amp_auth/screens/edit_profile_screen.dart';
import 'package:amp_auth/utils/app_theme.dart';
import 'package:amp_auth/utils/size_config.dart';
import 'package:amp_auth/utils/validations.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OtpScreen extends StatefulWidget {
  OtpScreen({required this.username,required this.password,required this.email});
  final String username;
  final String password;
  final String email;
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _formKey = GlobalKey<FormState>();




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ThemeColor.bgColor,
        appBar: AppBar(
          title: Text("OTP Screen"),
        ),
        body: ChangeNotifierProvider.value(
            value: LoginRepository.instance(),
            child: Consumer(builder: (_, LoginRepository loginRepo, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Form(
                      key: _formKey,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: TextFormField(
                                  controller: loginRepo.codeController,
                                  obscureText: true,
                                  style: TextStyle(color: ThemeColor.white),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: (Colors.grey[700])!,
                                          width: 2.toWidth),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.toWidth),
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: (Colors.grey[700])!,
                                          width: 2.toWidth),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.toWidth),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: ThemeColor.primary,
                                          width: 2.toWidth),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.toWidth),
                                      ),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:(Colors.grey[700])!,
                                          width: 2.toWidth),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.toWidth),
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 15.toWidth,
                                      vertical: 20.toHeight,
                                    ),
                                    hintText: 'Please enter OTP Code',
                                    hintStyle: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 15.toFont,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  validator: (value) =>
                                      Validations.validateOTP(value!)),
                            ),
                            loginRepo.loading? Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.all(20),
                              child: Center(child: CircularProgressIndicator()),
                            ) :  Container(
                              margin: EdgeInsets.all(20),
                              width: SizeConfig.screenWidth,
                              height: 50.toHeight,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment(0.8,
                                      0.0), // 10% of the width, so there are ten blinds.
                                  colors: [
                                    ThemeColor.primary,
                                    ThemeColor.secondary
                                  ], // red to yellow
                                  tileMode: TileMode
                                      .repeated, // repeats the gradient over the canvas
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              child: TextButton(
                                child: Text("Confirm Account",style: TextStyle(fontSize: 20,color: Colors.white),),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    loginRepo.confirmUser(widget.username,widget.password,widget.email).then((bool value) {
                                      if(value){
                                       // Navigator.pushAndRemoveUntil(context, newRoute, (route) => false);
                                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                                          return ChangeNotifierProvider(create: (_)=>ProfileRepository.instance(),
                                            child:  CreateProfileScreen(email: widget.email,),
                                          );

                                        }));
                                      }else{
                                        print("couldn't Sign User In");
                                      }
                                    });
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                      )),
                ],
              );
            })));
  }
}
