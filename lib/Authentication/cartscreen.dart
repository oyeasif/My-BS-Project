import 'package:adminseller/Authentication/SelectPaymentMethod.dart';
import 'package:adminseller/Authentication/paymentmethod.dart';
import 'package:adminseller/Model/carditems.dart';
import 'package:adminseller/Model/cartitems.dart';
import 'package:flutter/material.dart';
import 'package:adminseller/widgets/singlecard_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class cartscreen extends StatefulWidget {




  @override
  State<cartscreen> createState() => _cartscreenState();
}

class _cartscreenState extends State<cartscreen> {

  @override
  Widget build(BuildContext context) {

   var cards = Provider.of<cartItems>(context,listen: false).allitems;
   print(cards);
   int totalbalance=0;
   cards.forEach((element) {
     totalbalance += (double.parse(element.price)*double.parse(element.quantity)).round();

   });
    return Scaffold(
      appBar: AppBar(
        title:const Text("Cart"),
      ),

      body: Container(
        decoration: const BoxDecoration(


        ),
        child: ListView.builder(
                  itemCount: cards.length,
                  itemBuilder: (context, index) {
                return Card(
                  color: Theme.of(context).colorScheme.secondary,
                  child: Padding(
                    padding: EdgeInsets.all(5),
                  child:ListTile(
                    leading: Image.network(cards[index].image),
                    title: Text("Product: " + cards[index].name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                    subtitle: Text(cards[index].quantity+" items for Rs. "+ (double.parse(cards[index].price)*double.parse(cards[index].quantity)).toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                    trailing: IconButton(icon: Icon(Icons.delete),onPressed: (){
                      showDialog(context: context, builder: (context){
                        return AlertDialog(
                          title: const Text("Delete"),
                          content: Text("Are you sure you want to delete item?",),
                          actions: [
                            TextButton(onPressed: (){
                              Provider.of<cartItems>(context,listen: false).removeitem(cards[index]);
                              setState(() {

                              });
                              Navigator.pop(context);
                            }, child: const Text("Yes")),
                            TextButton(onPressed: (){
                              Navigator.pop(context);
                            }, child: const Text("No"))
                          ],);
                      });
                    },),
                  ),
                ),
                );
        }),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorLight
        ),
        child: ButtonBar(
          buttonPadding: EdgeInsets.all(20),
          children: [
            Text("Total Amount: Rs. "+totalbalance.toString()),
            ElevatedButton(
                onPressed: (){

                  if(totalbalance!=0){

                    Navigator.push(context,
                      MaterialPageRoute(builder: (context)=> SelectPaymentMethod(totalamount: totalbalance)),
                    );
                    // Navigator.push(context,
                    //   MaterialPageRoute(builder: (context)=>paymentmethod(totalamount : totalbalance)),
                    // );
                  }else{
                    Fluttertoast.showToast(msg: "Please add some items to cart!");
                  }

              }, child: Text("Checkout")
            ),
          ],
        ),
      ),
    );
  }
}
