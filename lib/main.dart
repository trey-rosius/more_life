import 'package:amp_auth/repository/post_repository.dart';
import 'package:amp_auth/repository/profile_repository.dart';
import 'package:amp_auth/screens/home_page.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
// Amplify Flutter Packages
import 'package:amplify_flutter/amplify.dart';
// import 'package:amplify_api/amplify_api.dart'; // UNCOMMENT this line once backend is deployed
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:provider/provider.dart';

// Generated in previous step
import 'models/ModelProvider.dart';
import 'amplifyconfiguration.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool _amplifyConfigured = false;
  void _configureAmplify() async {

    // Amplify.addPlugin(AmplifyAPI()); // UNCOMMENT this line once backend is deployed
    Amplify.addPlugins([
      AmplifyDataStore(modelProvider: ModelProvider.instance,),
      AmplifyAuthCognito(),
      AmplifyAPI(),
      AmplifyStorageS3()
    ]);

    try {
      // Once Plugins are added, configure Amplify
      await Amplify.configure(amplifyconfig);
      setState(() {
        _amplifyConfigured = true;
      });
    } on AmplifyAlreadyConfiguredException {
      print(
          "Amplify was already configured. Looks like app restarted on android.");

      setState(() {
        _amplifyConfigured = true;
      });
    }


  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _configureAmplify();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Social Media App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primaryColor: Color(0xFF1c1c1c),
        accentColor: Color(0XFFf94c84),



      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ProfileRepository.instance(),),
          ChangeNotifierProvider(create: (_) => PostRepository.instance(),),

        ],
        child: HomePage(),

      )
    );
  }
}

