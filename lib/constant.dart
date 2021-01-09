import 'package:flutter/material.dart';
import 'dart:math';
class Constant{

  // Colors used in the app
  static const Color primaryDarkColor =Color(0xffc66900);
  static const Color accentColor=Color(0xffffc947);
  static const Color primaryColor=Color(0xffff9800);
  static const Color white=Colors.white;
  static const Color primaryTextColor=Colors.white;
  static  Color secondaryTextColor=Colors.grey;

  //IntroPage Color
  static Color grey = Colors.grey[200];



  // Assets
  static const String introPath='images/logo.png';
  static Image introLogo=Image.asset(introPath,fit: BoxFit.contain,height: 150,width: 150,);


  //data structure
  static List<String> placeholderList = ["images/cocktails-6.png","images/cocktails-11.png",
    "images/cocktails-13.png" ,"images/cocktails-14.png","images/cocktails-17.png",
    "images/cocktails-22.png","images/cocktails-24.png","images/cocktails-26.png",
    "images/cocktails-27.png","images/cocktails-33.png","images/cocktails-35.png",
    "images/cocktails-40.png"];



  // dimension
  static const double editTextHeight = 45;


  //Text
  static const String appName="Somras";
  static String aboutDrink="About Drink";
  static String ingredients="Ingredients";
  static String procedure="Procedure";
  static String shuffle_drinks="Shuffle Drinks";
  static String latest_drink="Latest Drinks";
//  static const String verify="Verify";
//  static const String appIntro="Don't just chat, Jibber-Jabber with your friends, family and colleagues ";
//  static const String textFieldHint= 'Phone Number with Country Code ';
//  static const String register= "Register";
//  static const String copyRightText= "© copyright 2020";
//  static const String verifyText="Verification code has been sent to your mobile number";
//  static const String resentCode="Didn't recieve the code?";
//  static const String resend = "Resend";
//  static const String submit = "Submit";
//  static const String editTextPhoneInfo= "Phone number info";

  /**
   *   get v2 version API_KEY or you can also use
   *
   *   API_VERSION="v1"
   *   API_KEY="1"
   *   see read.md for more details
   *
   */

 static final  API_KEY="XXXXXXXX";
 static final API_VERSION="v2";
 static final BASE_URL="https://www.thecocktaildb.com/api/json/$API_VERSION/$API_KEY";
 static final String random10Url="$BASE_URL/randomselection.php";
 static final String latest10="$BASE_URL/latest.php";
 static final String popularUrl="$BASE_URL/popular.php";





 static String getIngredientUrl(String name){
   return "$BASE_URL/filter.php?i=$name";
 }
  static String getCocktailfromId(String id){
    return "$BASE_URL/lookup.php?i=$id";
  }


}