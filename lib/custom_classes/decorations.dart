import 'package:flutter/material.dart';

class decorations {
  //Box Decoration:

  BoxDecoration boxDecor() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.black),
    );
  }

  BoxDecoration login_decor() {
    return BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/login.png'), fit: BoxFit.fill));
  }

  //Form Field Decoration:

  InputDecoration formDecor() {
    return const InputDecoration(
        hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(15.0))));
  }
}
