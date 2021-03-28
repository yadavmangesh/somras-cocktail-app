
import 'package:json_annotation/json_annotation.dart';
import 'package:somras/database/DatabaseHelper.dart';

@JsonSerializable()
class Ingredients{

  String strIngredientName;
  String strMeasure;
  String image;
  String id;

  Ingredients({this.strIngredientName,this.strMeasure,this.image,this.id});

  Map<String,dynamic> toMap(){
    return{
      DatabaseHelper.ingrendientName:strIngredientName,
      DatabaseHelper.ingrendientId:id,
      DatabaseHelper.ingrendientImage:image,
      DatabaseHelper.ingrendientMeasure:strMeasure
    };
  }

}