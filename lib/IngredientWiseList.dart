import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:somras/model/Cocktail.dart';
import 'package:somras/utils/constant.dart';
import 'package:somras/home/SomrasMain.dart';
import 'package:somras/utils/utlis.dart';

class IngredientWiseList extends StatefulWidget{

  final String ingredient;
  IngredientWiseList(this.ingredient);

  @override
  State<StatefulWidget> createState() {
     return IngredientWiseListState(this.ingredient);
  }
}

class IngredientWiseListState extends State<IngredientWiseList>{

  final String ingredient;
   Future<List<Cocktail>> list;
  IngredientWiseListState(this.ingredient);

  @override
  void initState() {
    super.initState();
    list= Utils.fetchCocktails(Constant.getIngredientUrl(ingredient));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
       body: _columnMain,
    );
  }

  get _appBar {
    return AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
//      centerTitle: true,
//      leading: IconButton(
//        tooltip: 'Navigation Drawer',
//        icon: ,
//        onPressed: () {
//
//        },
//      ),
        title:Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(ingredient+" Cocktails",
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

  get _columnMain{
    return ListView(
      children: [
        Utils.getFutureBuilder(list: list,height: 150,width: MediaQuery.of(context).size.width,
            axis: Axis.vertical,listHeight: double.maxFinite,textSize: 16,flag: false)
      ],
    );
  }

}