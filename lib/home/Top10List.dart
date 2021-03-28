import 'package:flutter/material.dart';
import 'package:somras/model/Cocktail.dart';
import 'package:somras/home/PopularDrinksItem.dart';
import 'package:somras/home/Top10Item.dart';

class Top10List extends StatelessWidget {

  final List<Cocktail> cocktailList;
  final double height;
  final double width;
  final double textSize;
  final Axis axis;
  final bool flag;
  var scrollphysics;

  Top10List({this.cocktailList,this.height,this.width,this.axis,this.textSize,this.flag});

  @override
  Widget build(BuildContext context) {
     if(axis==Axis.vertical){
       scrollphysics=NeverScrollableScrollPhysics();
     }
    return _listView(context);
  }

  ListView _listView(context){
    return ListView.builder(
        scrollDirection: axis,
        addAutomaticKeepAlives: false,
        physics: scrollphysics,
        padding: EdgeInsets.only(left:8,bottom: 8,right: 8),
        shrinkWrap: true,
        itemCount: cocktailList.length,
        itemBuilder: (context,int) {
           if(flag) {
             return PopularDrinksItem(cocktailList[int]);
           }else if(!flag&&axis==Axis.vertical){
             return Top10item(cocktail: cocktailList[int],height: height,width: width,captionSize: textSize,isId: true,);
           }else{
             return Top10item(cocktail: cocktailList[int],height: height,width: width,captionSize: textSize,isId: false,);
           }

        }
    );

  }


}