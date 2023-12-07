import 'package:adminseller/Authentication/JazzCashScreen.dart';
import 'package:flutter/material.dart';

class SelectPaymentMethod extends StatefulWidget {
  final totalamount;
  const SelectPaymentMethod({Key? key,required this.totalamount}) : super(key: key);

  @override
  State<SelectPaymentMethod> createState() => _SelectPaymentMethodState();
}

class _SelectPaymentMethodState extends State<SelectPaymentMethod> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Payment Method"),),
      body: ListView(children: [
        Card(
          child: GestureDetector(
            onTap: (){
              Navigator.push(context,
                MaterialPageRoute(builder: (context)=> JazzCashScreen(totalamount: widget.totalamount)),
              );
            },
            child: ListTile(
              leading: Image.asset('images/jazzcash.png',height: 120,),
              title: const Text('Pay with'),
              subtitle: Text("JazzCash",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),),
              trailing: const Icon(Icons.navigate_next),
            ),
          ),
        )
      ],),
    );
  }
}
