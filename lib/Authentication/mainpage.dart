import 'package:adminseller/Authentication/MyOrderScreen.dart';
import 'package:adminseller/Authentication/ProfileScreen.dart';
import 'package:adminseller/Authentication/authscreen.dart';
import 'package:adminseller/Model/APIs.dart';
import 'package:adminseller/Model/categories.dart';
import 'package:adminseller/global/global.dart';
import 'package:adminseller/widgets/singlecategory_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../Model/cartitems.dart';
import 'ChatDetailPage.dart';

import 'cartscreen.dart';
import 'package:intl/intl.dart';

import 'changepassword.dart';

class mainpage extends StatefulWidget {
  String? userid;
  mainpage({Key? key, required this.userid}) : super(key: key);

  @override
  State<mainpage> createState() => _mainpageState();
}

class _mainpageState extends State<mainpage> {
  var ci;
  bool isSearching = false;
  Map<String, dynamic> data = {};
  @override
  void initState() {
    super.initState();

    final ref = FirebaseFirestore.instance
        .collection('Users')
        .doc(Global.currentuserid);
    ref.get().then((DocumentSnapshot snapshot) async {
      data = snapshot.data() as Map<String, dynamic>;
      await API.updateToken(Global.currentuserid);
    }).onError((error, stackTrace) => null);
    Provider.of<Allcategories>(context, listen: false)
        .fetchallcatagories()
        .then((value) {
      updateScreen();
    });
  }

  buildDrawer(String name, String email, String img) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(name),
            accountEmail: Text(email),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(img),
            ),
          ),
          ListTile(
            leading: TextButton.icon(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (c) => ProfileScreen(
                              data: data,
                            )));
              },
              icon: Icon(
                Icons.person,
                size: 24.0,
              ),
              label: Text('Profile'), // <-- Text
            ),
          ),
          ListTile(
            leading: TextButton.icon(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (c) => const MyOrderScreen()));
              },
              icon: Icon(
                Icons.shopping_cart,
                size: 24.0,
              ),
              label: Text('My Orders'), // <-- Te-xt
            ),
          ),
          ListTile(
            leading: TextButton.icon(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (c) => ChangePasswordScreen()));
              },
              icon: Icon(
                Icons.lock,
                size: 24.0,
              ),
              label: Text('Change Password'), // <-- Text
            ),
          ),
          ListTile(
            leading: TextButton.icon(
              onPressed: () {
                Global.currentuserid = 'null';
                Global.firebaseAuth.signOut().then((value) {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (c) => authscreen()));
                });
              },
              icon: Icon(
                Icons.logout,
                size: 24.0,
              ),
              label: Text('Log out'), // <-- Text
            ),
          ),
        ],
      ),
    );
  }

  bool _loading = true;
  String searchtext = "";

  @override
  Widget build(BuildContext context) {
    if (!isSearching) {
      ci = Provider.of<Allcategories>(context, listen: false).categoryitems;
    } else {
      ci =
          Provider.of<Allcategories>(context, listen: false).search(searchtext);
    }

    return _loading
        ? Scaffold(
            body: Center(
            child: CircularProgressIndicator(),
          ))
        : Scaffold(
            drawer: buildDrawer(
              data["UserName"].toString(),
              data['UserEmail'].toString(),
              data["UserAvatarUrl"].toString() ?? 'null',
            ),
            appBar: AppBar(
              backgroundColor: Colors.deepPurple,
              title: !isSearching
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.card_giftcard, color: Colors.white,),
                        Text(
                          " Mod Graphics",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontFamily: "Lobster",
                          ),
                        )
                      ],
                    )
                  : TextField(
                      onChanged: (value) {
                        setState(() {
                          searchtext = value;
                        });
                      },
                      style: TextStyle(color: Colors.white, fontSize: 20),
                      decoration: InputDecoration(
                          hintText: "Search here",
                          hintStyle: TextStyle(color: Colors.white)),
                    ),
              centerTitle: true,
              actions: [
                isSearching
                    ? IconButton(
                        iconSize: 30,
                        icon: const Icon(
                          Icons.cancel,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            this.isSearching = false;
                          });
                        },
                      )
                    : IconButton(
                        iconSize: 30,
                        icon: const Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            this.isSearching = true;
                          });
                        },
                      ),
                Stack(children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => cartscreen(),
                          ));
                    },
                    icon: Icon(Icons.shopping_bag_outlined, color: Colors.white,),
                  ),
                  Badge(
                    child: Text(
                      Provider.of<cartItems>(context, listen: true)
                          .cartitemscount()
                          .toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  // Badge(
                  //   badgeContent: Text(Provider.of<cartItems>(context,listen:true).cartitemscount().toString(),style: TextStyle(color: Colors.white),),
                  //   animationDuration: Duration(milliseconds: 3000),
                  // ),
                ]),
                SizedBox(
                  width: 20.0,
                )
              ],
            ),
            body: RefreshIndicator(
              onRefresh: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (c) =>
                            mainpage(userid: Global.currentuserid ?? "null")));
                return Future.value();
              },
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.black,
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Colors.white,
                          Colors.white,
                        ])),
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Text(
                        "Advertisements",
                        style: TextStyle(
                          fontSize: 25,
                          fontFamily: "Lobster",
                        ),
                      ),
                    ),
                    CarouselSlider(
                      items: [
                        ...Provider.of<Allcategories>(context, listen: false)
                            .adv
                            .map((e) {
                          return Card(
                            elevation: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.0),
                                image: DecorationImage(
                                  image: NetworkImage(e),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                        //1st Image of Slider
                      ],
                      //Slider Container properties
                      options: CarouselOptions(
                        height: 180.0,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        aspectRatio: 16 / 9,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enableInfiniteScroll: true,
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        viewportFraction: 0.8,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Text(
                        "Categories",
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.0,
                      ),
                      child: GridView.builder(
                        shrinkWrap: true,
                        primary: true,
                        itemCount: ci.length,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.1,
                        ),
                        itemBuilder: (context, index) {
                          return singlecategory_widget(
                            categoryid: ci[index].categoryid,
                            categoryname: ci[index].categoryname,
                            categoryimage: ci[index].categoryimage,
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              hoverColor: Colors.grey,
              child: Icon(
                Icons.chat,
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ChatDetailPage();
                }));
              },
            ),
          );
  }

  void updateScreen() {
    setState(() {
      _loading = false;
    });
  }
}
