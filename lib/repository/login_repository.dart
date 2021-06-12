import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/cupertino.dart';

class LoginRepository extends ChangeNotifier{

  LoginRepository.instance();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final codeController = TextEditingController();
  bool _isSignedIn = false;
  bool _loading = false;


  bool _googleLoading = false;

  bool _isOTPSignUpComplete = false;

  bool _isSignUpComplete = false;
  bool get isSignedIn => _isSignedIn;

  bool get isSignUpComplete => _isSignUpComplete;

  set isSignUpComplete(bool value) {
    _isSignUpComplete = value;
    notifyListeners();
  }

  set isSignedIn(bool value) {
    _isSignedIn = value;
    notifyListeners();
  }


  bool get isOTPSignUpComplete => _isOTPSignUpComplete;

  set isOTPSignUpComplete(bool value) {
    _isOTPSignUpComplete = value;
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
  Future<AuthUser>retrieveCurrentUser() async{
    AuthUser authUser = await Amplify.Auth.getCurrentUser();
    return authUser;
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
  Future<bool> register() async{
    loading =true;
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

        isSignUpComplete = res.isSignUpComplete;
      loading =false;
       return isSignUpComplete;
    } on AuthException catch (e) {

      print(e.message);
      loading =false;
      return isSignUpComplete;
    }
  }
  Future<bool> confirmUser(String username) async {
    try {
      SignUpResult res = await Amplify.Auth.confirmSignUp(
          username: username,
          confirmationCode: codeController.text.trim());

        isOTPSignUpComplete = res.isSignUpComplete;
        return isOTPSignUpComplete;

    } on AuthException catch (e) {
      print(e.message);
      return isOTPSignUpComplete;
    }
  }



  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
    emailController.dispose();
  }

}