import 'package:adminseller/Authentication/CompleteOrders.dart';
import 'package:adminseller/Authentication/OrderItems.dart';
import 'package:adminseller/global/global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'orderDesignImagesScreen.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({Key? key}) : super(key: key);

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  var completeddoc;
  var orders=[];
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersStream = Global.firestore.collection('orders').orderBy('create_at',descending: true).snapshots();

    return Scaffold(
      appBar: AppBar(title: const Text('My Orders'),
      actions: [IconButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (c)=> const CompletedOrder()));
      }, icon: const Icon(Icons.all_inbox))],),
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
              if(Global.currentuserid==data['userid']&& data['status'].toString().replaceAll(" ", "").toLowerCase() != 'completed'){
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> OrderItems(items: data['items'])));
                  },
                  child: Card(
                    child: ListTile(
                      title: Text("Order ID:"+data['id']),
                      subtitle: Text(DateFormat.yMMMMEEEEd().format(DateTime.parse(data['create_at']) ).toString() ),
                      trailing:data['status']=='waiting'? IconButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (c)=> OrderDesignImagesScreen(images: data['designImages'],orderId: data['id'],)) );
                      }, icon: Icon(Icons.navigate_next)) : Text("Status: "+data['status'],
                      style: TextStyle(
                          fontSize: 18,
                          backgroundColor: Colors.yellow,
                      ),
                      ),
                    ),
                  ),
                );
              }else{
                return Container();
              }

            }).toList(),
          );
        },
      )
    );
  }
}
