

import 'package:amp_auth/repository/profile_repository.dart';
import 'package:amp_auth/screens/nav/fab_bottom_app_bar.dart';

import 'package:amp_auth/utils/app_theme.dart';
import 'package:amp_auth/utils/size_config.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {



  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
String userId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var provider = context.read<ProfileRepository>();
    provider.retrieveCurrentUser().then((AuthUser authUser) {
      setState(() {
        userId = authUser.userId;
      });
    });




  }


  int _selectedTabIndex = 0;

  void _selectedTab(int index) {
    print("Selected Index"+index.toString());
    if(index == 2)
    {

    }
    setState(() {
      _selectedTabIndex = index;

      print("Selected Index"+_selectedTabIndex.toString());
    });
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
        userId: userId,


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
