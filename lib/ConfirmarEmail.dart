import 'package:bot_toast/bot_toast.dart';
import 'package:desafio_front/Util.dart';
import 'package:desafio_front/Login.dart';
import 'package:desafio_front/Util/Alerta.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class confirmarEmail extends StatefulWidget {
  confirmarEmail(this.email, {Key? key}) : super(key: key);

  String email;
  @override
  State<confirmarEmail> createState() => _confirmarEmailState();
}

class _confirmarEmailState extends State<confirmarEmail> {

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/img/bg.jpg'),
                fit: BoxFit.cover,
                opacity: 0.4)),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/img/logoLuizaLabs.png',
                     height: 120,
                    // width: 120,
                   ),
                  Text(
                    'Email confirmado com sucesso! Agora você pode logar no sistema.',
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                          // height: 1.5,
                          fontSize: 15),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => login()));
                        },
                        child: const Text(
                          'Entrar',
                          style: TextStyle(
                              color: Color(0xFF0086FF),
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}