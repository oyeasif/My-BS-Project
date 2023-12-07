import 'package:adminseller/global/global.dart';
import 'package:flutter/material.dart';

class OrderDesignImagesScreen extends StatefulWidget {
  String orderId;
  List images;
  OrderDesignImagesScreen({Key? key, required this.images, required this.orderId}) : super(key: key);

  @override
  State<OrderDesignImagesScreen> createState() => _OrderDesignImagesScreenState();
}

class _OrderDesignImagesScreenState extends State<OrderDesignImagesScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: const Text("Design Images"),),
      body: Column(
          children: [
            Expanded(
                child: ListView.builder(itemBuilder: (BuildContext ctx , index){
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Column(
                      children: [
                        Text("Item "+(index+1).toString(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        Image.network(widget.images[index],
                          width: 300,height: 300,)
                      ],
                    ),
                  );
                },itemCount: widget.images.length,)
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(onPressed: ()async{
                  await Global.firestore.collection('orders').doc(widget.orderId).update({
                    'status':'design',
                    'rejected': true,
                  });
                  Navigator.pop(context);

                }, child: const Text("Decline")),
                ElevatedButton(onPressed: ()async{

                  await Global.firestore.collection('orders').doc(widget.orderId).update({
                    'status':'printing'
                  });
                  Navigator.pop(context);
                }, child: const Text("Accept"))
              ],
            )
          ],
        ),
    );
  }
}
