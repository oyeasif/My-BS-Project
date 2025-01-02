import 'package:adminseller/global/global.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'mainpage.dart';

class ProfileScreen extends StatefulWidget {
  Map<String,dynamic> data;
  ProfileScreen({Key? key,required this.data}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  XFile? imageXFile;
  final ImagePicker _picker = ImagePicker();

  String userimageurl = "";

  Future<void> _getImage() async {
    imageXFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageXFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile"),),
      body: Container(
        padding:  const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: ()
                  {
                    _getImage();
                  },
                  child: CircleAvatar(
                    radius: MediaQuery.of(context).size.width * 0.20,
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    backgroundImage: imageXFile==null ? null : FileImage(File(imageXFile!.path)),
                    child: widget.data["UserAvatarUrl"]!= null ?
                      CircleAvatar(
                        radius: MediaQuery.of(context).size.width * 0.20,
                        backgroundImage: NetworkImage( widget.data["UserAvatarUrl"],),
                      )
                      : imageXFile == null ? Icon(
                      Icons.add_photo_alternate,
                      size: MediaQuery.of(context).size.width * 0.20,
                      color: Colors.grey,
                    ) : null,
                  ),

                ),
              ),

              Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Theme.of(context).colorScheme.primary)
                ),
                child: ListTile(
                  trailing: IconButton(icon: const Icon(Icons.edit),onPressed: (){
                    updateDetails("UserName","att",widget.data["UserName"]);
                  },),
                  title: Text(widget.data["UserName"],
                    style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w500),),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Theme.of(context).colorScheme.primary)
                ),
                child: ListTile(
                  trailing: IconButton(icon: const Icon(Icons.edit),onPressed: (){
                    updateDetails("phone","att",widget.data["phone"]);
                  },),
                  title: Text(widget.data["phone"],
                    style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w500),),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Theme.of(context).colorScheme.primary)
                ),
                child: ListTile(
                  trailing: IconButton(icon: const Icon(Icons.edit),onPressed: (){
                    updateDetails("address","att",widget.data["address"]);
                  },),
                  title: Text(widget.data["address"],
                    style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w500),),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }

  Future<void> updateDetails(String title, String attr,String text)async{
    String newtext="";
    await showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text(title) ,
        content:
            TextFormField(
              initialValue: text,
              onChanged: (value){
                newtext=value;
              },
        ),
        actions: [
          TextButton(onPressed: (){
            Global.firestore.collection('Users').doc(widget.data['UserUID']).update({
              title:newtext,
            }).then((value) {
              Navigator.pop(context);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (c)=>mainpage(userid: Global.currentuserid ?? "null")));
            });
          }, child:const Text("Submit")),
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child:const Text("Cancel"))
        ],
      );
    });
  }
}
