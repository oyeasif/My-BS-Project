import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';



class customtextfieldemail extends StatelessWidget {



  final TextEditingController? controller;
  final IconData? data;
  final String? hintText;
  bool? isObsecret = true;
  bool? enabled = true;


  customtextfieldemail({
    this.controller,
    this.data,
    this.hintText,
    this.isObsecret,
    this.enabled,
  });



  @override
  Widget build(BuildContext context) {

    String? validateEmail(String? value) {
      const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
          r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
          r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
          r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
          r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
          r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
          r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
      final regex = RegExp(pattern);

      return value!.isNotEmpty && !regex.hasMatch(value)
          ? 'Enter a valid email address'
          : null;
    }

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(10),
      child: TextFormField(
        onChanged: validateEmail,
        enabled: enabled,
        controller: controller,
        obscureText: isObsecret!,
        validator: validateEmail,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
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

