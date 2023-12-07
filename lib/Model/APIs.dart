

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class API{
  static var fcm = FirebaseMessaging.instance;
  static var firestore = FirebaseFirestore.instance;
  static Future<void> updateToken(String id) async{
    await fcm.requestPermission();
    await fcm.getToken().then((value) {

      if(value != null){

        print(value);
        firestore.collection("Users").doc(id).update({
          "pushtoken": value ?? "",
        });
      }

    }).onError((error, stackTrace) {
      print(error);
    });
}

}