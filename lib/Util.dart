import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

String getSistemaOperacional({bool detalha = false}){

  if(kIsWeb){
    return "Web";
  }else{

    if(detalha){
      if(defaultTargetPlatform == TargetPlatform.android) return "Android";
      if(defaultTargetPlatform == TargetPlatform.iOS) return "iOS";
      if(defaultTargetPlatform == TargetPlatform.windows) return "Windows";
      if(defaultTargetPlatform == TargetPlatform.linux) return "Linux";
      if(defaultTargetPlatform == TargetPlatform.macOS) return "MacOS";
      return "Outro";

    }

    if ((defaultTargetPlatform == TargetPlatform.android) || (defaultTargetPlatform == TargetPlatform.iOS)) {
      return "Mobile";
    }
    else if ((defaultTargetPlatform == TargetPlatform.windows) || (defaultTargetPlatform == TargetPlatform.linux) || (defaultTargetPlatform == TargetPlatform.macOS)) {
      return "Desktop";
    }
    else {
      return "Outro";
    }

  }
}

InputDecoration decorarionPadrao(String label, IconData icone,  {String hint = ""}) {
 return InputDecoration(
    focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius:
        BorderRadius.all(Radius.circular(10))),
    enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius:
        BorderRadius.all(Radius.circular(10))),
    prefixIcon: Icon(
      icone,
      color: Color(0xFF0086FF),
    ),
    filled: true,
    fillColor: Colors.white,
    labelText: label,
    hintText: hint,
    labelStyle: const TextStyle(color: Color(0xFF0086FF)),
  );
}