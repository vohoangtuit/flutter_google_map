
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

AppBar baseAppBar(String title){
  return AppBar(
    title: Text(title,),
    centerTitle: true,
    backgroundColor: Colors.red,
  );
}
TextStyle textButtonWhiteNormal(){
  return TextStyle(color: Colors.white, fontSize: 15,);
}

// todo:TextStyle White
TextStyle textTextWhiteNormal(){
  return TextStyle(color: Colors.white, fontSize: 14,);
}
TextStyle textTextWhiteMedium(){
  return TextStyle(color: Colors.white, fontSize: 16,);
}
TextStyle textTextWhiteLarge(){
  return TextStyle(color: Colors.white, fontSize: 18,);
}

// todo: TextStyle Black
TextStyle textTextBlackNormal(){
  return TextStyle(color: Colors.black, fontSize: 14,);
}
TextStyle textTextBlackMedium(){
  return TextStyle(color: Colors.black, fontSize: 16,);
}
TextStyle textTextBlackLarge(){
  return TextStyle(color: Colors.black, fontSize: 18,);
}

// todo: TextStyle Blue
TextStyle textTextBlueNormal(){
  return TextStyle(color: Colors.blue, fontSize: 14,);
}
TextStyle textTextBlueMedium(){
  return TextStyle(color: Colors.blue, fontSize: 16,);
}
TextStyle textTextBlueLarge(){
  return TextStyle(color: Colors.blue, fontSize: 18,);
}