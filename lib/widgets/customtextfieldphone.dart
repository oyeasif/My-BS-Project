import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
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



class customtextfieldphone extends StatelessWidget {

  final TextEditingController? controller;
  final IconData? data;
  final String? hintText;
  bool? isObsecret = true;
  bool? enabled = true;
  final Function completenum;



  customtextfieldphone({
    this.controller,
    this.data,
    this.hintText,
    this.isObsecret,
    this.enabled,
    required this.completenum,
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
      child: IntlPhoneField(
        flagsButtonPadding: const EdgeInsets.all(8),
        dropdownIconPosition: IconPosition.trailing,
        initialCountryCode: 'PK',

        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), // Only allow digits and specified special characters
        ],
        controller: controller,
        obscureText: isObsecret!,
        cursorColor: Theme.of(context).primaryColor,
        onChanged: (value){
          completenum(value.completeNumber);
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),

          prefixIcon: Icon(
            data,
            color: Colors.cyan,

          ),
          focusColor: Theme.of(context).primaryColor,
          hintText: hintText,

        ),

      ),
    );
  }
}
//
//
//
// @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.all(Radius.circular(10)),
//       ),
//       padding: const EdgeInsets.all(8.0),
//       margin: const EdgeInsets.all(10),
//       child: InternationalPhoneNumberInput(
//         selectorConfig: SelectorConfig(
//           selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
//         ),
//         textFieldController: controller,
//         initialValue: PhoneNumber(isoCode: 'PK'),
//         formatInput: false,
//         keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
//
//         inputDecoration: InputDecoration(
//           border: InputBorder.none,
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.all(Radius.circular(10)),
//           ),
//           prefixIcon: Icon(
//             data,
//             color: Colors.cyan,
//           ),
//           focusColor: Theme.of(context).primaryColor,
//           hintText: hintText,
//         ),
//
//         onInputChanged: (PhoneNumber number) {
//         String completePhoneNumber = number.parseNumber()!;
//         completenum(completePhoneNumber);
//       },
//
//       ),
//     );
//   }
// }
