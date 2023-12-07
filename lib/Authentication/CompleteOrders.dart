import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../global/global.dart';
import 'OrderItems.dart';

class CompletedOrder extends StatefulWidget {
  const CompletedOrder({Key? key}) : super(key: key);

  @override
  State<CompletedOrder> createState() => _CompletedOrderState();
}

class _CompletedOrderState extends State<CompletedOrder> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersStream = Global.firestore.collection('orders').orderBy('create_at',descending: true).snapshots();
    return Scaffold(
      appBar: AppBar(title: const Text("Completed Orders"),),
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
              if(Global.currentuserid==data['userid'] && data['status'].toString().replaceAll(" ", "").toLowerCase() == 'completed'){
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> OrderItems(items: data['items'])));
                  },
                  child: Card(
                    child: ListTile(
                      title: Text("Order ID:"+data['id']),
                      subtitle: Text(DateFormat.yMMMMEEEEd().format(DateTime.parse(data['create_at']) ).toString() ),
                      trailing: Text(data['status']),
                    ),
                  ),
                );
              }else{
                return Container();
              }

            }).toList(),
          );
        },
      ),
    );
  }
}
