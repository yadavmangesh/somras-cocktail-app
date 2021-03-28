import 'package:somras/CategoryScreen.dart';
import 'package:somras/model/Cocktail.dart';
import 'package:somras/utils/scrollbehavior.dart';
import 'package:somras/utils/utlis.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../utils/constant.dart';
import 'HomeScreen.dart';

class Home extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {



  var selectedIndex=0;

  List<Widget> _navigationList =<Widget>[
    HomeScreen(),

  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: _appBar,

      body: SingleChildScrollView(
          child: _navigationList[selectedIndex],
         ),
      bottomNavigationBar: _bottomNavigation

    );
  }


  get _bottomNavigation{
       return BottomNavigationBar(
          selectedItemColor: Constant.primaryColor,
          unselectedItemColor: Constant.secondaryTextColor,
          selectedLabelStyle:_textLable(Constant.primaryColor) ,
          unselectedLabelStyle: _textLable(Constant.secondaryTextColor),
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedIndex,
          onTap: (index){
            setState(() {
              selectedIndex=index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text('Search'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_border),
              title: Text('Saved'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text('Settings'),
            ),
          ],
       );
  }

  TextStyle _textLable(Color color){
    return TextStyle(
      fontFamily: "Poppins",
      fontSize: 12,
      color: color
    );
  }


  get _appBar {

    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
//      centerTitle: true,
//      leading: IconButton(
//        tooltip: 'Navigation Drawer',
//        icon: ,
//        onPressed: () {
//
//        },
//      ),
      title:Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset("images/logo.png",height: 48,width: 48,),
          Text(Constant.appName,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Constant.primaryColor,
                fontFamily: "Poppins",
                letterSpacing: 1.5,
                fontSize: 22,
                fontWeight: FontWeight.w700),
          ),
        ],
      )
    );
   }
  }
