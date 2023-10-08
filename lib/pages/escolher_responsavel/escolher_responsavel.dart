// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, deprecated_member_use, library_private_types_in_public_api, sort_child_properties_last, prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'dart:async';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teste_projeto_47/utils/constants.dart';
import 'package:teste_projeto_47/store/utils.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:qlevar_router/qlevar_router.dart';

final utilStore = GetIt.I.get<Utils>();

class EscolherResponsavel extends KFDrawerContent {
  EscolherResponsavel({Key? key});

  @override
  _EscolherResponsavelState createState() => _EscolherResponsavelState();
}

class _EscolherResponsavelState extends State<EscolherResponsavel> {
  bool campoHabilitarBool = true;
  bool isChecked = false;
  final FocusNode _focusPesquisar = FocusNode();
  final _pesquisarkey = GlobalKey<FormFieldState>();
  final TextEditingController _controllerPesquisar =
      TextEditingController(text: "");

  final List<Map<String, dynamic>> responsavel = [
    {
      "nome": "LETÍCIA GARRIDO",
      "email": "leticia@forseti.com.br",
      "isSelected": false,
    },
    {
      "nome": "ANTÔNIO MILAT",
      "email": "antonio.milat@forseti.com.br",
      "isSelected": false,
    },
    {
      "nome": "BRUNO CARDOSO",
      "email": "bruno.cardoso@forseti.com.br",
      "isSelected": false,
    },
  ];

  @override
  void initState() {
    super.initState();
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
                decoration: const BoxDecoration(
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
                      //Header
                      Container(
                        height: 40.sp,
                        color: Constants.color,
                        padding: EdgeInsets.symmetric(horizontal: .02.sw),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              width: 5.sp,
                              height: 50.sp,
                            ),
                            SizedBox(
                              height: 60.sp,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 40.sp,
                                    padding: EdgeInsets.only(right: 10.sp),
                                    child: ClipRRect(
                                      child: IconButton(
                                        padding: EdgeInsets.only(bottom: 5),
                                        icon: FaIcon(
                                          FontAwesomeIcons
                                              .solidArrowAltCircleLeft,
                                          color: Constants.color1,
                                          size: 16.sp,
                                        ),
                                        onPressed: () {
                                          QR.back();
                                        },
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 20.sp,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ClipRRect(
                                              child: IconButton(
                                                padding:
                                                    EdgeInsets.only(bottom: 5),
                                                icon: Icon(
                                                  Icons.person,
                                                  color: Constants.color1,
                                                  size: 22.sp,
                                                ),
                                                onPressed: () {},
                                              ),
                                            ),
                                            Text(
                                              "ESCOLHER RESPONSÁVEL",
                                              style: TextStyle(
                                                height: 1,
                                                fontSize: 18.sp,
                                                color: Constants.color1,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        "Escolha o responsável por esse monitoramento",
                                        style: TextStyle(
                                          height: 1,
                                          fontSize: 8.sp,
                                          color: Constants.color1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 5.sp,
                              height: 50,
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
                              padding: EdgeInsets.symmetric(horizontal: .01.sw),
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: .02.sw,
                                    vertical: 10.sp,
                                  ),
                                  child: SizedBox(
                                    width: 1.sw,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 1.sw / 2 - 93.sp,
                                          child: Text(
                                            '102018 | 160301',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10.sp,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5.sp),
                                          child: Text(
                                            ' - ',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 10.sp,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 1.sw / 2 + 30.sp,
                                          child: Text(
                                            'COMISSÃO REGIONAL DE OBRAS /1 RJ/',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 10.sp,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Observer(builder: (_) {
                                  if (utilStore.loading == true) {
                                    return _carregando();
                                  }
                                  return Container(
                                    width: 1.sw - 20.sp,
                                    height: 38.sp,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.2.sp),
                                      borderRadius:
                                          BorderRadius.circular(15.0.sp),
                                    ),
                                    child: TextFormField(
                                      key: _pesquisarkey,
                                      focusNode: _focusPesquisar,
                                      decoration: InputDecoration(
                                        labelStyle:
                                            TextStyle(color: Colors.black),
                                        border: InputBorder.none,
                                        prefixIcon: IconButton(
                                          icon: Icon(
                                            Icons.search,
                                            color: Constants.color1,
                                          ),
                                          onPressed: () async {
                                            utilStore.setLoading(true);
                                            await Future.delayed(
                                              const Duration(seconds: 2),
                                            );
                                            utilStore.setpesquisaDetalhes(true);
                                            QR.to('pesquisa');
                                            utilStore.setLoading(false);
                                          },
                                        ),
                                      ),
                                      controller: _controllerPesquisar,
                                      onChanged: (value) async {},
                                    ),
                                  );
                                }),
                                ListView.builder(
                                  itemCount: responsavel.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.only(bottom: 10.sp),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Checkbox(
                                                value: responsavel[index]
                                                    ["isSelected"],
                                                onChanged: (valeu) {
                                                  for (int i = 0;
                                                      i < responsavel.length;
                                                      i++) {
                                                    responsavel[i]
                                                        ["isSelected"] = false;
                                                  }
                                                  setState(() {
                                                    responsavel[index]
                                                        ["isSelected"] = valeu;
                                                    isChecked = valeu ?? false;
                                                  });
                                                },
                                              ),
                                              Text(
                                                responsavel[index]["nome"],
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(left: 15.sp),
                                            child: Text(
                                              responsavel[index]["email"],
                                              style: TextStyle(
                                                fontSize: 9.sp,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          QR.to('escolher_responsavel');
                        },
                        child: Container(
                          color: Constants.color8,
                          height: 40.sp,
                          child: Center(
                            child: Text(
                              'COMFIRMAR E CONTINUAR',
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: Constants.color1,
                              ),
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

  _carregando() {
    return Observer(builder: (_) {
      if (utilStore.loading == false) {
        return SizedBox(width: 50.sp, height: 50.sp);
      }
      return Center(
        child: CircularProgressIndicator(
          strokeWidth: 1.sp,
          valueColor: const AlwaysStoppedAnimation<Color>(
            Constants.color,
          ),
        ),
      );
    });
  }
}
