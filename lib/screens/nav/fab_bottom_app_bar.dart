import 'package:amp_auth/repository/profile_repository.dart';
import 'package:amp_auth/screens/create_post.dart';
import 'package:amp_auth/utils/app_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';


class FABBottomAppBarItem {
  FABBottomAppBarItem({this.iconName, this.text});
  String iconName;
  String text;
}

class FABBottomAppBar extends StatefulWidget {
  FABBottomAppBar({
    this.items,
    this.centerItemText,
    this.height: 60.0,
    this.iconSize: 24.0,
    this.backgroundColor,
    this.color,
    this.selectedColor,

    this.onTabSelected,
    this.userId,

  }) {
  //  assert(this.items.length == 2 || this.items.length == 4);
  }
  final List<FABBottomAppBarItem> items;
  final String centerItemText;
  final double height;
  final double iconSize;
  final Color backgroundColor;
  final Color color;
  final Color selectedColor;

  final ValueChanged<int> onTabSelected;
  final String userId;



  @override
  State<StatefulWidget> createState() => FABBottomAppBarState();
}

class FABBottomAppBarState extends State<FABBottomAppBar> {
  int _selectedIndex = 0;


  _updateIndex(int index) {
    widget.onTabSelected(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> items = List.generate(widget.items.length, (int index) {
      return _buildTabItem(
        item: widget.items[index],
        index: index,
        onPressed: _updateIndex,
      );
    });
    items.insert(items.length >> 1, _buildMiddleTabItem());

    return BottomAppBar(
    elevation: 0.0,
      color: Colors.black,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items,
      ),

    );
  }

  Widget _buildMiddleTabItem() {
    return
      Expanded(
        child: InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return  FutureProvider(create:(context) => ProfileRepository.instance().getUserProfile(widget.userId),
                catchError: (context,error){
                print(error);
                },
                child: CreatePostScreen(userId: widget.userId,),
              );
            }));
          },
          child: SizedBox(
            height: 100,
            width: 100,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    height: 60,
                    width: 60,

                  padding:EdgeInsets.all(20),

                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [ThemeColor.primary, ThemeColor.secondary],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),

                    borderRadius: BorderRadius.all(Radius.circular(100.0)),
                  ),
                  child: SvgPicture.asset(
                    'assets/svg/add.svg',

                    height: 24,
                    width: 24,
                    fit: BoxFit.cover,
                    color: Colors.white,

                  ),
                ),

              ],
            ),
          ),
        ),

    );
  }

  Widget _buildTabItem({
    FABBottomAppBarItem item,
    int index,
    ValueChanged<int> onPressed,
  }) {
    Color color = _selectedIndex == index ? widget.selectedColor : widget.color;
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => onPressed(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[




                    Container(
                      height: 30,
                      width: 30,


                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Align(
                            alignment:Alignment.center,
                            child: SvgPicture.asset(
                              item.iconName,

                              height: 24,
                              width: 24,
                              fit: BoxFit.cover,
                              color: color,

                            ),
                          ),



                        ],
                      ),
                    ),



              ],
            ),
          ),
        ),
      ),
    );
  }
}