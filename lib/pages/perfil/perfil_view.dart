// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, deprecated_member_use, library_private_types_in_public_api, sort_child_properties_last, prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:email_validator/email_validator.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quanto/utils/constants.dart';
import 'package:quanto/utils/form_field_snippet.dart';
import 'package:qlevar_router/qlevar_router.dart';

final GlobalKey<FormState> _formUpdatePerfilKey = GlobalKey<FormState>();

final _nameKey = GlobalKey<FormFieldState>();
final _emailKey = GlobalKey<FormFieldState>();
final _phoneKey = GlobalKey<FormFieldState>();

final FocusNode _focusEmail = FocusNode();
final FocusNode _focusName = FocusNode();
final FocusNode _focusPhone = FocusNode();

final TextEditingController _controllerName = TextEditingController();
final TextEditingController _controllerEmail = TextEditingController(text: "");
final TextEditingController _controllerPhone =
    MaskedTextController(mask: '(00) 00000-0000');

class PerfilView extends KFDrawerContent {
  PerfilView({Key? key});

  @override
  _PerfilViewState createState() => _PerfilViewState();
}

class _PerfilViewState extends State<PerfilView> {
  @override
  void initState() {
    super.initState();
    _updateForm();
  }

  bool campoHabilitarBool = true;

  _updateForm() async {
    // await utilStore.getDetailsUser();
    // User u = userStore.user;
    // _controllerName.text = u.name ?? '';
    // _controllerEmail.text = u.email ?? '';
    // _controllerPhone.text = u.phone ?? '';
  }

  final TextStyle style = const TextStyle(
    fontWeight: FontWeight.bold,
    fontFamily: 'Roboto',
    color: Colors.white,
  );

  _showApagarConta() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Sua conta será excluída.\n\n Tem certeza que deseja executar essa ação?',
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: .02.sh),
                  child: ButtonTheme(
                    minWidth: 100.0,
                    height: 40,
                    child: TextButton(
                      child: const Text(
                        'Não',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Constants.color6,
                          fontSize: 21,
                        ),
                      ),
                      onPressed: () async {
                        EasyLoading.show(status: 'Carregando...');
                        // await utilStore.contatoDeleteUser();
                        EasyLoading.dismiss();
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                TextButton(
                  child: const Text(
                    'Sim',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Constants.color3,
                      fontSize: 21,
                    ),
                  ),
                  onPressed: () async {
                    EasyLoading.show(status: 'Carregando...');
                    // await utilStore.contatoDeleteUser();
                    EasyLoading.dismiss();
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return SafeArea(
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
            child: RefreshIndicator(
              onRefresh: () async {
                await EasyLoading.dismiss();
                return Future.delayed(const Duration(seconds: 1));
              },
              child: Column(
                children: <Widget>[
                  //Header
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: .04.sw),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: 40.sp,
                          // color: Colors.black,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: .0.sw, left: 0),
                            child: ClipRRect(
                              child: IconButton(
                                icon: FaIcon(
                                  FontAwesomeIcons.bars,
                                  color: Constants.color5,
                                  size: 25.sp,
                                ),
                                onPressed: widget.onMenuPressed,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          // color: Colors.black,
                          width: 80.sp,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: .0.sw),
                            child: Image.asset(
                              'assets/img/logo.png',
                              height: .13.sh,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      width: 1.sw,
                      height: 1.sh,
                      child: Form(
                        key: formKey,
                        child: ListView(
                          padding: EdgeInsets.symmetric(horizontal: .04.sw),
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SizedBox(height: 0),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 15,
                                bottom: 15,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Perfil',
                                    style: TextStyle(
                                      height: 1,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Observer(builder: (_) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: Form(
                                  key: _formUpdatePerfilKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      FormFieldSnippet(
                                        textInputAction: TextInputAction.go,
                                        labelText: 'E-mail',
                                        labelStyle: style,
                                        focus: _focusEmail,
                                        enabled: false,
                                        style: style,
                                        hintStyle: TextStyle(
                                          fontSize: 16.sp,
                                        ),
                                        controller: _controllerEmail,
                                        fieldKey: _emailKey,
                                        onChanged: (value) async {
                                          _emailKey.currentState?.validate();
                                        },
                                        onFieldSubmitted: (value) {},
                                        validator: (v) {
                                          bool? validEmail =
                                              EmailValidator.validate(
                                                  "$v".replaceAll(' ', ''));
                                          if (!validEmail) {
                                            return "Não parece um E-mail, válidos.";
                                          }
                                          return null;
                                        },
                                      ),
                                      FormFieldSnippet(
                                        fieldKey: _nameKey,
                                        labelStyle: style,
                                        style: style,
                                        textInputAction: TextInputAction.go,
                                        focus: _focusName,
                                        // enabled: _registerStore.campoHabilitarBool,
                                        labelText: 'Nome Completo',
                                        controller: _controllerName,
                                        // validator: _registerStore.validation.name,
                                        hintStyle: TextStyle(
                                          fontSize: 16.sp,
                                        ),
                                        onChanged: (value) async {
                                          // userStore.upname(value);
                                          _nameKey.currentState?.validate();
                                        },
                                        onFieldSubmitted: (_) {},
                                      ),
                                      FormFieldSnippet(
                                        textInputAction: TextInputAction.go,
                                        labelText: 'Celular',
                                        labelStyle: style,
                                        focus: _focusPhone,
                                        style: style,
                                        hintStyle: TextStyle(
                                          fontSize: 16.sp,
                                        ),
                                        controller: _controllerPhone,
                                        fieldKey: _phoneKey,
                                        onChanged: (value) async {
                                          _phoneKey.currentState?.validate();
                                        },
                                        onFieldSubmitted: (value) {},
                                        // validator: _registerStore.validation.name,
                                      ),
                                      Container(height: 30),
                                      Observer(builder: (_) {
                                        return TextButton(
                                          onPressed: () async {
                                            EasyLoading.show(
                                                status:
                                                    'Verificando informações...');
                                            bool? validate =
                                                _formUpdatePerfilKey
                                                    .currentState
                                                    ?.validate();

                                            if (validate != true) {
                                              EasyLoading.dismiss();
                                              return;
                                            }
                                            EasyLoading.dismiss();
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
                                                minWidth: 350,
                                                minHeight: 40,
                                              ),
                                              alignment: Alignment.center,
                                              child: const Text(
                                                'Salvar',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Constants.color1,
                                                  fontSize: 21,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                      Container(height: 20),
                                      TextButton(
                                        onPressed: () async {
                                          QR.to('alterar_senha');
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
                                              minWidth: 350,
                                              minHeight: 40,
                                            ),
                                            alignment: Alignment.center,
                                            child: const Text(
                                              'Alterar Senha',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Constants.color1,
                                                fontSize: 21,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          _showApagarConta();
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
                                              minWidth: 350,
                                              minHeight: 40,
                                            ),
                                            alignment: Alignment.center,
                                            child: const Text(
                                              'Apagar conta',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 21,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(height: 10),
                                      SizedBox(
                                        height: 20.sp,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                            SizedBox(
                              height: 20.sp,
                            ),
                            SizedBox(
                              height: 70.sp,
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
    );
  }
}
