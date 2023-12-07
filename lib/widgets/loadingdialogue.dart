import 'package:adminseller/widgets/progressbar.dart';
import 'package:flutter/material.dart';

class loadingdialogue extends StatelessWidget {

  final String? message;
  loadingdialogue({this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          circularprogress(),
          SizedBox(height: 10,),
          Text(message! + ", Please wait...")
        ],
      ),
    );
  }
}
