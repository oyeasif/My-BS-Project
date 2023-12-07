import 'package:adminseller/Authentication/authscreen.dart';
import 'package:adminseller/Authentication/mainpage.dart';
import 'package:adminseller/Authentication/cardbuying.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class singleproduct_widget extends StatelessWidget {

  final String productid;
  final String productname;
  final String productprice;
  final String firstimage;
  final String secondimage;
  final String thirdimage;
  final String catname;


  singleproduct_widget(
      {
        required this.productid,
        required this.productname,
        required this.productprice,
        required this.firstimage,
        required this.secondimage,
        required this.thirdimage,
        required this.catname,
      }
      );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => cardbuying(data: singleproduct_widget(productid: productid, productname: productname, productprice: productprice, firstimage: firstimage,secondimage: secondimage, thirdimage: thirdimage,catname: catname,),)));
                  },
                child: Container(
                width: double.infinity,
                alignment: Alignment.topRight,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(firstimage),
                  ),
                ),
            ),
              ),
            ),
            SizedBox(height: 10,),
            Container(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text("Name: "+
                      productname,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4,),
                    Row(
                      children: [
                        Text(
                          "Price: Rs. $productprice",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
