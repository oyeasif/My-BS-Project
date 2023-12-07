import 'dart:ui';

import 'package:adminseller/Authentication/visitingcards.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../global/global.dart';

class categories {
  final String categoryid;
  final String categoryname;
  final String categoryimage;
  List paper;
  List size;
  List inputFeilds;
  bool lamination;
  bool cutting;
  List innercards;
  List waxseal;
  List type;
  List badgematerial;
  bool printing;
  bool logoimage;
  List paperthickness;
  List Printing;


  categories({
    required this.categoryid,
    required this.categoryname,
    required this.categoryimage,
    required this.size,
    required this.paper,
    required this.inputFeilds,
    required this.cutting,
    required this.innercards,
    required this.waxseal,
    required this.type,
    required this.badgematerial,
    required this.lamination,
    required this.printing,
    required this.logoimage,
    required this.paperthickness,
    required this.Printing,

  });


}

class Allcategories extends ChangeNotifier{
  List<categories> category = [
  ];
  List<String> adv = [];
  Future<void> fetchallcatagories()async{
    await FirebaseFirestore.instance
        .collection('cards')
        .get()
        .then((QuerySnapshot querySnapshot) async{
          category = [];
          await fetchFav();
      querySnapshot.docs.forEach((doc) {
        category.add(categories(categoryid: doc["id"],
            categoryname: doc["name"],
            categoryimage: doc["image"],
            paper: doc['paper']??[],
            size: doc['size']??[],
            inputFeilds: doc["inputFields"]??[],
            printing: doc['printingSides']??false,
            cutting: doc["cutting"]??false,
            logoimage: doc["logoimage"]??false,
            lamination: doc["lamination"]??false,
            innercards: doc['innercards']??[],
            waxseal: doc['waxseal']??[],
            type: doc['type']??[],
            badgematerial: doc['badgematerial']??[],
            paperthickness:doc['PaperThickness']??[],
            Printing:doc['Printing']??[],
        ),
        );
      });

    });
    notifyListeners();
  }

  Future<void> fetchFav()async{
    final ref = await FirebaseFirestore.instance.collection("advertise").doc("cards").get();


    adv.add(ref.data()!["img1"]);
    adv.add(ref.data()!["img2"]);
    adv.add(ref.data()!["img3"]);
    adv.add(ref.data()!["img4"]);
    adv.add(ref.data()!["img5"]);

    print(adv);
  }
  List<categories> get categoryitems{
    return [...category];
  }
  List<categories> search(String txt){
    List<categories> cat = [];
    category.forEach((element) {
      if(element.categoryname.toLowerCase().contains(txt.toLowerCase())){
        cat.add(element);
      }
    });
    return cat;
  }
  categories getcatagory(String name){
    return category.firstWhere((element) => element.categoryname.toLowerCase().replaceAll(" ", "").contains(name));
  }
}
