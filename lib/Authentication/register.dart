import 'dart:io';

import 'package:adminseller/Authentication/login.dart';
import 'package:adminseller/Authentication/mainpage.dart';
import 'package:adminseller/main.dart';
import 'package:adminseller/widgets/customtextfield.dart';
import 'package:adminseller/widgets/error_dialogue.dart';
import 'package:adminseller/widgets/loadingdialogue.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../global/global.dart';
import '../widgets/custometextfieldname.dart';
import '../widgets/customtextfieldemail.dart';
import '../widgets/customtextfieldphone.dart';




class register extends StatefulWidget {
  const register({Key? key}) : super(key: key);

  @override
  State<register> createState() => _registerState();


}

class _registerState extends State<register> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  String completeNum = '';
  TextEditingController anycontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confirmpasswordcontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController locationcontroller = TextEditingController();


    XFile? imageXFile;
    final ImagePicker _picker = ImagePicker();

    String userimageurl = "";

    Future<void> _getImage() async {
      imageXFile = await _picker.pickImage(source: ImageSource.gallery);
      setState(() {
        imageXFile;
      });
    }

  Future<void> formValidation() async
  {
    if(imageXFile==null){
      showDialog(
          context: context,
          builder: (c){
            return errordialogue(
              message: "Please select an image.",
            );
          }
      );
    }
    else{
      if(passwordcontroller.text==confirmpasswordcontroller.text)
      {
        if(passwordcontroller.text.isNotEmpty && confirmpasswordcontroller.text.isNotEmpty && emailcontroller.text.isNotEmpty && namecontroller.text.isNotEmpty && phonecontroller.text.isNotEmpty && locationcontroller.text.isNotEmpty)
        {
          showDialog(
              context: context,
              builder: (c){
                return loadingdialogue(message: "Registering Account",);
              }
          );

          String fileName = DateTime.now().millisecondsSinceEpoch.toString();
          fStorage.Reference reference = fStorage.FirebaseStorage.instance.ref().child("users").child(fileName);
          fStorage.UploadTask uploadTask = reference.putFile(File(imageXFile!.path));
          fStorage.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
          await taskSnapshot.ref.getDownloadURL().then((url)
          {
            userimageurl = url;

            //Save Info to Firestore

            AuthenticateUserAndSignUp();

          });
        }
        else{
          showDialog(
              context: context,
              builder: (c){
                return errordialogue(
                  message: "Please write the complete required info for Registration.",
                );
              }
          );
        }
      }
      else{
        showDialog(
            context: context,
            builder: (c){
              return errordialogue(
                message: "Password do not match.",
              );
            }
        );
      }
    }
  }

  void AuthenticateUserAndSignUp() async{
    User? currentUser;
    await Global.firebaseAuth.createUserWithEmailAndPassword(
        email: emailcontroller.text.trim(),
        password: passwordcontroller.text.trim(),
    ).then((auth)async{
      currentUser = auth.user;
      if(auth != null && !auth.user!.emailVerified){
        await saveDataToFirestore(currentUser!);
        auth.user!.sendEmailVerification();
        Global.firebaseAuth.signOut();
        currentUser = null;
        Navigator.pop(context);
        namecontroller.clear();
        emailcontroller.clear();
        passwordcontroller.clear();
        confirmpasswordcontroller.clear();
        phonecontroller.clear();
        locationcontroller.clear();
        imageXFile = null;
        setState(() {

        });
        return showDialog(context: context, builder: (_){ return AlertDialog(
          title: Text('Email Sent'), content: Text("The link has been sent to your email. Kindly check your email and verify.") ,
        actions: [ElevatedButton(onPressed: (){Navigator.pop(context);}, child: Text('Ok'))],);});
          //Fluttertoast.showToast(msg: 'Verfication email has been sent to your email');
      }
    }).catchError((error){
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c){
            return errordialogue(
              message: error.message.toString(),
            );
          }
      );
    });

    // if(currentUser != null)
    //   {
    //     Global.currentuserid = currentUser!.uid ?? "null";
    //     saveDataToFirestore(currentUser!).then((value){
    //       Navigator.pop(context);
    //       //send user to Homepage
    //
    //       Route newRoute = MaterialPageRoute(builder: (c) => mainpage(userid:currentUser!.uid));
    //       Navigator.pushReplacement(context, newRoute);
    //     });
    //   }
  }

  void validateEmail(String val) {
    if(val.isEmpty){
      setState(() {
        showDialog(
            context: context,
            builder: (c){
              return errordialogue(
                message: "Email can not be empty",
              );
            });
      });
    }else if(!EmailValidator.validate(val, true)){
      setState(() {
        showDialog(
            context: context,
            builder: (c){
              return errordialogue(
                message: "Invalid Email Address",
              );
            });
      });
    }else{
      setState(() {

        showDialog(
            context: context,
            builder: (c){
              return errordialogue(
                message: "",
              );
            });
      });
    }
  }


  Future saveDataToFirestore(User currentUser) async {
  FirebaseFirestore.instance.collection("Users").doc(currentUser.uid).set({
    "UserUID": currentUser.uid,
    "UserEmail": currentUser.email,
    "UserName": namecontroller.text.trim(),
    "UserAvatarUrl": userimageurl,
    "phone": completeNum,
    "address": locationcontroller.text.trim(),
    "status": "approved",
    "easrnings": 0.0,
    "pushtoken": "",

  });

  //Save D

  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [

            const SizedBox(height: 10,),
              InkWell(
                onTap: ()
                {
                  _getImage();
                },
                child: CircleAvatar(
                  radius: MediaQuery.of(context).size.width * 0.20,
                  backgroundColor: Colors.grey.withOpacity(0.4),
                  backgroundImage: imageXFile==null ? null : FileImage(File(imageXFile!.path)),
                  child: imageXFile == null ? Icon(
                    Icons.add_photo_alternate,
                    size: MediaQuery.of(context).size.width * 0.20,
                    color: Colors.grey,
                  ) : null,
                ),

              ),
            const SizedBox(height: 10,),
            Form(
              key: _formkey,
              child: Column(
                children: [
                  customtextfieldname(
                    data: Icons.person,
                      controller: namecontroller,
                      hintText: "Name",
                    isObsecret: false,
                  ),
                  customtextfieldemail(
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
                  customtextfield(
                    data: Icons.lock,
                    controller: confirmpasswordcontroller,
                    hintText: "Confirm Password",
                    isObsecret: true,
                  ),
                  customtextfieldphone(
                    completenum: completeNumber,
                    controller: phonecontroller,
                    hintText: "Phone",
                    isObsecret: false,
                  ),
                  customtextfield(
                    data: Icons.my_location,
                    controller: locationcontroller,
                    hintText: "Address",
                    isObsecret: false,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(500, 50),
                    elevation: 0,
                    backgroundColor: Colors.deepPurple,
                    // backgroundColor: Color.fromRGBO(65, 133, 193,1),
                  ),
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  onPressed: (){
                    if(_formkey.currentState!.validate()){
                      formValidation();
                    }
                  },
                ),
              ),
            ),
            SizedBox(height: 20,)
          ],
        ),
      ),

    );
  }

  completeNumber(String num){
    completeNum = num;
  }
}
