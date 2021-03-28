

import 'package:somras/database/DatabaseHelper.dart';
import 'package:somras/model/Cocktail.dart';
import 'package:sqflite/sqflite.dart';

class CocktailDbHelper{

  static final CocktailDbHelper _instance = CocktailDbHelper._singleton();

  factory CocktailDbHelper(){
    return _instance;
  }

  Database database;

  CocktailDbHelper._singleton(){
      initDataBase();
  }

  void initDataBase() async{
     database =  await DatabaseHelper().database;
  }

  Future<List<dynamic>> insert(Cocktail cocktail){
    database.insert(DatabaseHelper.columnName, cocktail.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
    Batch batch = database.batch();
     cocktail.ingredientsList.forEach((ingredient) {
        batch.insert(DatabaseHelper.ingredientTable,ingredient.toMap());
     });
    return batch.commit(noResult: false,continueOnError: false);
  }

  Future<int> update(Cocktail cocktail){
   return database.update(DatabaseHelper.columnName, cocktail.toMap(),whereArgs:[cocktail.idDrink]);
  }
  
}