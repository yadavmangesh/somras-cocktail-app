import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:somras/model/Cocktail.dart';
import 'package:somras/utils/constant.dart';
import 'package:somras/detailscreen/DetailScreen.dart';
import 'package:somras/utils/utlis.dart';

class Top10item extends StatefulWidget {

  final Cocktail cocktail;
  final double height;
  final double width;
  final double captionSize;
  bool isId;

  Top10item({this.cocktail, this.height, this.width,this.captionSize,this.isId});

  @override
  State<StatefulWidget> createState() {
    return _Top10State(this.cocktail, this.height, this.width,this.captionSize,this.isId);
  }

}

class _Top10State extends State<Top10item> {

  final Cocktail cocktail;
  final double height;
  final double width;
  final double captionSize;
  final bool isId;

  _Top10State(this.cocktail, this.height, this.width,this.captionSize,this.isId);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        clipBehavior: Clip.antiAlias,
        borderOnForeground: false,
        elevation: 8,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)
        ),

        child: InkWell(

          onTap: (){
             if(isId){
               Utils.detailPageRoute(buildContext: context,page: DetailScreen.fromId(cocktail.idDrink,isId,));
             }else{
               Utils.detailPageRoute(buildContext: context,page: DetailScreen(cocktail,));
             }
          },

          child: Stack(
            children: <Widget>[

              Container(
                height: height,
                width: width,
                child: FadeInImage.assetNetwork(
                  placeholder: Constant.placeholderList[Utils.getRandom()],
                  image: cocktail.strDrinkThumb,
                  fit: BoxFit.fitWidth,),
              ),
              Container(
                margin: EdgeInsets.only(left: 16, bottom: 8,right: 16),
                alignment: Alignment.bottomLeft,
                child: Flexible(
                  child: Text(cocktail.strDrink,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: captionSize,
                        fontWeight: FontWeight.w500,
                        color: Constant.white,
                        fontFamily: "Poppins"
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}