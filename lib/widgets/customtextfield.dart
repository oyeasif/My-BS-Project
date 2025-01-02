import 'package:flutter/material.dart';


class customtextfield extends StatelessWidget {

  final TextEditingController? controller;
  final IconData? data;
  final String? hintText;
  bool? isObsecret = true;
  bool? enabled = true;

  customtextfield({
    this.controller,
    this.data,
    this.hintText,
    this.isObsecret,
    this.enabled,
});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(10),
      child: TextFormField(
        validator: (value){
          if(value!.isEmpty){
            return 'Fill the field';
          }
        },
        enabled: enabled,
        controller: controller,
        obscureText: isObsecret!,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          border: InputBorder.none,
          prefixIcon: Icon(
            data,
            color: Color.fromRGBO(38, 14, 147, 80),

          ),
          focusColor: Theme.of(context).primaryColor,
          hintText: hintText,

        ),

      ),
    );
  }
}
