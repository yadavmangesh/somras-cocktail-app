import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:somras/model/Cocktail.dart';
import 'package:somras/utils/constant.dart';
import 'package:somras/detailscreen/DetailScreen.dart';
import 'package:somras/utils/utlis.dart';

class PopularDrinksItem extends StatefulWidget {
  final Cocktail cocktail;

  PopularDrinksItem(this.cocktail);

  @override
  State<StatefulWidget> createState() {
    return PopularDrinksState(cocktail);
  }
}

class PopularDrinksState extends State<PopularDrinksItem> {
  final Cocktail cocktail;

  List<String> tagList;

  int tagLength;

  PopularDrinksState(this.cocktail);

  @override
  void initState() {
    super.initState();
    tagList = Utils.getTagList(cocktail.strTags);

    if(tagList.length>3){
       tagLength=4;
    }else{
      tagLength=tagList.length;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      child: Card(
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        borderOnForeground: false,
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: InkWell(
          onTap: () {
            Utils.detailPageRoute(buildContext: context,page: DetailScreen(cocktail));
          },
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _setThumb(cocktail.strDrinkThumb),
              Expanded(
                child: _getTitleAndTag(cocktail.strDrink, cocktail.strTags),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _getTitleAndTag(String title, String tags) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
         Column(
           mainAxisSize: MainAxisSize.min,
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Flexible(
               child: Container(
                 margin: EdgeInsets.only(
                   top: 16,
                 ),
                 child: _getTitle(
                     title: cocktail.strDrink,
                     size: 16,
                     fontWeight: FontWeight.w500,
                     textOverflow: TextOverflow.ellipsis,
                     letter: 1),
               ),
             ),
             Flexible(
               child: Container(
                 margin: EdgeInsets.only(right: 16),
//             child: _getTitle(title:Constant.getTags(cocktail.strTags),size:12,fontWeight:FontWeight.w400,
//                 textOverflow: TextOverflow.ellipsis,letter: 0),
                 child: Wrap(
                     children: List.generate(tagLength, (index) {
                     return Utils.getTagChips(tagList[index]);
                   }),
                 ),
               ),
             ),
           ],
         ),
        Align(
             alignment: Alignment.bottomRight,
               child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                 children: [
                  Align(
                    alignment: Alignment.bottomRight,
                    child:  FlatButton(
                      child: const Text("Quick Look",
                       style: TextStyle(
                         fontFamily: "Poppins"
                       ),
                      ),
                      textColor: Theme.of(context).primaryColor,
                      onPressed: () {},

                    ),
                  ),
                   Align(
                    alignment: Alignment.bottomRight,
                      child: IconButton(
                        tooltip: "Save",
                        icon: Icon(Icons.bookmark_border),
                        onPressed: () {
                         setState(() {});
                     },
                     iconSize: 24,
                     color: Theme.of(context).primaryColor,
                     ),
                   )
                 ],
               ),
        )
      ],
    );
  }



  Widget _getTitle(
      {String title,
      double size,
      FontWeight fontWeight,
      TextOverflow textOverflow,
      double letter}) {
    return Text(
      title,
      style: TextStyle(
          fontFamily: "Poppins",
          fontSize: size,
          letterSpacing: letter,
          fontWeight: fontWeight),
    );
  }

  Widget _setThumb(String url) {
    return Container(
      margin: EdgeInsets.all(16),
      child: Container(
        clipBehavior: Clip.antiAlias,
        child: FadeInImage.assetNetwork(
          placeholder: Constant.placeholderList[Utils.getRandom()],
          image: url,
          width: 120,
          height: 150,
          fit: BoxFit.fill,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), shape: BoxShape.rectangle),
      ),
    );
  }
}
