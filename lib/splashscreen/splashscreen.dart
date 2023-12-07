import 'dart:async';

import 'package:adminseller/Authentication/authscreen.dart';
import 'package:adminseller/Authentication/mainpage.dart';
import 'package:adminseller/global/global.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class MysplashScreen extends StatefulWidget {
  const MysplashScreen({Key? key}) : super(key: key);

  @override
  State<MysplashScreen> createState() => _MysplashScreenState();
}

class _MysplashScreenState extends State<MysplashScreen> {

  startTimer()
  {
    Timer(const Duration(seconds: 4), ()async{
      if(Global.firebaseAuth.currentUser != null)
        {
          User? user = Global.firebaseAuth.currentUser;
          Global.currentuserid = user!.uid;
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (c)=>mainpage(userid: user?.uid ?? "null")));
        }
      else
        {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (c)=>const authscreen()));
        }

    });
  }

  @override
  void initState() {
   super.initState();

   startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset("images/splashscreen.jpg"),
              ),
              const SizedBox(height: 10,),
              const Padding(
                padding: EdgeInsets.all(18.0),
              child: Text(
                "MG Online Sell",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 40,
                  fontFamily: "Signatra",
                  letterSpacing: 3,
                ),
                
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
