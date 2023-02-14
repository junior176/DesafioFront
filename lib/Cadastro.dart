import 'package:desafio_front/Util.dart';
import 'package:desafio_front/Login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class cadastro extends StatefulWidget {
  const cadastro({Key? key}) : super(key: key);

  @override
  State<cadastro> createState() => _cadastroState();
}

class _cadastroState extends State<cadastro> {
  TextEditingController _nomeController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();
  TextEditingController _confirmaSenhaController = TextEditingController();

  double tamanhoErros = 0;

  @override
  void dispose() {
    _nomeController.clear();
    _emailController.clear();
    _senhaController.clear();
    _confirmaSenhaController.clear();
    super.dispose();
  }

  bool isEmailCorrect = false;
  final _formNomeKey = GlobalKey<FormState>();
  final _formEmailKey = GlobalKey<FormState>();
  final _formSenhaKey = GlobalKey<FormState>();
  final _formConfirmaSenhaKey = GlobalKey<FormState>();

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
                    'Cadastro de Usuário',
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
                    height: 380 + tamanhoErros,
                    width: getSistemaOperacional() == "Mobile" ? MediaQuery.of(context).size.width / 1.1 : 600,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 20),
                          child: Form(
                            key: _formNomeKey,
                              child:TextFormField(
                              controller: _nomeController,
                              onChanged: (val) {
                                setState(() {
                                // isEmailCorrect = isEmail(val);
                                });
                              },
                              validator: (value) {
                                if (value!.isEmpty && value.length < 5) {
                                  tamanhoErros += 20;
                                  return 'Nome Inválido.';
                                }else{
                                  tamanhoErros -= 20;
                                }
                              },
                              decoration: decorarionPadrao("Nome", Icons.person_outline),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                          child: Form(
                            key: _formEmailKey,
                            child:TextFormField(
                              controller: _emailController,
                              onChanged: (val) {
                                setState(() {
                                  // isEmailCorrect = isEmail(val);
                                });
                              },
                              validator: (value) {
                                if(!isEmail(value!)) return 'Email inválido.';
                              },
                              decoration: decorarionPadrao("Email", Icons.email_outlined, hint: "seu@email.com.br"),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Form(
                            key: _formSenhaKey,
                            child: TextFormField(
                              controller: _senhaController,
                              obscuringCharacter: '*',
                              obscureText: true,
                              decoration: decorarionPadrao("Senha", Icons.lock_outline, hint: "*********"),
                              validator: (value) {
                                if(!isSenha(value!)) return 'Senha deve ter ao menos um caractere especial, uma letra maiúscula e um número';

                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                          child: Form(
                            key: _formConfirmaSenhaKey,
                            child: TextFormField(
                              controller: _confirmaSenhaController,
                              obscuringCharacter: '*',
                              obscureText: true,
                              decoration: decorarionPadrao("Confrmar Senha", Icons.lock_outline, hint: "*********"),
                              validator: (value) {
                                if (value!.isEmpty || value != _senhaController.text) {
                                  return 'Senhas não conferem.';
                                }
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
                              // padding: EdgeInsets.only(
                              //     left: 120, right: 120, top: 20, bottom: 20),
                            ),
                            onPressed: () {
                              if (_formNomeKey.currentState!.validate() &&
                                  _formEmailKey.currentState!.validate() &&
                                  _formSenhaKey.currentState!.validate() &&
                                  _formConfirmaSenhaKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Processando')),
                                );
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
                        'Já tem uma conta?',
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