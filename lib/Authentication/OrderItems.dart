import 'package:flutter/material.dart';

class OrderItems extends StatefulWidget {
  var items= [];
  OrderItems({Key? key,required this.items}) : super(key: key);

  @override
  State<OrderItems> createState() => _OrderItemsState();
}

class _OrderItemsState extends State<OrderItems> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Order Items"),),
      body: ListView(children: [
        ...widget.items.map((e) {
          return Card(
            child: ListTile(
            title: Text(e['name']),
            leading: CircleAvatar(backgroundImage: NetworkImage(e['image']),),
              trailing: Text(e['quantity']),
            ),
          );
        }).toList()
      ],),
    );
  }
}
