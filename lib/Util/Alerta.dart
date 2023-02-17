import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

class Alerta {

  Alerta.Primario(String texto){
    BotToast.showSimpleNotification(title: texto);
  }

  Alerta.Atencao(String texto){
    BotToast.showSimpleNotification(title: texto, backgroundColor: Colors.amber, duration: Duration(seconds: 5), titleStyle: TextStyle(color: Colors.white), closeIcon: Icon(Icons.close, color: Colors.white));
  }

  Alerta.Sucesso({String? texto}){
    texto ??= 'Sucesso';
    BotToast.showSimpleNotification(title: texto, backgroundColor: Colors.green, titleStyle: TextStyle(color: Colors.white), closeIcon: Icon(Icons.close, color: Colors.white));
  }

  Alerta.Erro(String texto){
    BotToast.showSimpleNotification(title: texto, backgroundColor: Color(0xffa51b0b), duration: Duration(seconds: 5), titleStyle: TextStyle(color: Colors.white), closeIcon: Icon(Icons.close, color: Colors.white));
  }

  Alerta.Toast(String texto){
    BotToast.showText(text: texto, contentColor: Colors.green);
  }

}