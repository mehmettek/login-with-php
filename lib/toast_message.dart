import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
 

toast(String gelen) {
    return Fluttertoast.showToast(
        msg: gelen,
        toastLength: Toast.LENGTH_SHORT, //uzunlugu
        gravity: ToastGravity.TOP, //mesajın konumu
        backgroundColor: Colors.black,
        textColor: Colors.white);
  }