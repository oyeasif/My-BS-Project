import 'package:flutter/material.dart';

class errordialogue extends StatelessWidget {

  final String? message;
  errordialogue({this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Text(message!),
      actions: [
        ElevatedButton(
            child: Center(
              child: Text("OK"),
            ),
          style: ElevatedButton.styleFrom(
            primary: Colors.red,
          ),
          onPressed: (){
              Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
