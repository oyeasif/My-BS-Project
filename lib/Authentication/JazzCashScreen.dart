import 'dart:ui';

import 'package:adminseller/Authentication/JazzCashPinScreen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class JazzCashScreen extends StatefulWidget {
  final totalamount;
  const JazzCashScreen({Key? key, required this.totalamount}) : super(key: key);

  @override
  State<JazzCashScreen> createState() => _JazzCashScreenState();
}

class _JazzCashScreenState extends State<JazzCashScreen> {
  String phonenumber = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            children: [
              Card(
                child: Image.asset('images/jazzcash.png',height: 200,width: MediaQuery.of(context).size.width,),
              ),
              const SizedBox(height: 15,),
               TextField(
                keyboardType: TextInputType.number,
                maxLength: 11,
                decoration: InputDecoration(label: Text("Enter phone number"),border: OutlineInputBorder()),
                onChanged: (txt){
                  phonenumber = txt;
                },
              ),
              const SizedBox(height: 5,),
              Text('Total amount to be paid:  '+(widget.totalamount.toString())),
              const SizedBox(height: 5,),
              Expanded(child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        backgroundColor: Color.fromRGBO(178, 26, 32,1),// NEW
                    ),
                    onPressed: () {
                      if(phonenumber.length < 11){
                        Fluttertoast.showToast(msg: "Enter correct Phone number");
                      }else{
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context)=> JazzPinScreen(phoneNumber: phonenumber, totalamount: widget.totalamount)),
                        );
                      }

                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  const SizedBox(height: 10,)
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
