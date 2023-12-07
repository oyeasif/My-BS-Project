import 'package:flutter/material.dart';
import 'package:adminseller/Authentication/DebitCardScreen.dart';

class paymentmethod extends StatefulWidget {
  int totalamount;
   paymentmethod({Key? key, required this.totalamount}) : super(key: key);

  @override
  State<paymentmethod> createState() => _paymentmethodState();
}

class _paymentmethodState extends State<paymentmethod> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text("Choose your plan",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),),
            const SizedBox(height: 10.0,),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> PaymentDetailScreen(totalamount: widget.totalamount)
                ));
              },
              child: Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: Icon(Icons.credit_card,color: Colors.indigo,),
                  title: Text("Credit Card"),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
