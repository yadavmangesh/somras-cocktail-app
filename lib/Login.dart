import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:somras/database/DatabaseHelper.dart';
import 'package:somras/model/Cocktail.dart';
import 'package:sqflite/sqflite.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> {
  String barcode;


  @override
  void initState() {
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }
}
