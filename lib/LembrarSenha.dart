import 'package:bot_toast/bot_toast.dart';
import 'package:desafio_front/Util.dart';
import 'package:desafio_front/Login.dart';
import 'package:desafio_front/Util/Alerta.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class lembrarSenha extends StatefulWidget {
  const lembrarSenha({Key? key}) : super(key: key);

  @override
  State<lembrarSenha> createState() => _lembrarSenhaState();
}

class _lembrarSenhaState extends State<lembrarSenha> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.clear();
    super.dispose();
  }

  final _formEmailKey = GlobalKey<FormState>();
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
                    'Insira seu email para recuperar a senha.',
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
                            key: _formEmailKey,
                              child:TextFormField(
                              controller: _textEditingController,
                              decoration: decorarionPadrao("Email", Icons.email_outlined, hint: "seu@email.com.br"),
                              validator: (value) {
                                  if (value!.isEmpty)  return 'Campo obrigat??rio.';
                                  if(!isEmail(value)) return 'Email inv??lido.';
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
                            ),
                            onPressed: () async {
                              setState(() {
                                containerPrincipal = !_formEmailKey.currentState!.validate() ? 185 : 160;
                              });
                              if (_formEmailKey.currentState!.validate()) {
                                var urlAPI = getUri( "/api/Usuario/RecuperarSenha");
                                BotToast.showLoading();
                                try {
                                  final response = await http.post(urlAPI,
                                      body: {
                                        "Email": _textEditingController.text,
                                      });
                                  switch (response.statusCode) {
                                    case 200:
                                      Alerta.Sucesso(texto: "Foi enviado um email com as instru????es para a recupera????o de senha.");
                                      Navigator.push(context,MaterialPageRoute(builder: (context) => login()));
                                      break;

                                    case 401:
                                    case 404:
                                      Alerta.Erro("Email n??o encontrado.");
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
                        'J?? tem uma conta?',
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
                          'Entre',
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