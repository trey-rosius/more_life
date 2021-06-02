import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/cupertino.dart';

class LoginRepository extends ChangeNotifier{


  final usernameController = TextEditingController();
  bool _isSignedIn = false;
  bool _loading = false;
  bool _googleLoading = false;
  final passwordController = TextEditingController();


  bool get isSignedIn => _isSignedIn;

  set isSignedIn(bool value) {
    _isSignedIn = value;
    notifyListeners();
  }


  bool get googleLoading => _googleLoading;

  set googleLoading(bool value) {
    _googleLoading = value;
    notifyListeners();
  }

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void>retrieveUserAttributes() async{
    try {
      var res = await Amplify.Auth.fetchUserAttributes();
      res.forEach((element) {
        print('key: ${element.userAttributeKey}; value: ${element.value}');
      });
    } on AuthException catch (e) {
      print(e.message);
    }
  }
  Future<void>googleSignIn() async{
    googleLoading = true;
    try {
      var res = await Amplify.Auth.signInWithWebUI(provider: AuthProvider.google);


        isSignedIn = res.isSignedIn;


      if(isSignedIn){
        print("Google signed In");
        retrieveUserAttributes();
        googleLoading = false;
      }else{
        googleLoading = false;
      }
    } on AmplifyException catch (e) {
      print(e.message);
      googleLoading = false;
    }



  }
  Future<bool> login() async{
    loading = true;
    try {
      SignInResult res = await Amplify.Auth.signIn(
        username: usernameController.text.trim(),
        password: passwordController.text.trim(),
      );

        isSignedIn = res.isSignedIn;
        loading = false;
      if(isSignedIn){
        print("Google signed In");
        loading = false;
        retrieveUserAttributes();
      }else{
        loading = false;
      }

      return isSignedIn;
    } on AuthException catch (e) {
      print(e.message);
      loading = false;
      return isSignedIn;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }

}