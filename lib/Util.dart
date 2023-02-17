import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:localstore/localstore.dart';

String servidor = "localhost:5001";

final db = Localstore.instance;

Uri getUri(String url){
  return kIsWeb ? Uri.http(servidor,url) : Uri.https(servidor,url);
}

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

InputDecoration decorarionPadrao(String label, IconData icone,  {String hint = "", Widget? suffix}) {
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
    suffixIcon: suffix,
    labelText: label,
    hintText: hint,
    labelStyle: const TextStyle(color: Color(0xFF0086FF)),
  );
}

bool isEmail(String email) {
  String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = RegExp(p);
  return regExp.hasMatch(email);
}

bool isSenha(String senha) {
  String p = r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[$*&@#!()¨%])[0-9a-zA-Z$*&@#!()¨%]{8,}$';
  RegExp regExp = RegExp(p);
  return regExp.hasMatch(senha);
}

extension Shuffle on String {
  String get shuffled => String.fromCharCodes(runes.toList()..shuffle());
}

String gerarSenha(){

  const _charsMin = 'aabbccddeeffgghhiijjkkllmmnnooppqqrrssttuuvvwwxxyyzz';
  const _charsMax = 'AABBCCDDEEFFGGHHIIJJKKLLMMNNOOPPQQRRSSTTUUVVWWXXYYZZ';
  const _numeros = '12345678901234567890123456789012345678901234567890';
  const _esp = '*&@#!%*&@#!%*&@#!%*&@#!%*&@#!%*&@#!%';
  Random _rnd = Random.secure();

  String senha = (
                   String.fromCharCodes(Iterable.generate(3, (_) => _charsMin.codeUnitAt(_rnd.nextInt(_charsMin.length)))) +
                   String.fromCharCodes(Iterable.generate(3, (_) => _charsMax.codeUnitAt(_rnd.nextInt(_charsMax.length))))+
                   String.fromCharCodes(Iterable.generate(3, (_) => _numeros.codeUnitAt(_rnd.nextInt(_numeros.length))))+
                   String.fromCharCodes(Iterable.generate(3, (_) => _esp.codeUnitAt(_rnd.nextInt(_esp.length))))
                 ).shuffled;
  return senha;
}