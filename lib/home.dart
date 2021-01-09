import 'package:somras/categoryScreen.dart';
import 'package:somras/cocktail.dart';
import 'package:somras/scrollbehavior.dart';
import 'package:somras/utlis.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'constant.dart';

class Home extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {

  Future<List<Cocktail>> latestCocktailList;
  Future<List<Cocktail>> randomCocktailList;
  Future<List<Cocktail>> popularCocktailList;

  var selectedIndex=0;

  @override
  void initState() {
    super.initState();
    latestCocktailList = Utils.fetchCocktails(Constant.latest10);
    randomCocktailList = Utils.fetchCocktails(Constant.random10Url);
    popularCocktailList = Utils.fetchCocktails(Constant.popularUrl);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: _appBar,

      body: SingleChildScrollView(
          child: _column,
         ),
      bottomNavigationBar: _bottomNavigation,

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



  static Widget _setTop10List({Future<List<Cocktail>> list,double height,double width,
    Axis axis,double listHeight,double textSize,bool flag}){

      if(axis==Axis.vertical){
        return Column(
          children: [
             Utils.getFutureBuilder(list: list,height: height,width: width
                 ,axis: axis,listHeight: listHeight,textSize: textSize,flag: flag)
          ],
        );
      }else{
        return Container(
           height: listHeight,
            child: Utils.getFutureBuilder(list: list,height: height,
              width: width,axis: axis,listHeight: listHeight,textSize: textSize,flag: flag),
        );
      }

  }




  get _column {

    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment:CrossAxisAlignment.center,
      children: <Widget>[
        _setTitleText(Constant.shuffle_drinks,8),
        _setTop10List(list:randomCocktailList,height:150,width:300,axis:Axis.horizontal,
            listHeight: 150,textSize: 14,flag: false),


             Container(
               margin: EdgeInsets.only(left: 16,right: 16),
               child:_ingredientGrid ,
             ),
//             GestureDetector(
//               onTap: (){
//                 Utils.detailPageRoute(buildContext: context,page: Category());
//               },
//               child:
//               Container(
//                   margin: EdgeInsets.only(left: 16,right: 18),
//                   alignment: Alignment.bottomRight,
//                   child: Text("See all",
//                     style: TextStyle(
//                         fontWeight: FontWeight.w500,
//                         fontFamily: "Poppins",
//                         fontSize: 14,
//                         letterSpacing: 1,
//                         color: Constant.primaryColor
//                     ),)
//               ),
//             ),


        _setTitleText(Constant.latest_drink,8),
        _setTop10List(list:latestCocktailList,height:150,width:300,axis:Axis.horizontal,
            listHeight:150,textSize: 14,flag: false),
        _setTitleText("Popular Drinks",8),
         Column(
           mainAxisSize: MainAxisSize.min,
           children: [
             _setTop10List(list:popularCocktailList,height:150,width:MediaQuery.of(context).size.width,
                 axis:Axis.vertical,listHeight:double.maxFinite,textSize: 14,flag: true),
           ],
         )

      ],
    );
  }

  get _ingredientGrid{
    return  ScrollConfiguration(
      behavior: MyBehavior(),
      child: GridView.count(
        shrinkWrap: true,
        padding: EdgeInsets.only(bottom: 8),
        crossAxisCount: 4,
        children: [
          Utils.getGridRow(context:context,path:"images/cocktails-1.png", caption:"Whiskey",imageHeight: 48,imageWidth: 48),
          Utils.getGridRow(context:context,path:"images/cocktails-9.png", caption:"Vodka",imageHeight: 48,imageWidth: 48),
          Utils.getGridRow(context:context,path:"images/cocktails-4.png", caption:"Tequila",imageHeight: 48,imageWidth: 48),
          Utils.getGridRow(context:context,path:"images/cocktails-3.png", caption:"Rum",imageHeight: 48,imageWidth: 48),
          Utils.getGridRow(context:context,path:"images/cocktails-2.png", caption:"Wine",imageHeight: 48,imageWidth: 48),
          Utils.getGridRow(context:context,path:"images/cocktails-30.png",caption:"Gin",imageHeight: 48,imageWidth: 48),
          Utils.getGridRow(context:context,path:"images/cocktails.png",   caption:"Beer",imageHeight: 48,imageWidth: 48),
          Utils.getGridRow(context:context,path:"images/cocktails-27.png",caption:"Brandy",imageHeight: 48,imageWidth: 48),
        ],
      )
    );
  }





  Widget _setTitleText(String title,double top) {
    return Container(
         alignment:  Alignment.topLeft,
          margin: EdgeInsets.only(left: 16,top: top),
           child: Flexible(
//             alignment: Alignment.topLeft,
             flex: 1,
             child: Text(
               title,
               style: TextStyle(
                   color: Colors.black87,
                   fontFamily: "Poppins",
                   fontSize: 18,
                   letterSpacing: 1,
                   fontWeight: FontWeight.w600
               ),
             ),
           ),
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
