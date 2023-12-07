import 'package:adminseller/widgets/singlecard_widget.dart';
import 'package:flutter/material.dart';
import 'package:adminseller/Model/carditems.dart';
import 'package:adminseller/Model/carditems.dart';
import 'package:provider/provider.dart';
import '../widgets/singlecategory_widget.dart';


class visitingcards extends StatefulWidget {
  final singlecategory_widget datas;

  const visitingcards({
    required this.datas
  });



  @override
  State<visitingcards> createState() => _visitingcardsState();
}

String capitalizeFirstLetter(String text) {
  return text
      .split(' ')
      .map((word) =>
  '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}')
      .join(' ');
}

class _visitingcardsState extends State<visitingcards> {



  var vs;
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<AllCards>(context,listen: false).fetchallvisitingcard(widget.datas.categoryname.toLowerCase().replaceAll(" ", "")).then((value) {
      updatescreen();
    });

  }
  @override
  Widget build(BuildContext context) {

    String text = widget.datas.categoryname;
    String capitalizedText = capitalizeFirstLetter(text);

      vs = Provider.of<AllCards>(context,listen: false).getallcards();
    String catname = widget.datas.categoryname.toLowerCase().replaceAll(" ", "");
    return Scaffold(
      appBar: AppBar(
        title: Text(capitalizedText),

      ),
      body: _loading?const Center(child: CircularProgressIndicator(),):

      Container(
        color: Colors.white70,
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Padding(padding: EdgeInsets.symmetric(
              horizontal: 12.0,
            ),
              child: GridView.builder(
                shrinkWrap: true,
                primary: true,
                itemCount: vs.length,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context,index){
                  return singleproduct_widget(productid: vs[index].productid , productname: vs[index].productname, firstimage: vs[index].firstimage, productprice: vs[index].productprice,secondimage: vs[index].secondimage,thirdimage: vs[index].thirdimage,catname: catname);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  updatescreen(){
    print("Updating");
    print(vs);
    setState(() {
      _loading=false;
    });
  }
}
