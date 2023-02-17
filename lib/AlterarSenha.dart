import 'package:bot_toast/bot_toast.dart';
import 'package:desafio_front/LembrarSenha.dart';
import 'package:desafio_front/Login.dart';
import 'package:desafio_front/Util.dart';
import 'package:desafio_front/Cadastro.dart';
import 'package:desafio_front/Util/Alerta.dart';
import 'package:desafio_front/ValidarCodigoLogin.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class alterarSenha extends StatefulWidget {
  alterarSenha(this.email,{Key? key}) : super(key: key);

  String email;
  @override
  State<alterarSenha> createState() => _alterarSenhaState();
}

class _alterarSenhaState extends State<alterarSenha> {
  TextEditingController _senhaController = TextEditingController();
  TextEditingController _confirmaSenhaController = TextEditingController();

  @override
  void dispose() {
    _senhaController.clear();
    _confirmaSenhaController.clear();
    super.dispose();
  }

  final _formSenhaKey = GlobalKey<FormState>();
  final _formConfirmaSenhaKey = GlobalKey<FormState>();
  double tamanhoErros = 0;
  double containerPrincipal = 260;
  double _forcaSenha = 0;
  bool verSenha = false;


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
                    'Insira a nova senha.',
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
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Form(
                            key: _formSenhaKey,
                            child: TextFormField(
                              onChanged: (value) => _checarSenha(value),
                              controller: _senhaController,
                              obscuringCharacter: '*',
                              obscureText: !verSenha,
                              decoration: decorarionPadrao("Senha*", Icons.lock_outline, hint: "*********",
                                suffix: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // added line
                                  mainAxisSize: MainAxisSize.min, // added line
                                  children: <Widget>[
                                    IconButton(
                                        icon: Icon(!verSenha ? Icons.remove_red_eye_outlined : Icons.visibility_off_outlined, color: Color(0xFF0086FF)),
                                        onPressed: () {
                                          setState(() {
                                            verSenha = !verSenha;
                                          });
                                        }),
                                    Tooltip(
                                        message: "Gerar Senha Aleatória",
                                        child:IconButton(
                                            icon: Icon(Icons.lock_reset, color: Color(0xFF0086FF)),
                                            onPressed: () {
                                              setState(() {
                                                verSenha = true;
                                                String senhaGerada = gerarSenha();
                                                _senhaController.text = senhaGerada;
                                                _confirmaSenhaController.text = senhaGerada;
                                                _forcaSenha = 1;
                                              });
                                            })
                                    ),
                                  ],
                                ),
                              ),
                              validator: (value) {
                                if (!isSenha(value!)) return 'Pelo menos um caractere especial, uma letra maiúscula e um número';
                              },
                            ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(left: 22, right: 22),
                            child:LinearProgressIndicator(
                              value: _forcaSenha,
                              backgroundColor: Colors.grey[300],
                              color: _forcaSenha <= 1 / 4 ? Colors.red : _forcaSenha == 2 / 4  ? Colors.yellow : _forcaSenha == 3 / 4 ? Colors.blue : Colors.green,
                              minHeight: 5,
                            )
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20,
                              right: 20,
                              top: 20),
                          child: Form(
                            key: _formConfirmaSenhaKey,
                            child: TextFormField(
                              controller: _confirmaSenhaController,
                              obscuringCharacter: '*',
                              obscureText: !verSenha,
                              decoration: decorarionPadrao("Confirmar Senha*", Icons.lock_outline, hint: "*********"),
                              validator: (value) {
                                if (value!.isEmpty || value != _senhaController.text) return 'Senhas não conferem.';
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(10.0)),
                                backgroundColor: Color(0xFF0086FF),
                                padding: const EdgeInsets.symmetric( horizontal: 131, vertical: 20)
                            ),
                            onPressed: () async {
                              tamanhoErros = 0;
                              if(!_formConfirmaSenhaKey.currentState!.validate()) tamanhoErros += 22;
                              if(!_formSenhaKey.currentState!.validate()) tamanhoErros += 22;

                              if(tamanhoErros > 0){
                                setState(() {
                                  containerPrincipal = 260 + tamanhoErros;
                                });
                              }

                              if (_formSenhaKey.currentState!.validate() &&
                                  _formConfirmaSenhaKey.currentState!.validate()
                                 ) {
                                var urlAPI = getUri( "/api/Usuario/AlterarSenha");
                                BotToast.showLoading();
                                try {
                                  final response = await http.post(urlAPI,
                                      body: {
                                        "Email": widget.email,
                                        "Senha": _senhaController.text,
                                      });
                                  switch (response.statusCode) {
                                    case 200:
                                      String token = response.body;
                                      Navigator.push(context,MaterialPageRoute(builder: (context) => login()));
                                      break;

                                    case 401:
                                    case 404:
                                      Alerta.Erro("Usuário e/ou senha inválidos.");
                                      break;

                                    case 403:
                                      Alerta.Erro("Usuário não ativo.");
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
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => login()));
                        },
                        child: const Text(
                          'Voltar',
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
  void _checarSenha(String value) {
    String senha = value.trim();
    RegExp numReg = RegExp(r".*[0-9].*");
    RegExp letrasReg = RegExp(r".*[A-Za-z].*");
    RegExp totalReg = RegExp(r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[$*&@#])[0-9a-zA-Z$*&@#]{8,}$');

    if (senha.isEmpty) {
      setState(() {
        _forcaSenha = 0;
      });
    } else if (senha.length < 6) {
      setState(() {
        _forcaSenha = 1 / 4;
      });
    } else if (!letrasReg.hasMatch(senha) || !numReg.hasMatch(senha)) {
      setState(() {
        _forcaSenha = 2 / 4;
      });
    } else {
      if (!totalReg.hasMatch(senha)) {
        setState(() {
          _forcaSenha = 3 / 4;
        });
      } else {
        // Senha >= 8
        // Contém todas as validações
        setState(() {
          _forcaSenha = 1;
        });
      }
    }
  }
}