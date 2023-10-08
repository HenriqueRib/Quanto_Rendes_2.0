import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:teste_projeto_47/utils/constants.dart';
import 'package:teste_projeto_47/store/utils.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:qlevar_router/qlevar_router.dart';

final utilStore = GetIt.I.get<Utils>();
// final _formKey = GlobalKey<FormState>();
final FocusNode _focusEmail = FocusNode();
final FocusNode _focusName = FocusNode();
final FocusNode _focusCompany = FocusNode();
final FocusNode _focusPhone = FocusNode();

final TextEditingController _controllerEmail = TextEditingController(text: "");
final TextEditingController _controllerName = TextEditingController(text: "");
final TextEditingController _controllerPhone = TextEditingController(text: "");
final TextEditingController _controllerCompany =
    TextEditingController(text: "");

class FormCadastrar extends StatelessWidget {
  const FormCadastrar({super.key});

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      if (utilStore.formLogin) {
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
                  'CADASTRAR',
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
                    focusNode: _focusName,
                    style: const TextStyle(color: Constants.color1),
                    decoration: const InputDecoration(
                      labelText: 'Nome (*)',
                      labelStyle: TextStyle(color: Constants.color1),
                      border: InputBorder.none,
                    ),
                    controller: _controllerName,
                  ),
                );
              }),
              SizedBox(height: .02.sh),
              Container(
                height: 40.sp,
                padding: EdgeInsets.only(left: 10.0.sp),
                decoration: BoxDecoration(
                  color: Constants.color1.withOpacity(0.2.sp),
                  borderRadius: BorderRadius.circular(15.0.sp),
                ),
                child: TextFormField(
                  focusNode: _focusCompany,
                  style: const TextStyle(color: Constants.color1),
                  decoration: const InputDecoration(
                    labelText: 'Empresa (*)',
                    labelStyle: TextStyle(color: Constants.color1),
                    border: InputBorder.none,
                  ),
                  controller: _controllerCompany,
                ),
              ),
              SizedBox(height: .02.sh),
              Container(
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
                    labelText: 'E-mail (*)',
                    labelStyle: TextStyle(color: Constants.color1),
                    border: InputBorder.none,
                  ),
                  controller: _controllerEmail,
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
              ),
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
                child: TextFormField(
                  focusNode: _focusPhone,
                  style: const TextStyle(color: Constants.color1),
                  decoration: const InputDecoration(
                    labelText: 'Telefone (*)',
                    labelStyle: TextStyle(color: Constants.color1),
                    border: InputBorder.none,
                  ),
                  controller: _controllerPhone,
                ),
              ),
              SizedBox(height: .03.sh),
              SizedBox(
                width: 1.sw / 1.7,
                height: 50.sp,
                child: Center(
                  child: TextButton(
                    onPressed: () async {
                      QR.to('/acolhimento');
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
                          'ENVIAR',
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
                  utilStore.setformLogin(true);
                },
                child: RichText(
                  text: TextSpan(
                    text: 'Já é cadastrado? ',
                    style: TextStyle(
                      color: Constants.color1,
                      fontSize: 16.sp,
                      fontFamily: 'Libre',
                    ),
                    children: [
                      TextSpan(
                        text: 'Entrar',
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
