// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, deprecated_member_use, library_private_types_in_public_api, sort_child_properties_last, prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'dart:async';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:quanto_rendes_2/utils/constants.dart';
import 'package:quanto_rendes_2/store/utils.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:qlevar_router/qlevar_router.dart';

final utilStore = GetIt.I.get<Utils>();

class AdicionarRadar extends KFDrawerContent {
  AdicionarRadar({Key? key});

  @override
  _AdicionarRadarState createState() => _AdicionarRadarState();
}

class _AdicionarRadarState extends State<AdicionarRadar> {
  final List<Map<String, dynamic>> itens = [
    {
      "id": 1,
      "nome": "BANDEIROLA",
      "descricao":
          "Bandeirola de sinalização, fabricado em tecido flurescente, na cor laranja com lima limão , com 50 cm de altura x 60 cm de comprimento, resistente a intermpéries(sol e chuva). Comcabo de madeira de 80cmde comprimento. Peso 150 gramas. Utilizado para advertência em rodovias e vias urbanas.",
      "qtd": "Qtd: 328,00",
      // "decreto": "Decreto 7174",
      // "opcao": "Trat. Diferenciado",
    },
    {
      "id": 2,
      "nome": "BALIZADOR",
      "qtd": "Qtd: 278,00",
      "descricao":
          "Balizador canalizador de fluxo, produxido em polietileno semi-flexivel, com proteção contra raios UV, resistente a interméries(sol e chuva). Possui refletivo adesivo, de alta visibilidade.Cor laranja com refletivo branco. Dimensão máxima de 130 x 120 x 450 mm.",
    },
    {
      "id": 3,
      "nome": "PISCA - PISCA DE SINALIZAÇÃO DE TRÂNSITO",
      "qtd": "Qtd: 338,00",
      "descricao":
          "Pisca de advertência sanfonada, fabricado em polietileno flexível de alta densidade, com proteção contra raios UV, resistente a intempéries (sol e chuva), com sistema fotocécula com 4 leds de alto brilho, alimentação através de 4 pilhas AA e acionamento através de botão liga-desliga. Base com encaixes para cones, super cones, barreiras, cavaletes e balizadores. Cúpula na cor vermelho para sinalização de emergência.",
    },
    {
      "id": 4,
      "nome": "CONE SINALIZAÇÃO",
      "qtd": "Qtd: 300,00",
      "descricao":
          "Cone de sinalização fabricado em polietileno semi-flexível, com proteção contra raios UV, resistente a intempéries (sol e chuva), com 75 cm de altura, com 2 ou 3 fitas adesivas refletivas, com rebaixo individual para proteção das mesmas. Com orifício para encaixe de Pisca de advertência externo (sinalizador noturno) epassagem de correntes e fitas.",
      "lote": "Lote 01",
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
                                                icon: FaIcon(
                                                  FontAwesomeIcons
                                                      .solidPlusSquare,
                                                  color: Constants.color1,
                                                  size: 16.sp,
                                                ),
                                                onPressed: () {},
                                              ),
                                            ),
                                            Text(
                                              "ADICIONAR AO RADAR",
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
                                        "Confirme os dados e clique em Adicionar caso esteja de acordo ",
                                        style: TextStyle(
                                          height: 1,
                                          fontSize: 8.sp,
                                          color: Constants.color1,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 40.sp,
                                  )
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
                      Stack(
                        children: [
                          Container(
                            height: 100.sp,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/img/bg17.png'),
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
                            top: 20.sp,
                            child: SizedBox(
                              child: Padding(
                                padding: EdgeInsets.all(5.sp),
                                child: Text(
                                  "Comissão Regional de Obras /  1 - RJ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Constants.color1,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            width: 1.sw,
                            top: 40.sp,
                            child: SizedBox(
                              child: Padding(
                                padding: EdgeInsets.all(5.sp),
                                child: Text(
                                  "CN - 102018/160301 - Tomada de Preço",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Constants.color1),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            width: 1.sw,
                            top: 60.sp,
                            child: SizedBox(
                              child: Padding(
                                padding: EdgeInsets.all(5.sp),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.person,
                                      color: Constants.color1,
                                      size: 16.sp,
                                    ),
                                    Text(
                                      "Bruno Cardoso",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Constants.color1,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      " - brunocardoao@forseti.com.br",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Constants.color1),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
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
                                SizedBox(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10.sp, horizontal: 5.sp),
                                        child: Center(
                                          child: Text(
                                            '4 itens encontradaos',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 11.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 1.sh - 1.sh / 3.8,
                                        child: ListView.builder(
                                          itemCount: itens.length,
                                          padding:
                                              EdgeInsets.only(bottom: 8.sp),
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return Container(
                                              color: const Color.fromARGB(
                                                5,
                                                31,
                                                53,
                                                81,
                                              ),
                                              margin:
                                                  EdgeInsets.only(bottom: 8.sp),
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    width: 1.sw - 10.sp,
                                                    child: Text(
                                                      itens[index]['nome']
                                                          .toString(),
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                        color: Constants.color,
                                                        fontSize: 13.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 1.sw - 10.sp,
                                                    child: Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 1.sw / 1.21 -
                                                              10.sp,
                                                          child: Text(
                                                            itens[index]['qtd']
                                                                .toString(),
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 11.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              1.sw / 5 - 10.sp,
                                                          child: Text(
                                                            itens[index]
                                                                    ['lote'] ??
                                                                ' ',
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 11.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 1.sw - 10.sp,
                                                    height: 20.sp,
                                                  ),
                                                  SizedBox(
                                                    width: 1.sw - 10.sp,
                                                    child: Text(
                                                      itens[index]['descricao']
                                                          .toString(),
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 11.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 1.sw - 10.sp,
                                                    height: 10.sp,
                                                  ),
                                                  SizedBox(
                                                    width: 1.sw - 10.sp,
                                                    child: Row(
                                                      children: [
                                                        Observer(builder: (_) {
                                                          if (itens[index]
                                                                  ['decreto'] ==
                                                              null) {
                                                            return Container();
                                                          }
                                                          return Container(
                                                            color:
                                                                Constants.color,
                                                            padding:
                                                                EdgeInsets.all(
                                                                    3.sp),
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right:
                                                                        5.sp),
                                                            child: Text(
                                                              itens[index][
                                                                      'decreto'] ??
                                                                  ' ',
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 10.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          );
                                                        }),
                                                        Observer(builder: (_) {
                                                          if (itens[index]
                                                                  ['opcao'] ==
                                                              null) {
                                                            return Container();
                                                          }
                                                          return Container(
                                                            color:
                                                                Constants.color,
                                                            padding:
                                                                EdgeInsets.all(
                                                                    3.sp),
                                                            width: 1.sw / 3.5,
                                                            child: Center(
                                                              child: Text(
                                                                itens[index][
                                                                        'opcao'] ??
                                                                    ' ',
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      10.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        }),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 1.sw - 10.sp,
                                                    height: 10.sp,
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5.sp,
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
                          height: 45.sp,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'COMFIRMAR E ADICIONAR',
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  color: Constants.color1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
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
