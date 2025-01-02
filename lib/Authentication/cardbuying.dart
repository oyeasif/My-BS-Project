import 'package:adminseller/Authentication/cartscreen.dart';
import 'package:adminseller/Model/cartitems.dart';
import 'package:adminseller/Model/categories.dart';
import 'package:adminseller/global/global.dart';
import 'package:adminseller/widgets/singlecard_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:provider/provider.dart';
import 'dart:io';

import '../widgets/error_dialogue.dart';

class cardbuying extends StatefulWidget {

  final singleproduct_widget data;



   cardbuying({required this.data});

  @override
  State<cardbuying> createState() => _cardbuyingState();
}

class _cardbuyingState extends State<cardbuying> {
  final _formkey = GlobalKey<FormState>();
  XFile? imageXFile;
  bool _loading = false;
  final ImagePicker _picker = ImagePicker();
  int productPrice=0;
  int a=1;
  String userimageurl = "null";
  @override
  void initState() {
    productPrice = int.parse(widget.data.productprice);
    // TODO: implement initState
    super.initState();
  }

  List cardDd = ["null","null","null","null","null","null","null","null","null","null","null"];
  List<int> value = [0,10,20,30,40,50,60,70,80,90,100];
  Map<String,String> cardD= {};
  @override
  Widget build(BuildContext context) {
    String catname = widget.data.catname;
    categories cat = Provider.of<Allcategories>(context,listen: false).getcatagory(catname);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.data.productname,
        ),

      ),

      body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(top: 5),
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Colors.white,
                        Colors.white,
                      ]
                  )
              ),
              child: Column(
                children: [
                  FullScreenWidget(
                    disposeLevel: DisposeLevel.Medium,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(widget.data.firstimage,
                      width: 400,
                      height: 400,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(20.0),
                        margin: EdgeInsets.only(right: 15,top: 15),
                          child: FullScreenWidget(
                            disposeLevel: DisposeLevel.Medium,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.network(widget.data.secondimage,
                              ),
                            ),
                          ),
                      ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(20.0),
                          margin: EdgeInsets.only(right: 15,top: 15),
                          child: FullScreenWidget(
                            disposeLevel: DisposeLevel.Medium,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.network(widget.data.thirdimage,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                    const  Text(
                        "Price:",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      const SizedBox(
                        width: 150,
                      ),
                      Text("Rs " +
                        productPrice.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          if(cat.inputFeilds.isNotEmpty)
                          ...cat.inputFeilds.map((e) {
                            return e!=""?Column(children: [CustomTextField(e),const SizedBox(height: 7,)],):Container();
                          })
                    ],
                    ),
                    ),
                  ),

                  const SizedBox(height: 3,),

                  if(cat.logoimage)
                  GestureDetector(
                    onTap: (){
                      _getImage();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Row(
                        children: [
                          Text("Choose logo...", style: TextStyle(fontSize: 18),),
                          CircleAvatar(
                            radius: MediaQuery.of(context).size.width * 0.10,
                            backgroundColor: Colors.white,
                            backgroundImage: imageXFile==null ? null : FileImage(File(imageXFile!.path)),
                            child: imageXFile == null ? Icon(
                              Icons.add_photo_alternate,
                              size: MediaQuery.of(context).size.width * 0.20,
                              color: Colors.grey,
                            ) : null,
                          ),
                        ],
                      ),
                    ),
                  ),



                  if (cat.badgematerial.isNotEmpty && cat.badgematerial.first != "")
                    Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const[
                            Text("Badge Material", style: TextStyle(fontSize: 18),),
                          ],),
                      ),
                      GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: cat.badgematerial.length,
                        gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 3.5,
                            crossAxisSpacing: 16
                        ),
                        itemBuilder: (context,index){
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomRadioButton(cat.badgematerial[index], 50+index),
                          );
                        },
                      ),
                      const Divider(color: Colors.black,),
                    ],
                    ),


                  if (cat.type.isNotEmpty && cat.type.first != "")
                    Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const[
                            Text("Type", style: TextStyle(fontSize: 18),),
                          ],),
                      ),
                      GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: cat.type.length,
                        gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 3.5,
                            crossAxisSpacing: 16
                        ),
                        itemBuilder: (context,index){
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomRadioButton(cat.type[index], 60+index),
                          );
                        },
                      ),
                      const Divider(color: Colors.black,),
                    ],
                    ),

                  if(cat.lamination==true)
                  Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const[
                          Text("Lamination", style: TextStyle(fontSize: 18),),
                        ],),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.count(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        childAspectRatio: 4.5,
                        crossAxisSpacing: 20,
                        children: [
                          CustomRadioButton("No", 20),
                          CustomRadioButton("Yes", 21),

                        ],),
                    ),

                    const Divider(color: Colors.black,),
                    const SizedBox(height: 10,),
                  ],),



                  if(cat.cutting)
                    Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const[
                            Text("Cutting", style: TextStyle(fontSize: 18),),
                          ],),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.count(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          childAspectRatio: 4.5,
                          crossAxisSpacing: 20,
                          children: [
                            CustomRadioButton("Straight Edge", 30),
                            CustomRadioButton("Round Edge", 31),

                          ],),
                      ),

                      const Divider(color: Colors.black,),
                      const SizedBox(height: 10,),
                    ],),

                  if(cat.printing)
                    Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const[
                            Text("Printing Sides:", style: TextStyle(fontSize: 18),),
                          ],),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.count(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          childAspectRatio: 4.5,
                          crossAxisSpacing: 20,
                          children: [
                          CustomRadioButton("Single", 40),
                          CustomRadioButton("Double", 41)
                        ],),
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //   children: [
                      //     CustomRadioButton("Single", 40),
                      //     CustomRadioButton("Double", 41)
                      //   ],),

                      const Divider(color: Colors.black,),
                      const SizedBox(height: 10,),
                    ],

                    ),
                  if (cat.paper.isNotEmpty && cat.paper.first != "")
                    Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const[
                            Text("Paper", style: TextStyle(fontSize: 18),),
                          ],),
                      ),
                      GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: cat.paper.length,
                        gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 3.5,
                            crossAxisSpacing: 16
                        ),
                        itemBuilder: (context,index){
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomRadioButton(cat.paper[index], index),
                          );
                        },
                      ),
                      const Divider(color: Colors.black,),
                    ],
                    ),

                  if (cat.size.isNotEmpty && cat.size.first != "")
                    Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const[
                            Text("Size", style: TextStyle(fontSize: 18),),
                          ],),
                      ),
                      GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: cat.size.length,
                        gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 3.5,
                            crossAxisSpacing: 16
                        ),
                        itemBuilder: (context,index){
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomRadioButton(cat.size[index], 10+index),
                          );
                        },
                      ),
                      const Divider(color: Colors.black,),
                    ],
                    ),

                  if (cat.innercards.isNotEmpty && cat.innercards.first != "")
                    Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const[
                            Text("Inner Card", style: TextStyle(fontSize: 18),),
                          ],),
                      ),
                      GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: cat.innercards.length,
                        gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 3.5,
                            crossAxisSpacing: 16
                        ),
                        itemBuilder: (context,index){
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomRadioButton(cat.innercards[index], 70+index),
                          );
                        },
                      ),
                      const Divider(color: Colors.black,),
                    ],
                    ),

                  if (cat.waxseal.isNotEmpty && cat.waxseal.first != "")
                    Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const[
                            Text("Wax Seal", style: TextStyle(fontSize: 18),),
                          ],),
                      ),
                      GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: cat.waxseal.length,
                        gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 3.5,
                            crossAxisSpacing: 16
                        ),
                        itemBuilder: (context,index){
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomRadioButton(cat.waxseal[index], 80+index),
                          );
                        },
                      ),
                      const Divider(color: Colors.black,),
                    ],
                    ),

                  if (cat.paperthickness.isNotEmpty && cat.paperthickness.first != "")
                    Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const[
                            Text("Paper Thickness", style: TextStyle(fontSize: 18),),
                          ],),
                      ),
                      GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: cat.paperthickness.length,
                        gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 3.5,
                            crossAxisSpacing: 16
                        ),
                        itemBuilder: (context,index){
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomRadioButton(cat.paperthickness[index], 90+index),
                          );
                        },
                      ),
                      const Divider(color: Colors.black,),
                    ],
                    ),


                  if (cat.Printing.isNotEmpty && cat.Printing.first != "")
                    Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const[
                            Text("Printing", style: TextStyle(fontSize: 18),),
                          ],),
                      ),
                      GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: cat.Printing.length,
                        gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 3.5,
                            crossAxisSpacing: 16
                        ),
                        itemBuilder: (context,index){
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomRadioButton(cat.Printing[index], 100+index),
                          );
                        },
                      ),
                      const Divider(color: Colors.black,),
                    ],
                    ),





                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                      children: [
                        const  Text(
                          "Quantity: ",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Color(0xffd6d6d6),
                          child: IconButton(
                            onPressed: (){
                              if(a>1) {
                                setState(() {
                                a--;
                              });
                              }

                            },
                            icon: Icon(Icons.remove, color: Colors.deepPurple,),
                          ),
                        ),
                        Text('   $a    ',
                        style: TextStyle(fontSize:25,),
                        ),
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Color(0xffd6d6d6),
                          child: IconButton(
                            onPressed: (){
                              setState(() {
                                a++;
                              });
                            },
                            icon: Icon(Icons.add, color: Colors.deepPurple),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Color(0xffd6d6d6),
                          child: TextButton(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.zero
                              ),
                              onPressed: (){
                            setState(() {
                              a=a+10;
                            });
                          }, child: Text(" +10 ",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                          )),
                        ),

                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ElevatedButton(
                      child:_loading? CircularProgressIndicator(): const Text(
                        "Add to Cart",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          padding: EdgeInsets.symmetric(horizontal: 30,vertical: 15)

                      ),
                      onPressed: () {
                        if(!_loading)
                        formValidation(cat.logoimage);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context)=>cartscreen(),)
                        );

                      },
                    ),
                  ),
                ],
              ),
            ),

      ),
    );
  }

  Widget CustomTextField(String name){
    return TextFormField(
        decoration:InputDecoration(
        label: Text(name),
    border:const OutlineInputBorder()
    ),
    validator: (value){
    if(value == null || value.isEmpty){
    return "Please enter $name";
    }
    return null;
    },
      onChanged: (value){
        cardD[name]= value;
      },
    );
  }
  Widget CustomRadioButton(String text, int index) {
    int i = (index/10).round();
    if(value[i]==index){
      cardDd[i]=text;
    }
    return OutlinedButton(
      onPressed: () {
        setState(() {
          if(value[i]==index){

          }else{
              productPrice-=((value[i]%10)*10);
              productPrice+=((index%10)*10);

          }
          value[i] = index;
          cardDd[i]=text;
        });
      },
      child: Text(
        text,
        style: TextStyle(
          color: (value[i] == index) ? Theme.of(context).colorScheme.primary : Colors.black,
        ),
      ),
      style: OutlinedButton.styleFrom(
     side:
      BorderSide(color: (value[i] == index) ? Theme.of(context).colorScheme.secondary : Colors.black),
    ));
  }


  Future<void> _getImage() async {
    imageXFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageXFile;
    });
  }

  Future<void> formValidation(bool logoimage) async
  {
    if(logoimage){
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

        setState(() {
          _loading = true;
        });

        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        fStorage.Reference reference = fStorage.FirebaseStorage.instance.ref().child("usersorder").child(Global.currentuserid).child(fileName);
        fStorage.UploadTask uploadTask = reference.putFile(File(imageXFile!.path));
        fStorage.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
        await taskSnapshot.ref.getDownloadURL().then((url)
        {
          userimageurl = url;

          //Save Info to Firestore

          saveItemToOrder();
          setState(() {
            _loading = false;
          });

        });
      }
    }
    else{
      saveItemToOrder();
      setState(() {
        _loading = false;
      });
    }
  }

  void saveItemToOrder(){
    if(_formkey.currentState!.validate()){
      _formkey.currentState?.save();
      cartItem finalitem = cartItem(
        image: widget.data.firstimage,
        name: widget.data.productname,
        price: productPrice.toString(),
        quantity: a.toString(),
        inputs: cardD,
        paper: cardDd[0]??"null",
        logo: userimageurl??"null",
        size: cardDd[1]??"null",
        lamination: cardDd[2]??"null",
        cutting: cardDd[3]??"null",
        printingSides: cardDd[4]??"null",
        badgematerial: cardDd[5]??"null",
        innercards: cardDd[7]??"null",
        type: cardDd[6]??"null",
        waxseal: cardDd[8]??"null",
        paperthickness: cardDd[9]??'null',
        Printing: cardDd[10]??'null',
      );
      Provider.of<cartItems>(context,listen: false).addItem(finalitem);
      Fluttertoast.showToast(
          msg: "Your order has been saved in shoppoing bag",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Theme.of(context).colorScheme.secondary,
          textColor: Theme.of(context).colorScheme.primary
      );
    }
  }
}
