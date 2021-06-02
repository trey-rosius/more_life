import 'package:amp_auth/screens/otp_screen.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {


  final _formKey = GlobalKey<FormState>();
  bool isSignUpComplete = false;
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> register() async{
    try {
      Map<String, String> userAttributes = {
        'email': emailController.text.trim(),
        'phone_number': '+15559101234',
        // additional attributes as needed
      };
      SignUpResult res = await Amplify.Auth.signUp(
          username: usernameController.text.trim(),
          password: passwordController.text.trim(),
          options: CognitoSignUpOptions(
              userAttributes: userAttributes
          )
      );
      setState(() {
        isSignUpComplete = res.isSignUpComplete;
      });
      if(isSignUpComplete){
        print("we in here");
       Navigator.push(context, MaterialPageRoute(builder: (context){
         return OtpScreen(username: usernameController.text.trim(),);
       }));
      }
    } on AuthException catch (e) {
      print(e.message);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("register account"),centerTitle: true,),
      body: Form(
    key: _formKey,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      child: Column(
      children: <Widget>[

        Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: TextFormField(
            controller: usernameController,
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter your username',
              hintText: 'Enter you username'
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
            controller: emailController,
            decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter your email',
                hintText: 'Enter your email'
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter your email';
              }
              return null;
            },
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: TextFormField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter your password',
                hintText: 'Enter your password'
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a password';
              }
              return null;
            },
          ),
        ),

        Container(
          child: ElevatedButton(child: Text("Register"),onPressed: (){
    if (_formKey.currentState.validate()) {
      register();

    }
          },),
        )


      ],
      ),
    ))
    );
  }
}
