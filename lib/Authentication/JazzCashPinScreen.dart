

import 'dart:convert';
import 'package:adminseller/global/global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import '../Model/cartitems.dart';
import 'mainpage.dart';

class JazzPinScreen extends StatefulWidget {
  final String phoneNumber;
  final totalamount;
  const JazzPinScreen({Key? key,required this.phoneNumber, required this.totalamount}) : super(key: key);

  @override
  State<JazzPinScreen> createState() => _JazzPinScreenState();
}

class _JazzPinScreenState extends State<JazzPinScreen> {
  TextEditingController textEditingController = TextEditingController();
  String currentText = "";
  bool _loading = false;
  final firestroe = FirebaseFirestore.instance.collection("orders");
  payment() async{
    var digest;
    String dateandtime = DateFormat("yyyyMMddHHmmss").format(DateTime.now());
    String dexpiredate = DateFormat("yyyyMMddHHmmss").format(DateTime.now().add(Duration(days: 1)));
    String tre = "T"+dateandtime;
    String pp_Amount=widget.totalamount.toString();
    String pp_BillReference="billRef";
    String pp_Description="Description";
    String pp_Language="EN";
    String pp_MerchantID="MC58428";
    String pp_Password="90z7c29fu5";

    String pp_ReturnURL="https://sandbox.jazzcash.com.pk/ApplicationAPI/API/Payment/DoTransaction";
    String pp_ver = "1.1";
    String pp_TxnCurrency= "PKR";
    String pp_TxnDateTime=dateandtime.toString();
    String pp_TxnExpiryDateTime=dexpiredate.toString();
    String pp_TxnRefNo=tre.toString();
    String pp_TxnType="MWALLET";
    String ppmpf_1="4456733833993";
    String IntegeritySalt = "3xxb5x08y0";
    String and = '&';
    String superdata=
        IntegeritySalt+and+
            pp_Amount+and+
            pp_BillReference +and+
            pp_Description +and+
            pp_Language +and+
            pp_MerchantID +and+
            pp_Password +and+
            pp_ReturnURL +and+
            pp_TxnCurrency+and+
            pp_TxnDateTime +and+
            pp_TxnExpiryDateTime +and+
            pp_TxnRefNo+and+
            pp_TxnType+and+
            pp_ver+and+
            ppmpf_1
    ;



    var key = utf8.encode(IntegeritySalt);
    var bytes = utf8.encode(superdata);
    var hmacSha256 = new Hmac(sha256, key);
    Digest sha256Result = hmacSha256.convert(bytes);
    var url = 'https://sandbox.jazzcash.com.pk/ApplicationAPI/API/Payment/DoTransaction';

    var response = await http.post(Uri.parse(url), body: {
      "pp_Version": pp_ver,
      "pp_TxnType": pp_TxnType,
      "pp_Language": pp_Language,
      "pp_MerchantID": pp_MerchantID,
      "pp_Password": pp_Password,
      "pp_TxnRefNo": tre,
      "pp_Amount": pp_Amount,
      "pp_TxnCurrency": pp_TxnCurrency,
      "pp_TxnDateTime": dateandtime,
      "pp_BillReference": pp_BillReference,
      "pp_Description": pp_Description,
      "pp_TxnExpiryDateTime":dexpiredate,
      "pp_ReturnURL": pp_ReturnURL,
      "pp_SecureHash": sha256Result.toString(),
      "ppmpf_1":"43565465656"
    });

    print("response=>");
    print(response.body);
    addOrdertoFirebase();


  }

  addOrdertoFirebase(){
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    firestroe.doc(id).set(Provider.of<cartItems>(context,listen: false).cartToJson(id))
        .then((value) {
      Fluttertoast.showToast(msg: "Order Placed Successfully");
      Provider.of<cartItems>(context,listen: false).clearCart();
      _loading = false;
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> mainpage(userid: Global.currentuserid,)));
    }
    ).onError((error, stackTrace) {
      _loading = false;
      Fluttertoast.showToast(msg: "Order Failed try again!!!",backgroundColor: Theme.of(context).colorScheme.secondary,textColor: Theme.of(context).colorScheme.primary

      );
    });
  }

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
        Text("Enter four digit Pin send to phone number "+widget.phoneNumber),
        Padding(
          padding: const EdgeInsets.only(left: 40,right: 40,top: 10,bottom: 10),
          child: Center(
            child: PinCodeTextField(
              length: 4,
              obscureText: false,
              keyboardType: TextInputType.number,
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                selectedColor: Color.fromRGBO(178, 26, 32,1),
                selectedFillColor: Colors.white,
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 50,
                fieldWidth: 40,
                activeFillColor: Colors.white,
              ),
              animationDuration: const Duration(milliseconds: 300),
              backgroundColor: Colors.white,
              enableActiveFill: true,
              controller: textEditingController,
              onCompleted: (v) {
                debugPrint("Completed");
              },
              onChanged: (value) {
                debugPrint(value);
                setState(() {
                  currentText = value;
                });
              },
              beforeTextPaste: (text) {
                return true;
              },
              appContext: context,
            ),
          ),
        ),
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
                      if(currentText.length < 4){
                        Fluttertoast.showToast(msg: "Enter Pin to proceed");
                      }else{
                        payment();
                      }


                    },
                    child: const Text(
                      'Pay Now',
                      style: TextStyle(fontSize: 24, color: Colors.white),
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
