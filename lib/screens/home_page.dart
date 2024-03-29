

import 'package:amp_auth/models/Post.dart';
import 'package:amp_auth/repository/post_repository.dart';

import 'package:amp_auth/repository/profile_repository.dart';
import 'package:amp_auth/screens/login_screen.dart';
import 'package:amp_auth/screens/nav/fab_bottom_app_bar.dart';
import 'package:amp_auth/screens/post_item.dart';
import 'package:amp_auth/screens/profile_screen.dart';
import 'package:amp_auth/screens/register_screen.dart';
import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:amp_auth/utils/app_theme.dart';
import 'package:amp_auth/utils/size_config.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {



  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
String? userId;
Stream<SubscriptionEvent<Post>>? postStream;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var provider = context.read<ProfileRepository>();
    var postProvider = context.read<PostRepository>();
    provider.retrieveCurrentUser().then((AuthUser authUser) {

       setState(() {
         userId = authUser.userId;
       });

    });


/*
   if(userId != null){
     postProvider.queryAllPosts().then((List<Post> posts) {

       print(posts.toString());
       postProvider.posts = posts;
     });
   }
*/
   postStream = Amplify.DataStore.observe(Post.classType);
    postStream!.listen((event) {
    postProvider.posts.insert(0, event.item);
    print('Received event of type ' + event.eventType.toString());
    print('Received post ' + event.item.toString());

    });




   // Amplify.DataStore.clear();
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

    var postRepo = context.watch<PostRepository>();
    var profileRepo = context.watch<ProfileRepository>();
    return userId == null ?RegisterScreen() :
     Scaffold(
      backgroundColor: ThemeColor.black,
      appBar: AppBar(

        title: Text("NFT MARKET",
          style: TextStyle(fontSize: 20,
              fontFamily: 'SeymourOne',

              foreground: Paint()..shader = ThemeColor.linearGradient),),
        actions: [
          IconButton(
            color: Colors.white,
              icon: Icon(Icons.login), onPressed: (){
            profileRepo.signOut().then((bool signOut){
              if(signOut){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return LoginScreen();
                }));
              }else{
                print("couldn't sign out");
              }
            });
          })
        ],
      ),
      body:   IndexedStack(
        index:_selectedTabIndex ,
        children: [
          FutureProvider.value(value: postRepo.queryAllPosts(),
            catchError: (context,error){
              print(error.toString());
            },
            initialData: [],
            child: Consumer(builder: (_,List<Post>? posts,child){
              if(posts != null){
                if(posts.isNotEmpty){
                  return  ListView.builder(


                    itemBuilder: (context,index){
                      return PostItem(userId!,posts[index]);
                    },itemCount: posts.length,);
                }else{
                  return Container(color: Colors.red,);
                }
              }else{
                return Container(child: Center(child: CircularProgressIndicator(),),);
              }
            },),),

          ProfileScreen(userId!),
          ProfileScreen(userId!),
          ProfileScreen(userId!),
        ],),


      bottomNavigationBar: FABBottomAppBar(
        centerItemText: 'nft',
        color: Colors.grey,
        selectedColor: ThemeColor.primary,

        onTabSelected: _selectedTab,
        userId: userId!,


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
