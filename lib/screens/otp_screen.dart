import 'package:amp_auth/screens/edit_profile.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {
  OtpScreen({this.username});
  final String username;
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  final _formKey = GlobalKey<FormState>();
  bool isSignUpComplete = false;
  final codeController = TextEditingController();

  Future<void> confirmUser() async{
    try {
      SignUpResult res = await Amplify.Auth.confirmSignUp(
          username: widget.username,
          confirmationCode: codeController.text.trim()
      );
      setState(() {
        isSignUpComplete = res.isSignUpComplete;
      });
      if(isSignUpComplete){
        print("Sign up is complete");
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return EditProfileScreen();
        }));
      }
    } on AuthException catch (e) {
      print(e.message);
    }
  }
  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    codeController.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("OtP Screen"),),
        body: Form(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
              child: Column(
                children: <Widget>[

                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      controller: codeController,
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Enter OTP Code',
                          hintText: 'Enter OTP Code'
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter OTP Code';
                        }
                        return null;
                      },
                    ),
                  ),


                  Container(
                    child: ElevatedButton(child: Text("Confirm Account"),onPressed: (){
                      if (_formKey.currentState.validate()) {
                        confirmUser();

                      }
                    },),
                  )


                ],
              ),
            ))
    );
  }
}
