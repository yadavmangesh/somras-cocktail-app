
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:somras/model/Cocktail.dart';
import 'package:somras/utils/constant.dart';
import 'package:somras/utils/scrollbehavior.dart';
import 'package:somras/utils/utlis.dart';

class HomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }

}
class HomeScreenState extends State<HomeScreen>{

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
      body: _column,
    );
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

   Widget _setTop10List({Future<List<Cocktail>> list,double height,double width,
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

}