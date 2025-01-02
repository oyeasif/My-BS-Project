import 'package:adminseller/Authentication/login.dart';
import 'package:adminseller/Authentication/register.dart';
import 'package:flutter/material.dart';


class authscreen extends StatefulWidget {
  const authscreen({Key? key}) : super(key: key);

  @override
  State<authscreen> createState() => _authscreenState();
}

class _authscreenState extends State<authscreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              // gradient: LinearGradient(
              //   colors: [
              //     Colors.black,
              //     Colors.grey,
              //   ],
              //   begin: FractionalOffset(0.0, 0.0),
              //     end: FractionalOffset(1.0, 0.0),
              //   stops: [0.0,1.0],
              //   tileMode: TileMode.clamp,
              // )

            ),
          ),
          automaticallyImplyLeading: false,
          title: const Text("Mod Graphics",
          style: TextStyle(
            fontSize: 50,
            color: Colors.white,
            fontFamily: "Lobster",
          ),
          ),
        centerTitle: true,
          bottom: const TabBar(
            labelStyle: TextStyle(color: Colors.white),
            unselectedLabelColor: Colors.white,
            tabs: [
              Tab(
                icon: Icon(Icons.lock, color: Colors.white,),
                text: "Login",
              ),
              Tab(
                icon: Icon(Icons.lock, color: Colors.white,),
                text: "Register",
              ),
            ],
            indicatorColor: Colors.white38,
            indicatorWeight: 8,
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            // gradient: LinearGradient(
            //   begin: Alignment.topRight,
            //   end: Alignment.bottomLeft,
            //   colors: [
            //     Colors.grey,
            //     Colors.grey,
            //   ]
            // )
          ),
          child: const TabBarView(
            children: [
              login(),
              register(),
            ],
          ),
        ),
      ),
    );
  }
}
