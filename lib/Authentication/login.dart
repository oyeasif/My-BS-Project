import 'package:adminseller/Authentication/forgetpassword.dart';
import 'package:adminseller/Authentication/mainpage.dart';
import 'package:adminseller/Authentication/register.dart';
import 'package:adminseller/global/global.dart';
import 'package:adminseller/widgets/error_dialogue.dart';
import 'package:adminseller/widgets/loadingdialogue.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:adminseller/Authentication/register.dart';

import '../widgets/customtextfield.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();


  formValidation()
  {
    if(emailcontroller.text.isNotEmpty && passwordcontroller.text.isNotEmpty)
      {
        //login
        loginNow();
      }
    else
      {
        showDialog(
            context: context,
            builder: (c)
            {
              return errordialogue(message: "Please write email and password.",);
            }
        );
      }
  }

  loginNow() async
  {
    showDialog(
        context: context,
        builder: (c)
        {
          return loadingdialogue(message: "Checking user",);
        }
    );

    try{
      User? currentUser;
      UserCredential userCredential =  await Global.firebaseAuth.signInWithEmailAndPassword(
        email: emailcontroller.text.trim(),
        password: passwordcontroller.text.trim(),
      );
      if(userCredential != null && !userCredential.user!.emailVerified){
        userCredential.user!.sendEmailVerification();
        Navigator.pop(context);
        return Fluttertoast.showToast(msg: 'Verfication email has been sent to your email');
      }
      else{
        currentUser = userCredential.user!;
        Global.user = currentUser;
        Global.currentuserid = currentUser!.uid;
        print(Global.currentuserid);
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (c)=>  mainpage(userid: currentUser!.uid)));
      }

    }
    catch(error){
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c)
          {
            return errordialogue(message: error.toString(),
            );
          }
      );
    }




  }


  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential?> signInWithGoogle() async {
    try {
      print("Hello this is line __________________________________________");
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser
          ?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);
      return userCredential;
      // Trigger the Google authentication flow
      // final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      // print("Google user checking");
      // if (googleUser != null) {
      //   // Obtain the GoogleAuthCredential from the GoogleSignInAccount
      //   final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      //   final AuthCredential credential = GoogleAuthProvider.credential(
      //     accessToken: googleAuth.accessToken,
      //     idToken: googleAuth.idToken,
      //   );
      //   // Sign in to Firebase with the GoogleAuthCredential
      //   final UserCredential userCredential = await _auth.signInWithCredential(credential);
      //   final User? user = userCredential.user;
      //   // Return the signed-in user information
      //   print(userCredential);
      //   return userCredential;
    //}
    } catch (e) {
      print(e.toString());
    }
    return null;
  }


  Future<void> signInWithFacebook() async {
    try {
      // Log in to Facebook
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        // Get the access token
        final AccessToken accessToken = result.accessToken!;
        final String token = accessToken.tokenString;
        // Use the access token to sign in or fetch user information
        final userData = await FacebookAuth.instance.getUserData();
        // Do something with the signed-in user information
        print('Signed in as ${userData['name']}');
      } else if (result.status == LoginStatus.cancelled) {
        // User cancelled the login process
        print('Login with Facebook cancelled');
      } else {
        // Login failed
        print('Login with Facebook failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(

            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(10),

              // child: Text("Logo",
              // style: TextStyle(
              //   color: Color.fromRGBO(38, 14, 147, 80),
              //   fontSize: 100,
              //   fontFamily: "Lobster",
              // ),
              // ),
              child: Image.asset(
                  "images/logo.png",
                height: 130,
                width: 130,
              ),

            ),
          ),
          Form(
            key: _formkey,
            child: Column(
              children: [
                customtextfield(
                  data: Icons.email,
                  controller: emailcontroller,
                  hintText: "Email",
                  isObsecret: false,
                ),
                customtextfield(
                  data: Icons.lock,
                  controller: passwordcontroller,
                  hintText: "Password",
                  isObsecret: true,
                ),
              ],
            ),
          ),
           Container(
             alignment: Alignment.centerRight,
             margin: EdgeInsets.only(right: 10),
             child: GestureDetector(
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(38, 14, 147, 80),
                    fontSize: 20,
                  ),
                ),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => forgetpassword(),
                )),
              ),
           ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(50),
                      backgroundColor: Colors.deepPurple,
                        elevation: 0,
                        maximumSize: Size.infinite
                        // backgroundColor: Color.fromRGBO(65, 133, 193,1),
                    ),
                    icon: Icon(Icons.lock_open, size: 32, color: Colors.white,),
                    label: Text(
                      'Sign in',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    onPressed: () {
                      if(_formkey.currentState!.validate()){
                        formValidation();
                      }
                    },
                  ),
                ),
              ),

          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Padding(
              //   padding: const EdgeInsets.all(10.0),
              //   child: ElevatedButton.icon(
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: Color.fromRGBO(23, 115, 234,1),
              //       // minimumSize: Size.fromHeight(50),
              //         fixedSize: Size(150, 50)
              //     ),
              //     icon: Icon(Icons.facebook, size: 32),
              //     label: Text(
              //       'Facebook',
              //       style: TextStyle(fontSize: 18),
              //     ),
              //     onPressed: () {
              //       signInWithFacebook();
              //     },
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      elevation: 0,
                      // minimumSize: Size.fromHeight(50),
                        fixedSize: Size(150, 50),
                    ),
                    icon: Icon(Icons.mail, size: 32, color: Colors.white,),
                    label: Text(
                      'Google',
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    onPressed: () async {
                      User? currentUser;
                      final UserCredential? userCredential = await signInWithGoogle();
                      // Handle the signed-in user here
                      if (userCredential != null) {
                      // User is signed in
                        currentUser = userCredential.user!;
                        Global.user = currentUser;
                        Global.currentuserid = currentUser!.uid;
                        print(Global.currentuserid);
                        Navigator.pop(context);
                        Navigator.push(context, MaterialPageRoute(builder: (c)=>  mainpage(userid: currentUser!.uid)));
                      print('Signed in as ${userCredential.user?.displayName}');
                      } else {
                      // Sign in failed
                      print('Sign in with Google failed');
                      }
                      },
                  ),
                ),
              ),
            ],
          ),


        ],
      ),
    );
  }
}
