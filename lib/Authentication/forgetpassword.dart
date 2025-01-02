import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class forgetpassword extends StatefulWidget {
  const forgetpassword({Key? key}) : super(key: key);

  @override
  State<forgetpassword> createState() => _forgetpasswordState();
}

class _forgetpasswordState extends State<forgetpassword> {

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Reset Password'),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
            ),
          ),
        ),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left:20,top: 200,right: 20),
              child: Scaffold(
                body: Stack(
                  children: [
                    Column(
                      children: [
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            hintText: 'Email',
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        Container(
                          decoration: BoxDecoration(
                            color: Colors.deepPurple,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              // minimumSize: Size.fromHeight(50),
                              elevation: 0,
                            ),
                            icon: Icon(Icons.key, size: 32, color: Colors.white,),
                            label: Text(
                              'Reset Password',
                              style: TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            onPressed: (){
                              auth.sendPasswordResetEmail(email: emailController.text.toString()).then((value){
                                Fluttertoast.showToast(
                                    msg: 'We have sent you email to reset your password, please check email',
                                    toastLength: Toast.LENGTH_SHORT,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Theme.of(context).colorScheme.secondary,
                                    textColor: Theme.of(context).colorScheme.primary
                                );
                              }).onError((error, stackTrace){
                                Fluttertoast.showToast(
                                    msg: error.toString(),
                                    toastLength: Toast.LENGTH_SHORT,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Theme.of(context).colorScheme.secondary,
                                    textColor: Theme.of(context).colorScheme.primary
                                );
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )


          ],
        ),
      ),

    );
  }
}
