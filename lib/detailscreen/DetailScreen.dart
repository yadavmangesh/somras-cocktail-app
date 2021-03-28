import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:somras/model/Cocktail.dart';
import 'package:somras/utils/constant.dart';
import 'package:somras/model/Ingredients.dart';
import 'package:somras/utils/utlis.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class DetailScreen extends StatefulWidget{

   Cocktail cocktail;
   bool isId=false;
   String id;

  DetailScreen(this.cocktail){
    this.cocktail=cocktail;
  }

  DetailScreen.fromId(String id,bool isId){
    this.isId=isId;
    this.id=id;
  }

  @override
  State<StatefulWidget> createState() {
    return DetailsScreenState(cocktail:cocktail,isId:isId,id:id);
  }

}

class DetailsScreenState extends State<DetailScreen>{

  final Cocktail cocktail;
  final bool isId;
  final String id;
  var futureCocktail;

  DetailsScreenState({this.cocktail,this.isId,this.id=""});
   var tagList,instructionList;

  @override
  Widget build(BuildContext context) {

     return Scaffold(
        body: SafeArea(
          child: getMainView(isId,futureCocktail),
        ),
     );
  }

  @override
  void initState() {
    super.initState();

      if(isId){
        futureCocktail= fetchCocktail();
      }else{
         init(cocktail);
      }

  }
  Future<Cocktail> fetchCocktail() async{
    return Utils.fetchCocktail(this.id);
  }



  Widget getMainView(bool isId,Future<Cocktail> cocktail){
    if(isId){
      return FutureBuilder<Cocktail>(
        future: cocktail,
        builder: (context,snapshot){
          if(snapshot.hasData){
            init(snapshot.data);
            return listView(snapshot.data);
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
    }else{
      return listView(this.cocktail);
    }
  }

  void init(Cocktail cocktail){
    tagList = Utils.getTagList(cocktail.strTags);
    instructionList = Utils.getInstructions(cocktail.strInstructions);

    if(cocktail.strCategory!="null")
      tagList.add(cocktail.strCategory);
    if(cocktail.strGlass!="null")
      tagList.add(cocktail.strGlass);
    if(cocktail.strAlcoholic!="null")
      tagList.add(cocktail.strAlcoholic);
    if(cocktail.strIBA!="null")
      tagList.add(cocktail.strIBA);
  }

  Widget listView(Cocktail cocktail){

    return ListView(
      children: [
        _setThumb(cocktail.strDrinkThumb),
        _nameAndShare(cocktail),
         _divider,
         _title( title:Constant.aboutDrink,top: 8,bottom: 8),
         _chips,
        _title( title:Constant.ingredients,top: 8,bottom: 8),
         Container(
           margin: EdgeInsets.only(left: 16,right :16),
          child: _ingredientGrid(cocktail.ingredientsList),
         ),
        _title( title:Constant.procedure,top: 8,bottom: 4),
        Container(
          margin: EdgeInsets.only(right :16,bottom: 16),
          child:  columnInstruction,
        ),


      ],
    );
  }

  get columnInstruction{

    return Column(
      children:List.generate(instructionList.length, (index) {
        return getInstructionRow(instructionList[index].trim()+" .");
      })
    );
  }

  Widget _ingredientGrid(List<Ingredients> ingredientList){

    return StaggeredGridView.countBuilder(
          shrinkWrap: true,
          crossAxisCount:3 ,
          physics: ScrollPhysics(),
          itemCount:ingredientList.length ,
          padding: EdgeInsets.only(bottom: 8),
          itemBuilder:(BuildContext context,int index)=>(
                  Utils.getGridRow(path:ingredientList[index].image,
                  caption:ingredientList[index].strIngredientName+": "+ (ingredientList[index].strMeasure=="null"?"as required":ingredientList[index].strMeasure),
                  imageHeight: 90,
                  imageWidth: 90,
                  loadFromAssests: false)
          ),
        staggeredTileBuilder: (int index) =>
          new StaggeredTile.fit(1)
//         mainAxisSpacing: 4.0,
//         crossAxisSpacing: 4.0,
//

    );
  }

  Widget getInstructionRow(String instruction){
    return Container(
      margin: EdgeInsets.only(left: 16),
      child: Row(
        children: [
          Container(
            height: 12,
            width: 12,
            child:  CircleAvatar(
              backgroundColor: Constant.secondaryTextColor,
            ),
          ),
          Flexible(
              child:   Container(
                margin: EdgeInsets.only(left: 8,right: 16,top: 4),
                child:  Text(
                  instruction,
                  overflow: TextOverflow.visible,
                  style: TextStyle(
                       color: Colors.grey[800],
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w500
                  ),
                ),
              )
          )
        ],
      ),
    );
  }

  get _chips{
    return Container(
      margin: EdgeInsets.only(right: 16,left: 16),
      child:  Wrap(
        children: List.generate(tagList.length, (index) {
          return Utils.getTagChips(tagList[index]);
        }),
      ),
    );
  }

  get _divider{
    return Container( margin: EdgeInsets.only(right: 16,left: 16),

      child: Divider(
        color: Constant.secondaryTextColor,
        height: 1,
      ) ,
    );
  }

  Widget _title({String title,double top,double bottom}){
    return Container(
      margin: EdgeInsets.only(right: 16,left: 16,top: top,bottom: bottom),
      child: Text(
            title,
          style:TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 18,
          fontFamily: "Poppins"
        ),
      ),
    );
  }

  Widget _nameAndShare(Cocktail cocktail){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child:Container(
            margin: EdgeInsets.only(right: 16,left: 16,top: 8),
           child: Text(
              cocktail.strDrink,
               overflow: TextOverflow.visible,
               style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 24,
                letterSpacing: 1,
                fontWeight: FontWeight.w600,
//              color: Colors.black87
              ),
            ),
          )
        ),
        Container(
          margin: EdgeInsets.only(top: 8,right: 8),
          child: IconButton(
            icon: Icon(Icons.bookmark_border,color: Constant.primaryColor,),
            onPressed: (){

            },
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 8,right: 16),
          child: IconButton(
            icon: Icon(Icons.share,color: Constant.primaryColor,),
            onPressed: (){

            },
          ),
        )
      ],
    );
  }

  Widget _setThumb(String url) {
    return Container(
        child: FadeInImage.assetNetwork(
          placeholder: Constant.placeholderList[Utils.getRandom()],
          image: url,
          width: MediaQuery.of(context).size.width,
          height: 250,
          fit: BoxFit.fitWidth,
        ),
//        decoration: BoxDecoration(
//            borderRadius: BorderRadius.circular(8), shape: BoxShape.rectangle),

    );
  }

}