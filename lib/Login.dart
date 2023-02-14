import 'package:desafio_front/LembrarSenha.dart';
import 'package:desafio_front/Util.dart';
import 'package:desafio_front/Cadastro.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.clear();
    super.dispose();
  }

  final _formEmailKey = GlobalKey<FormState>();
  final _formSenhaKey = GlobalKey<FormState>();
  double tamanhoErros = 0;
  double containerPrincipal = 260;


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
                    'Para continuar, efetue o login.',
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
                          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 20),
                          child: Form(
                              key: _formEmailKey,
                              child:TextFormField(
                            controller: _textEditingController,
                            onChanged: (val) {
                              setState(() {
                             //  isEmailCorrect = isEmail(val);
                              });
                            },
                            decoration: decorarionPadrao("Email", Icons.email_outlined, hint: "seu@email.com.br"),
                            validator: (value) {
                              if (value!.isEmpty)  return 'Campo obrigatório.';
                              if(!isEmail(value)) return 'Email inválido.';
                            },
                          )
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Form(
                            key: _formSenhaKey,
                            child: TextFormField(
                              obscuringCharacter: '*',
                              obscureText: true,
                              decoration: decorarionPadrao("Senha", Icons.lock_outline, hint: "*********"),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Campo obrigatório.';
                                }
                              },
                            ),
                          ),
                        ),
                        Padding(
                         padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                         child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => lembrarSenha()));
                                },
                                child: const Text(
                                  'Esqueceu sua senha?',
                                  style: TextStyle(
                                      color: Color(0xFF0086FF),
                                      fontWeight: FontWeight.w500),
                                ),
                              )
                            ],
                          )
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
                            onPressed: () {

                              tamanhoErros = 0;
                              if(!_formEmailKey.currentState!.validate()) tamanhoErros += 22;
                              if(!_formSenhaKey.currentState!.validate()) tamanhoErros += 22;

                              if(tamanhoErros > 0){
                                setState(() {
                                  containerPrincipal = 260 + tamanhoErros;
                                });
                              }

                              if (_formSenhaKey.currentState!.validate() &&
                                  _formEmailKey.currentState!.validate()
                                 ) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Processando')),
                                );
                              }
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => loginScreen()));
                            },
                            child: const Text(
                              'Entrar',
                              style: TextStyle(fontSize: 17),
                            )),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Não tem uma conta?',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                           Navigator.push(
                               context,
                               MaterialPageRoute(
                                   builder: (context) => cadastro()));
                        },
                        child: const Text(
                          'Cadastre-se',
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