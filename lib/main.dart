import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:desafio_front/Login.dart';
import 'package:desafio_front/Util/Certificado.dart';
import 'package:flutter/material.dart';

void main() {
  String? ativarConta = Uri.base.queryParameters["ativarConta"];
  String? recuperarSenha = Uri.base.queryParameters["recuperarSenha"];
  WidgetsFlutterBinding.ensureInitialized();
  final context = SecurityContext.defaultContext;
  context.allowLegacyUnsafeRenegotiation = true;
  final httpClient = HttpClient(context: context);
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp(ativarConta, recuperarSenha));
}

class MyApp extends StatelessWidget {
  MyApp(this.ativarConta, this.recuperarSenha,{super.key});

  String? ativarConta;
  String? recuperarSenha;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Desafio LuizaLabs',
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: login(ativarConta: ativarConta, recuperarSenha: recuperarSenha),
    );
  }

}