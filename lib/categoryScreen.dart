
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:somras/scrollbehavior.dart';
import 'package:somras/utlis.dart';

import 'constant.dart';

class Category extends StatelessWidget{


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: _appBar,

      body: SingleChildScrollView(
        child: _column(context),
      ),

    );
  }

   _column(BuildContext context){

    return Column(
         children: [
           Container(
             margin: EdgeInsets.only(left: 16,right: 16),
             child:_ingredientGrid(context) ,
           ),
         ],
    );
  }

   _ingredientGrid(BuildContext context){
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

  get _appBar {
    return AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title:Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Select Beverage",
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