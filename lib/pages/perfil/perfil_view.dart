// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, deprecated_member_use, library_private_types_in_public_api, sort_child_properties_last, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teste_projeto_47/utils/constants.dart';
import 'package:teste_projeto_47/utils/form_field_snippet.dart';

class PerfilView extends KFDrawerContent {
  PerfilView({Key? key});

  @override
  _PerfilViewState createState() => _PerfilViewState();
}

class _PerfilViewState extends State<PerfilView> {
  @override
  void initState() {
    super.initState();
  }

  bool _isChecked = false;
  final TextEditingController _controllerLoginEmail =
      TextEditingController(text: "");
  final _emailkey = GlobalKey<FormFieldState>();
  bool campoHabilitarBool = true;

  final TextStyle style = const TextStyle(
    fontWeight: FontWeight.bold,
    fontFamily: 'Roboto',
    color: Constants.color1,
  );

  _showApagarConta() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          content: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
              color: Constants.color,
            ),
            padding: EdgeInsets.only(
              top: 0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 10, bottom: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 25,
                        child: FaIcon(
                          FontAwesomeIcons.lock,
                          color: Constants.color1,
                          size: 15,
                        ),
                      ),
                      Text(
                        'Alterar Senha',
                        style: TextStyle(
                          color: Constants.color1,
                          fontSize: 18.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  padding: EdgeInsets.all(20),
                  color: Constants.color1,
                  child: FormFieldSnippet(
                    brightnessdark: true,
                    textInputType: TextInputType.emailAddress,
                    labelText: 'Nova Senha:',
                    labelStyle: const TextStyle(
                      color: Constants.color,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                    ),
                    style: const TextStyle(
                      color: Constants.color,
                    ),
                    controller: _controllerLoginEmail,
                    fieldKey: _emailkey,
                    validator: (v) {
                      return null;
                    },
                    onChanged: (value) async {
                      // _emailkey.currentState?.validate();
                    },
                    child: Container(),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    ),
                    color: Constants.color2,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () async {
                          EasyLoading.show(status: 'Carregando...');
                          // await utilStore.contatoDeleteUser();
                          EasyLoading.dismiss();
                          Navigator.pop(context);
                        },
                        child: Ink(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Colors.red,
                              Colors.red,
                            ]),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Container(
                            constraints: const BoxConstraints(
                              minWidth: 100,
                              minHeight: 40,
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              'Voltar',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Constants.color1,
                                fontSize: 21,
                              ),
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          EasyLoading.show(status: 'Carregando...');
                          // await utilStore.contatoDeleteUser();
                          EasyLoading.dismiss();
                          Navigator.pop(context);
                        },
                        child: Ink(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Colors.grey,
                              Colors.grey,
                            ]),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Container(
                            constraints: const BoxConstraints(
                              minWidth: 100,
                              minHeight: 40,
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              'Salvar',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Constants.color,
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
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: Constants.color,
      body: SizedBox(
        height: 1.sh,
        width: 1.sw,
        child: SafeArea(
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/img/bg5.png'),
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
                child: RefreshIndicator(
                  onRefresh: () async {
                    await EasyLoading.dismiss();
                    return Future.delayed(const Duration(seconds: 1));
                  },
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: SizedBox(
                          width: 1.sw,
                          height: 1.sh,
                          child: Form(
                            key: formKey,
                            child: ListView(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      height: 250.sp,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image:
                                              AssetImage('assets/img/bg27.png'),
                                          fit: BoxFit.cover,
                                          colorFilter: ColorFilter.mode(
                                            Colors.black.withOpacity(0.5),
                                            BlendMode.darken,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 1,
                                      height: 1,
                                      color: Colors.transparent,
                                    ),
                                    Positioned(
                                      width: 1.sw,
                                      top: 10.sp,
                                      child: SizedBox(
                                        width: 1.sw,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "INOVATEC LTDA - 37.206.216/0001-35",
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                                color: Constants.color1),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      width: 1.sw,
                                      top: 45.sp,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          ClipOval(
                                            child: Container(
                                              height: 90.sp,
                                              width: 90.sp,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                    'assets/img/bg19.png',
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      width: 1.sw,
                                      top: 135.sp,
                                      child: SizedBox(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "LUCIANA DE CASTRO",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Constants.color1),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      width: 1.sw,
                                      top: 180,
                                      child: SizedBox(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "lucuianacastro@inovatec.com.br",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Constants.color1),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      width: 1.sw,
                                      top: 200,
                                      child: SizedBox(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "Operador",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Constants.color1),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      width: 1.sw,
                                      top: 240,
                                      child: GestureDetector(
                                        onTap: () async {
                                          _showApagarConta();
                                        },
                                        child: SizedBox(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: 25,
                                                  child: FaIcon(
                                                    FontAwesomeIcons.lock,
                                                    color: Constants.color1,
                                                    size: 15,
                                                  ),
                                                ),
                                                Text(
                                                  "Alterar Senha",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Constants.color1),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: .03.sw),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 50,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text("Receber Notificações"),
                                            Switch(
                                              activeColor: Constants.color,
                                              activeTrackColor: Colors.grey,
                                              inactiveTrackColor: Colors.grey,
                                              materialTapTargetSize:
                                                  MaterialTapTargetSize.padded,
                                              dragStartBehavior:
                                                  DragStartBehavior.start,
                                              focusColor: Colors.blue,
                                              hoverColor: Colors.yellow,
                                              value: _isChecked,
                                              onChanged: (bool newValue) {
                                                setState(() {
                                                  _isChecked = newValue;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.grey,
                                        height: 1,
                                        thickness: 1,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                        height: 70.sp,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
