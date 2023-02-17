import 'package:bot_toast/bot_toast.dart';
import 'package:desafio_front/HomeLogado.dart';
import 'package:desafio_front/Util.dart';
import 'package:desafio_front/Login.dart';
import 'package:desafio_front/Util/Alerta.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class validarCodigoLogin extends StatefulWidget {
      validarCodigoLogin(this.email, this.token,{Key? key}) : super(key: key);

  String token;
  String email;

  @override
  State<validarCodigoLogin> createState() => _validarCodigoLoginState();
}

class _validarCodigoLoginState extends State<validarCodigoLogin> {
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
                    'Você receberá um código por email. Para continuar insira-o.',
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
                  Container(
                    height: containerPrincipal,
                    width: getSistemaOperacional() == "Mobile" ? MediaQuery.of(context).size.width / 1.1 : 600,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 20, top: 20),
                          child: Form(
                            key: _formCodigoKey,
                              child:TextFormField(
                              controller: _codigoController,
                              onChanged: (val) {
                                setState(() {
                                // isEmailCorrect = isEmail(val);
                                });
                              },
                              decoration: decorarionPadrao("Código", Icons.lock_outline, hint: "000000"),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  if (value.isEmpty)  return 'Campo obrigatório.';
                                }
                              },
                            )
                          ),
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(10.0)),
                                backgroundColor: Color(0xFF0086FF),
                                padding: const EdgeInsets.symmetric( horizontal: 131, vertical: 20)
                              // padding: EdgeInsets.only(
                              //     left: 120, right: 120, top: 20, bottom: 20),
                            ),
                            onPressed: () async {

                              setState(() {
                                containerPrincipal = !_formCodigoKey.currentState!.validate() ? 185 : 160;
                              });
                              if (_formCodigoKey.currentState!.validate()) {
                                var urlAPI = getUri( "/api/Login/ValidarCodigo");
                                BotToast.showLoading();
                                try {
                                  final response = await http.post(urlAPI,
                                      headers: {
                                        'Authorization': 'Bearer ${widget.token}',
                                      },
                                      body: {
                                        "Email": widget.email,
                                        "Codigo": _codigoController.text,
                                      });
                                  switch (response.statusCode) {
                                    case 200:
                                      db.collection('usuario').doc('LuizaLabs').set({
                                        'token': widget.token,
                                        'email': widget.email,
                                        'nome' : response.body
                                      });
                                      Navigator.push(context,MaterialPageRoute(builder: (context) => homeLogado(response.body)));
                                      break;

                                    case 401:
                                    case 404:
                                      Alerta.Erro("Código inválido.");
                                      break;

                                    default:
                                      Alerta.Erro(response.statusCode.toString());
                                      break;
                                  }
                                }finally{
                                  BotToast.closeAllLoading();
                                }
                              }
                            },
                            child: const Text(
                              'Confirmar',
                              style: TextStyle(fontSize: 17),
                            )),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Não recebeu?',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => login()));
                        },
                        child: const Text(
                          'Entre novamente',
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