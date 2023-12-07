
import 'package:adminseller/global/global.dart';
import 'package:flutter/foundation.dart';

class cartItem{
  final String image;
  final String name;
  final String price;
  Map<String,String> inputs;
  final String paper;
  final String size;
  final String lamination;
  final String cutting;
  final String printingSides;
  final String badgematerial;
  final String innercards;
  final String type;
  final String waxseal;
  final String logo;
  final String paperthickness;
  final String Printing;
  String quantity;

  cartItem({
    required this.image,
    required this.name,
    required this.price,
    required this.quantity,
    required this.inputs,
    required this.paper,
    required this.size,
    required this.lamination,
    required this.cutting,
    required this.logo,
    required this.printingSides,
    required this.badgematerial,
    required this.innercards,
    required this.type,
    required this.waxseal,
    required this.paperthickness,
    required this.Printing,
  });


}



class cartItems extends ChangeNotifier{
   List<cartItem> items =[];

   List<cartItem> get allitems{
    return [...items];
  }

  void addItem(cartItem item){
    if(items.indexWhere((element) => element.name==item.name) != -1){
      int i = items.indexWhere((element) => element.name == item.name);
      items[i].quantity = (double.parse(items[i].quantity)+double.parse(item.quantity)).toString();
    }else{
      items.add(item);
    }
    notifyListeners();
  }

  Map<String,dynamic> cartToJson(String id){
     return {
       "id" : id,
       "userid": Global.currentuserid,
       "create_at": DateTime.now().toString(),
       "status" : "pending",
       "rejected": false,
       "designImages":[],
       "items" : items.map((e) {
           return {
             "image": e.image,
             "name": e.name,
             "price": e.price,
             "quantity": e.quantity,
             "inputs": e.inputs,
             "paper": e.paper,
             "size": e.size,
             "lamination": e.lamination,
             "logo": e.logo,
             "cutting": e.cutting,
             "printingSides": e.printingSides,
             "badgematerial":e.badgematerial,
             "innercards":e.innercards,
             "type":e.type,
             "waxseal":e.waxseal,
             "PaperThickness":e.paperthickness,
             "Printing":e.Printing,
           };
         }).toList(),
     };
  }


   void clearCart(){
    items = [];
  }

  void removeitem(cartItem item){
     items.remove(item);
     notifyListeners();
  }

  int cartitemscount(){
     return items.length;
  }
}