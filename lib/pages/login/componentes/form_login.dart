import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:email_validator/email_validator.dart';
import 'package:teste_projeto_47/utils/notifications.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:teste_projeto_47/utils/constants.dart';
import 'package:teste_projeto_47/store/utils.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:qlevar_router/qlevar_router.dart';

final utilStore = GetIt.I.get<Utils>();
final _formKey = GlobalKey<FormState>();
final FocusNode _focusEmail = FocusNode();
final FocusNode _focusPassword = FocusNode();
final TextEditingController _controllerLoginEmail =
    TextEditingController(text: "");
final TextEditingController _controllerLoginPassword =
    TextEditingController(text: "");
bool seePassword = false;

class FormLogin extends StatelessWidget {
  const FormLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      if (utilStore.formLogin == false) {
        return Container();
      }

      return SizedBox(
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: 15.sp),
                child: Text(
                  'LOGIN',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Constants.color1,
                    fontSize: 18.sp,
                  ),
                ),
              ),
              Observer(builder: (_) {
                return Container(
                  height: 40.sp,
                  padding: EdgeInsets.only(left: 10.0.sp),
                  decoration: BoxDecoration(
                    color: Constants.color1.withOpacity(0.2.sp),
                    borderRadius: BorderRadius.circular(15.0.sp),
                  ),
                  child: TextFormField(
                    focusNode: _focusEmail,
                    style: const TextStyle(color: Constants.color1),
                    decoration: const InputDecoration(
                      labelText: 'E-mail',
                      labelStyle: TextStyle(color: Constants.color1),
                      border: InputBorder.none,
                    ),
                    controller: _controllerLoginEmail,
                    onChanged: (value) async {
                      bool? validEmail =
                          EmailValidator.validate(value.replaceAll(' ', ''));
                      if (!validEmail) {
                        utilStore.setMessageEmailValida(
                            'Não parece ser um e-mail valido');
                      } else {
                        utilStore.setMessageEmailValida('');
                      }
                    },
                  ),
                );
              }),
              Observer(builder: (_) {
                return Text(
                  utilStore.messageEmailValida,
                  style: const TextStyle(color: Colors.red),
                );
              }),
              Container(
                height: 40.sp,
                padding: EdgeInsets.only(left: 10.0.sp),
                decoration: BoxDecoration(
                  color: Constants.color1.withOpacity(0.2.sp),
                  borderRadius: BorderRadius.circular(15.0.sp),
                ),
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    Observer(builder: (_) {
                      return TextFormField(
                        focusNode: _focusPassword,
                        obscureText: !utilStore.seePassword,
                        controller: _controllerLoginPassword,
                        style: const TextStyle(color: Constants.color1),
                        decoration: const InputDecoration(
                          labelText: 'Senha',
                          labelStyle: TextStyle(color: Constants.color1),
                          border: InputBorder.none,
                        ),
                      );
                    }),
                    IconButton(
                      onPressed: () {
                        utilStore.setSeePassword(!utilStore.seePassword);
                      },
                      icon: Observer(builder: (_) {
                        return Icon(
                          utilStore.seePassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Constants.color1,
                        );
                      }),
                    ),
                  ],
                ),
              ),
              SizedBox(height: .03.sh),
              SizedBox(
                width: 1.sw / 1.7,
                height: 50.sp,
                child: Center(
                  child: TextButton(
                    onPressed: () async {
                      QR.to("main");
                      bool? validate = _formKey.currentState?.validate();
                      if (validate != true) {
                        return;
                      }
                      String message =
                          "Ocorreu um erro. Tente novamente mais tarde!";
                      // EasyLoading.dismiss();
                      Notifications.error(
                        title: "Atenção",
                        message: message,
                      );
                    },
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [
                          Constants.color7,
                          Constants.color7,
                        ]),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.sp),
                        ),
                      ),
                      child: Container(
                        constraints: const BoxConstraints(
                          minWidth: 200,
                          minHeight: 30,
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'ENTRAR',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Constants.color2,
                            fontSize: 21,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  // QR.to('/acolhimento');
                  utilStore.setformLogin(false);
                },
                child: RichText(
                  text: TextSpan(
                    text: 'Não tem conta? ',
                    style: TextStyle(
                      color: Constants.color1,
                      fontSize: 16.sp,
                      fontFamily: 'Libre',
                    ),
                    children: [
                      TextSpan(
                        text: 'Cadastre-se',
                        style: TextStyle(
                          color: Constants.color1,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
