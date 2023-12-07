import 'package:adminseller/global/global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../Model/ChatMessage.dart';

class ChatDetailPage extends StatefulWidget{
  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
String messagetxt= "";
bool _sending = false;
var txt = TextEditingController();

@override
  void dispose() {
    // TODO: implement dispose
  txt.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var messages = Provider.of<Messages>(context,listen: false).messages;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: SafeArea(
            child: Container(
              padding: EdgeInsets.only(right: 16),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back,color: Colors.white,),
                  ),
                  const SizedBox(width: 2,),
                   Icon(Icons.support_agent,size: 40,color: Theme.of(context).colorScheme.secondary,),
                  const SizedBox(width: 12,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Customer Support",style: TextStyle( fontSize: 16 ,fontWeight: FontWeight.w600,color: Colors.white),),
                        SizedBox(height: 6,),
                        Text("Online",style: TextStyle(color: Colors.grey, fontSize: 13),),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection("chats").doc(Global.currentuserid).collection("messages").orderBy("date",descending: true).snapshots(),
                builder: (context,AsyncSnapshot snapshot){
                  if(snapshot.hasData){
                    if(snapshot.data.docs.length < 1){
                      return const Center(
                        child: Text("No Message to show"),
                      );
                    }

                      return ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        reverse: true,
                        padding: EdgeInsets.only(top: 10,bottom: 10),
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index){
                          return Container(
                            padding: EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
                            child: Align(
                              alignment: (snapshot.data.docs[index]["messageType"] == "receiver"?Alignment.topLeft:Alignment.topRight),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: (snapshot.data.docs[index]["messageType"]  == "receiver"?Colors.grey.shade200:Theme.of(context).colorScheme.secondary),
                                ),
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data.docs[index]["messageContent"],
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    const SizedBox(height: 5,),
                                    Text(
                                      DateFormat("dd/MM/yy hh:mm a").format(DateTime.parse(snapshot.data.docs[index]["date"])).toString() ,
                                      style:const TextStyle(fontSize: 13,color: Colors.blueGrey),),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );

                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ),

          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 10,bottom: 10,top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child:const Icon(Icons.message, size: 20, ),
                    ),
                  ),
                  SizedBox(width: 15,),
                  Expanded(
                    child: TextField(
                      controller: txt,
                      onChanged: (value){
                        messagetxt = value;
                      },
                      decoration: const InputDecoration(
                          hintText: "Write message...",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none
                      ),
                    ),
                  ),
                  const SizedBox(width: 15,),
                  FloatingActionButton(
                    onPressed: (){
                      setState(() {
                        _sending = true;
                      });
                      String id = DateTime.now().millisecondsSinceEpoch.toString();
                      FirebaseFirestore.instance.collection("chats").doc(Global.currentuserid).collection("messages").doc(id).set({
                        "id": id,
                        "date": DateTime.now().toString(),
                        "messageContent": messagetxt,
                        "messageType": "sender",
                      }).then((value) {
                        setState(() {
                          _sending = false;
                          messagetxt = "";
                          txt.text = "";
                        });
                      }).then((value) async{
                        await Global.firestore.collection("chats").doc(Global.currentuserid).set({
                          'unread': true,
                          'date': DateTime.now().toString()
                        });
                      });
                    },
                    child: _sending? CircularProgressIndicator() : Icon(Icons.send,color: Colors.white,size: 18,),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    elevation: 0,
                  ),
                ],

              ),
            ),
          ),
        ],
      ),
    );
  }
}