
import 'package:amp_auth/models/ModelProvider.dart';
import 'package:amp_auth/repository/profile_repository.dart';
import 'package:amp_auth/screens/edit_profile.dart';
import 'package:amp_auth/screens/login_screen.dart';
import 'package:amp_auth/screens/nav/fab_bottom_app_bar.dart';
import 'package:amp_auth/screens/register_screen.dart';
import 'package:amp_auth/utils/app_theme.dart';
import 'package:amp_auth/utils/size_config.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../amplifyconfiguration.dart';

class HomePage extends StatefulWidget {



  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;
  bool _amplifyConfigured = false;
  // list of Todos

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


     _configureAmplify();


  }


  int _selectedTabIndex = 0;

  void _selectedTab(int index) {
    if(index == 2)
    {

    }
    setState(() {
      _selectedTabIndex = index;

      print("Selected Index"+_selectedTabIndex.toString());
    });
  }





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
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: ThemeColor.black,
      appBar: AppBar(

        title: Text("Home Page"),
      ),
      body:  Text('No blogs have been added yet'),
      bottomNavigationBar: FABBottomAppBar(
        centerItemText: 'SellUp',
        color: Colors.grey,
        selectedColor: ThemeColor.primary,

        onTabSelected: _selectedTab,
        userId: "khghjgkh",


        items: [
          FABBottomAppBarItem(iconName:'assets/svg/home.svg', text: 'home',),
          FABBottomAppBarItem(iconName:'assets/svg/chats.svg', text: 'chats'),
          FABBottomAppBarItem(iconName:'assets/svg/notification.svg', text: 'noti'),
          FABBottomAppBarItem(iconName:'assets/svg/profile.svg', text: 'profile'),
        ],
      ),
      /*
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          if(_amplifyConfigured) {
            print("amplify configured");
            //addBlog();

            Navigator.push(context, MaterialPageRoute(builder: (context){
            // return RegisterScreen();
              //return LoginScreen();

              return ChangeNotifierProvider(create: (_)=>ProfileRepository.instance(),
              child: EditProfileScreen(),);


            }));
          }else{
            print("amplify NOT configured");
          }
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.

       */
    );
  }
}
