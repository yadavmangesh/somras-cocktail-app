import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:somras/model/Cocktail.dart';
import 'package:somras/utils/constant.dart';
import 'package:somras/IngredientWiseList.dart';
import 'package:somras/home/Top10List.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Utils {
  static String getImageUrl(String name) {
    return "https://www.thecocktaildb.com/images/ingredients/$name-Medium.png";
  }

  static int getRandom() {
    var random = Random();
    return random.nextInt(Constant.placeholderList.length);
  }

  static List<String> getTagList(String tag) {
    var tags = getTags(tag);
    return tags.split(",");
  }

  static String getTags(String tags) {
    return (tags != null && tags != "null") ? tags : "IBA,Classic";
  }
  static List<String> getInstructions(String instruction){
    List<String> list =instruction.split(".");

    return list.where((element) => (
        element!=null&&element.isNotEmpty
    )).toList();
  }

  static Widget getGridRow(
      { BuildContext context,
        String path,
      String caption,
      double imageHeight,
      double imageWidth,
      bool loadFromAssests = true}) {
    return  Card(
          elevation: 4,
//          semanticContainer: false,
//         clipBehavior: Clip.antiAlias,
//          borderOnForeground: false,
       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
              if(loadFromAssests){
                  Utils.detailPageRoute(buildContext: context,page:IngredientWiseList(caption));
              }
          },

            child: Column(
//                spacing: 8,
//                direction: Axis.horizontal,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getImage(
                  path: path,
                  height: imageHeight,
                  width: imageWidth,
                  loadFromAssests: loadFromAssests),
              getImageTitle(caption),

            ],
//              )

        )

        ),

    );
  }

  static Widget getImage({String path, double height, double width, bool loadFromAssests}) {
    if (loadFromAssests) {
      return Container(
        margin: EdgeInsets.only(top: 8),
        alignment: Alignment.center,
//        height: height,
//        width: width,
        child: Image.asset(path,width: width,height: height,),
      );
    }else{
      return Container(
        margin: EdgeInsets.only(top: 8),
          alignment: Alignment.center,
//        height: height,
//        width: width,
        child: FadeInImage.assetNetwork(placeholder: Constant.placeholderList[Utils.getRandom()],width: width,height: height,
            image: path)
      );
    }
  }

  static Widget getImageTitle(String name) {

    return Flexible(
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(right: 8,left: 8,bottom: 8),
        child: Text(
          name,
          softWrap: true,
          maxLines: 4,
          overflow: TextOverflow.visible,
          style: TextStyle(
              fontFamily: "Poppins",
              letterSpacing: 1,
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Constant.primaryColor),

//
        ),
      ),
    );
  }

  static Future<List<Cocktail>> fetchCocktails(String url) async {
    final response = await http.get(url);
    print("fetchCocktails " + url);
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      print("responseJson " + responseJson.toString());
      return (responseJson['drinks'] as List)
          .map((p) => Cocktail.fromJson(p))
          .toList();
    } else {
      print("fetchrandom10 responseJson " + response.statusCode.toString()+"  " +response.toString());
      throw Exception('Failed to load Cocktails');
    }
  }

  static Widget getFutureBuilder({Future<List<Cocktail>> list,double height,
    double width,Axis axis,double listHeight,double textSize,bool flag}){

    return  FutureBuilder<List<Cocktail>>(
      future: list,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          //   return NewsList(snapshot.data);
          print("has Data");
          return  Top10List(cocktailList: snapshot.data,height: height,width: width,axis:axis,textSize: textSize,flag: flag,);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        );
      },
    );
  }

  static detailPageRoute({BuildContext buildContext, dynamic page}) {
    Navigator.push(buildContext,
        MaterialPageRoute(builder: (buildContext) => page));
  }

  static Widget getTagChips(String tag) {
    return Container(
      margin: EdgeInsets.only(right: 8, top: 6),
      padding: EdgeInsets.only(left: 6, right: 6),
      child: Text(
        tag,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontFamily: "Poppins",
          color: Constant.primaryColor,
          fontSize: 12,
        ),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(width: 1, color: Constant.primaryColor)),
    );
  }

  static Future<Cocktail> fetchCocktail(String id) async {
    final response = await http.get(Constant.getCocktailfromId(id));
    print("fetchCocktails " + Constant.getCocktailfromId(id));
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      print("responseJson " + responseJson.toString());
      return (responseJson['drinks'] as List).map((p) => Cocktail.fromJson(p)).toList().elementAt(0);

    } else {
      print("fetchrandom10 responseJson " + response.statusCode.toString()+"  " +response.toString());
      throw Exception('Failed to load Cocktail');
    }
  }
}
