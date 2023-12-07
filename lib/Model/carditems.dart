import 'dart:ui';
import 'package:adminseller/global/global.dart';
import 'package:flutter/cupertino.dart';

class Cards {
  final String productid;
  final String productname;
  final String productprice;
  final String firstimage;
  final String secondimage;
  final String thirdimage;






  Cards({
    required this.productid,
    required this.productname,
    required this.productprice,
    required this.firstimage,
    required this.secondimage,
    required this.thirdimage,

  });


}

class AllCards extends ChangeNotifier{
  List<Cards> cards = [
  ];

  List<Cards> getallcards(){
    return cards;
  }

  Future<void> fetchallvisitingcard(String catagory)async{
     final ref = Global.firestore.collection('cards').doc(catagory).collection('cards');
     var data;
     cards = [];
     await ref.get().then((value)  {

     value.docs.map((e){
       final c = e.data();
       cards.add(Cards(productid: c['id'],productname: c['productName'],productprice: c['productPrice'],firstimage: c['imageUrl'], secondimage: c['image2Url'],thirdimage: c['image3Url']));
     }).toList();

     });

  }
}

