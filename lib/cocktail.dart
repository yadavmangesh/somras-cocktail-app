import 'package:somras/constant.dart';
import 'package:somras/utlis.dart';

import 'ingredients.dart';


class Cocktail{

  String idDrink;
  String strDrink;
  String strDrinkAlternate;
  String strTags;
  List<Ingredients> ingredientsList;
  String strVideo;
  String strCategory;
  String strIBA;
  String strAlcoholic;
  String strGlass;
  String strInstructions;
  String strDrinkThumb;
  String strCreativeCommonsConfirmed;

  Cocktail({this.idDrink,this.strDrink,this.strDrinkAlternate,this.strTags,this.ingredientsList,
             this.strVideo,this.strCategory,this.strIBA,this.strAlcoholic,this.strGlass,
            this.strInstructions,this.strDrinkThumb,this.strCreativeCommonsConfirmed});

  factory Cocktail.fromJson(Map<String,dynamic> jsonResponse){
    return Cocktail(
         idDrink:jsonResponse["idDrink"].toString(),
         strDrink:jsonResponse["strDrink"].toString(),
         strDrinkAlternate:jsonResponse["strDrinkAlternate"].toString(),
         strTags:jsonResponse["strTags"].toString(),
         ingredientsList: _getIngredientList(jsonResponse),
         strVideo:jsonResponse["strVideo"].toString(),
         strCategory:jsonResponse["strCategory"].toString(),
         strIBA:jsonResponse["strIBA"].toString(),
         strAlcoholic:jsonResponse["strAlcoholic"].toString(),
         strGlass:jsonResponse["strGlass"].toString(),
         strInstructions:jsonResponse["strInstructions"].toString(),
         strDrinkThumb:jsonResponse["strDrinkThumb"].toString(),
         strCreativeCommonsConfirmed:jsonResponse["strCreativeCommonsConfirmed"].toString()

     );
  }

   static List<Ingredients>_getIngredientList(Map<String,dynamic> jsonResponse){
        List<Ingredients> ingredientList=List();

       for(var i=1;i<=15;i++){
           if(jsonResponse["strIngredient$i"].toString()!="null"&&jsonResponse["strIngredient$i"].toString().isNotEmpty){
              var ingredient= new Ingredients(
                strIngredientName:jsonResponse["strIngredient$i"].toString(),
                strMeasure: jsonResponse["strMeasure$i"].toString(),
                image: Utils.getImageUrl(jsonResponse["strIngredient$i"].toString())
              );
              ingredientList.add(ingredient);
           }
       }
      return ingredientList;
  }

}