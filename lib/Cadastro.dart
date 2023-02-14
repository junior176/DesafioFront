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
  TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.clear();
    super.dispose();
  }

  bool isEmailCorrect = false;
  final _formKey = GlobalKey<FormState>();

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
                  Container(
                    height: 380,
                    width: getSistemaOperacional() == "Mobile" ? MediaQuery.of(context).size.width / 1.1 : 600,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 20, top: 20),
                          child: TextFormField(
                            controller: _textEditingController,
                            onChanged: (val) {
                              setState(() {
                              // isEmailCorrect = isEmail(val);
                              });
                            },
                            decoration: decorarionPadrao("Nome", Icons.person_outline),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                          child: TextFormField(
                            controller: _textEditingController,
                            onChanged: (val) {
                              setState(() {
                                // isEmailCorrect = isEmail(val);
                              });
                            },
                            decoration: decorarionPadrao("Email", Icons.email_outlined, hint: "seu@email.com.br"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Form(
                            key: _formKey,
                            child: TextFormField(
                              obscuringCharacter: '*',
                              obscureText: true,
                              decoration: decorarionPadrao("Senha", Icons.lock_outline, hint: "*********"),
                              validator: (value) {
                                if (value!.isEmpty && value.length < 5) {
                                  return 'Senha não atende aos requisitos';
                                }
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                          child: Form(
                            child: TextFormField(
                              obscuringCharacter: '*',
                              obscureText: true,
                              decoration: decorarionPadrao("Confrmar Senha", Icons.lock_outline, hint: "*********"),
                              validator: (value) {
                                if (value!.isEmpty && value.length < 5) {
                                  return 'Confirmar Senha não atende aos requisitos';
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
                              if (_formKey.currentState!.validate()) {
                                // If the form is valid, display a snackbar. In the real world,
                                // you'd often call a server or save the information in a database.
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