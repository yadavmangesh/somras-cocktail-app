
import 'dart:io';
import 'package:sqflite/sqlite_api.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class DatabaseHelper {

  static final _databaseName= "somras.db";
  static final _dataBaseVersion=1;


  static final table = "cocktail";
  static final columnId= "id";
  static final columnName= "drink";
  static final columnDrinkAlternate= "drinkalternate";
  static final columnTags= "tags";
  static final columnVideo= "video";
  static final columnCategory= "category";
  static final columnIBA= "iba";
  static final columnAlcoholic= "alcoholic";
  static final columnGlass= "glass";
  static final columnInstructions= "instructions";
  static final columnDrinkThumb= "drinkthumb";
  static final columnCreativeCommonsConfirmed= "creativecommonsconfirmed";
  static final columnSaved= "saved";


  static final ingredientTable="ingredients";
  static final ingrendientName="name";
  static final ingrendientMeasure="measure";
  static final ingrendientImage="image";
  static final ingrendientId="id";

  static Database _database;

  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper(){
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    String dbPath = join(await getDatabasesPath(), _databaseName);

    var database = await openDatabase(dbPath, version: _dataBaseVersion, onCreate: _onCreateTable);
    return database;
  }

  Future _onCreateTable(Database db,int version) async {
    await db.execute("CREATE TABLE $table( $columnId TEXT PRIMARY KEY,$columnAlcoholic TEXT, $columnName TEXT,"
                      "$columnCategory TEXT , $columnDrinkAlternate TEXT,$columnTags TEXT,$columnGlass TEXT,"
                      "$columnVideo TEXT,$columnIBA TEXT,$columnInstructions TEXT,$columnDrinkThumb TEXT,"
                      "$columnCreativeCommonsConfirmed TEXT ,$columnSaved INTEGER DEFAULT 0)");

    await db.execute("CREATE TABLE $ingredientTable ($ingrendientId TEXT PRIMARY KEY,$ingrendientName TEXT,"
                     "$ingrendientMeasure TEXT,$ingrendientImage TEXT)");
  }





}