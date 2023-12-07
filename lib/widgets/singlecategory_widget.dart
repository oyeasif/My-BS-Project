import 'package:adminseller/Authentication/visitingcards.dart';
import 'package:adminseller/Model/categories.dart';
import 'package:adminseller/global/global.dart';
import 'package:adminseller/widgets/singlecard_widget.dart';
import 'package:adminseller/widgets/singlecategory_widget.dart';
import 'package:adminseller/Authentication/cardbuying.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class singlecategory_widget extends StatelessWidget {

  final String categoryid;
  final String categoryname;
  final String categoryimage;

  singlecategory_widget(
      {
        required this.categoryid,
        required this.categoryname,
        required this.categoryimage,
      }
      );

  String capitalizeFirstLetter(String text) {
    return text
        .split(' ')
        .map((word) =>
    '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}')
        .join(' ');
  }


  @override
  Widget build(BuildContext context) {
    String text = categoryname;
    String capitalizedText = capitalizeFirstLetter(text);
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
        ),
        child: Stack(
          children: [
            Container(
              child: GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => visitingcards(datas: singlecategory_widget(categoryid: categoryid, categoryname: categoryname,categoryimage: categoryimage),)));
                },
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.topRight,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(categoryimage),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox( height: 8,),
            Container(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 5),
                child:
                    Container(
                      width: double.infinity,
                      height: 25,
                      color: Colors.black54,
                      child: Text(
                        capitalizedText,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Global.textcolor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
