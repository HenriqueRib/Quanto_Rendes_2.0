// import 'dart:io';
// ignore_for_file: deprecated_member_use, must_be_immutable, avoid_print, unnecessary_null_comparison

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quanto/main.dart';
import 'package:quanto/utils/constants.dart';
import 'package:quanto/utils/form_field_snippet.dart';
import 'package:qlevar_router/qlevar_router.dart';

final _formKey = GlobalKey<FormState>();
final _emailkey = GlobalKey<FormFieldState>();
final _passkey = GlobalKey<FormFieldState>();

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  void initState() {
    super.initState();
  }

  final TextEditingController _controllerLoginEmail =
      TextEditingController(text: "");
  final TextEditingController _controllerLoginPassword =
      TextEditingController(text: "");
  bool seePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: 1.sh,
        width: 1.sw,
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/img/bg12.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: 1,
              height: 1,
              color: Colors.transparent,
            ),
            SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: .05.sw),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: .10.sh),
                      Padding(
                        padding: EdgeInsets.only(bottom: .02.sw),
                        child: Image.asset(
                          'assets/img/logo.png',
                          height: .1.sh,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Texto principal \n Talvez outro',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontFamily: 'Libre',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: .04.sh),
                            child: Form(
                              key: _formKey,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Constants.color3),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 20,
                                        left: 40,
                                        right: 40,
                                      ),
                                      child: FormFieldSnippet(
                                        brightnessdark: true,
                                        textInputType:
                                            TextInputType.emailAddress,
                                        labelText: 'E-mail de login:',
                                        labelStyle: const TextStyle(
                                          color: Constants.color3,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.bold,
                                        ),
                                        style: const TextStyle(
                                          color: Constants.color3,
                                        ),
                                        controller: _controllerLoginEmail,
                                        validator: (v) {
                                          bool? validEmail =
                                              EmailValidator.validate(
                                                  "$v".replaceAll(' ', ''));
                                          if (!validEmail) {
                                            return "Não parece um e-mail válido.";
                                          }
                                          return null;
                                        },
                                        fieldKey: _emailkey,
                                        onChanged: (value) async {
                                          _emailkey.currentState?.validate();
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: .1.sw,
                                        right: .1.sw,
                                        bottom: .09.sh,
                                      ),
                                      child: Observer(builder: (_) {
                                        bool seePassword = true;
                                        return FormFieldSnippet(
                                          brightnessdark: true,
                                          textInputAction: TextInputAction.go,
                                          textInputType:
                                              TextInputType.visiblePassword,
                                          labelText: 'Senha:',
                                          labelStyle: const TextStyle(
                                            color: Constants.color3,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.bold,
                                          ),
                                          hintStyle: const TextStyle(
                                            color: Constants.color3,
                                          ),
                                          style: const TextStyle(
                                            color: Constants.color3,
                                          ),
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              // loginStore
                                              //     .setSeePassword(!seePassword);
                                            },
                                            icon: const Icon(
                                              Icons.remove_red_eye,
                                            ),
                                            color: Constants.color3,
                                          ),
                                          obscureText: !seePassword,
                                          controller: _controllerLoginPassword,
                                          validator: (v) {
                                            if (v == null || v == "") {
                                              return "Senha inválida";
                                            }
                                            if (v.length < 6) {
                                              return "Senha muito curta!";
                                            }
                                            return null;
                                          },
                                          fieldKey: _passkey,
                                          onChanged: (value) async {
                                            _passkey.currentState?.validate();
                                          },
                                        );
                                      }),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: .01.sh,
                            child: Column(
                              children: [
                                TextButton(
                                  onPressed: () async {
                                    EasyLoading.show(
                                        status: 'Realizando login...');
                                    QR.navigator.replaceLast('/main');
                                    await sharedPreferences?.setString(
                                      'ultimo_email',
                                      _controllerLoginEmail.text.toLowerCase(),
                                    );
                                    bool? validate =
                                        _formKey.currentState?.validate();
                                    if (validate != true) {
                                      EasyLoading.dismiss();
                                      return;
                                    }
                                    // String message =
                                    //     "Ocorreu um erro. Tente novamente mais tarde!";
                                    print(_controllerLoginEmail.text);
                                    // ResponseFunction? res =

                                    //     await loginStore.login(
                                    //   email: _controllerLoginEmail.text,
                                    //   password: _controllerLoginPassword.text,
                                    // );

                                    QR.navigator.replaceLast('/home');
                                    EasyLoading.dismiss();
                                    // if (res is ResponseFunction) {
                                    //   if (res.success == true) {
                                    //     QR.navigator.replaceLast('/home');
                                    //     return;
                                    //   } else {
                                    //     message = res.message ?? message;
                                    //   }
                                    //   Notifications.error(
                                    //     title: "Atenção",
                                    //     message: message,
                                    //   );
                                    //   return;
                                    // }
                                  },
                                  child: Ink(
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(colors: [
                                        Constants.color4,
                                        Constants.color5,
                                      ]),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    child: Container(
                                      constraints: const BoxConstraints(
                                        minWidth: 200,
                                        minHeight: 50,
                                      ),
                                      alignment: Alignment.center,
                                      child: const Text(
                                        'Entrar Agora!',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Constants.color1,
                                          fontSize: 21,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          QR.to('/esqueci_minha_senha');
                        },
                        child: RichText(
                          text: TextSpan(
                            text: 'Esqueceu sua senha? ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontFamily: 'Libre',
                              fontWeight: FontWeight.w600,
                            ),
                            children: const [
                              TextSpan(
                                text: 'Clique aqui',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: .02.sh),
                        child: ButtonTheme(
                          minWidth: 400.0,
                          height: 38,
                          child: TextButton(
                            child: const Text(
                              'Quero me cadastrar',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Constants.color6,
                                fontSize: 21,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {
                              QR.to('/cadastrar');
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: .04.sh),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: .02.sh),
                        child: const Text(
                          Constants.versionApp,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
