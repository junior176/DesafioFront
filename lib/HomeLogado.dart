import 'package:desafio_front/Util.dart';
import 'package:desafio_front/Login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class homeLogado extends StatefulWidget {
  homeLogado(this.nome, {Key? key}) : super(key: key);

  String nome;

  @override
  State<homeLogado> createState() => _homeLogadoState();
}

class _homeLogadoState extends State<homeLogado> {
  TextEditingController _codigoController = TextEditingController();

  @override
  void dispose() {
    _codigoController.clear();
    super.dispose();
  }

  final _formCodigoKey = GlobalKey<FormState>();
  double containerPrincipal = 160;

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
                    'Olá ${widget.nome}, seja bem vindo.',
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
                          db.collection('usuario').doc('LuizaLabs').delete();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => login()));
                        },
                        child: const Text(
                          'Sair',
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