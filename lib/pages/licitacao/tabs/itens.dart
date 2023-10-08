// ignore_for_file: sized_box_for_whitespace, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qlevar_router/qlevar_router.dart';

import '../../../utils/constants.dart';

class Itens extends StatefulWidget {
  const Itens({super.key});

  @override
  State<Itens> createState() => _ItensState();
}

class _ItensState extends State<Itens> {
  final List<Map<String, dynamic>> itens = [
    {
      "id": 1,
      "nome": "BANDEIROLA",
      "descricao":
          "Bandeirola de sinalização, fabricado em tecido flurescente, na cor laranja com lima limão , com 50 cm de altura x 60 cm de comprimento, resistente a intermpéries(sol e chuva). Comcabo de madeira de 80cmde comprimento. Peso 150 gramas. Utilizado para advertência em rodovias e vias urbanas.",
      "qtd": "Qtd: 328,00",
      "decreto": "Decreto 7174",
      "opcao": "Trat. Diferenciado",
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
    {
      "id": 5,
      "nome": "CONE SINALIZAÇÃO",
      "qtd": "Qtd: 300,00",
      "descricao":
          "Cone de sinalização fabricado em polietileno semi-flexível, com proteção contra raios UV, resistente a intempéries (sol e chuva), com 75 cm de altura, com 2 ou 3 fitas adesivas refletivas, com rebaixo individual para proteção das mesmas. Com orifício para encaixe de Pisca de advertência externo (sinalizador noturno) epassagem de correntes e fitas.",
      "lote": "Lote 01",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.sh - 125.sp,
      color: Constants.color1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.sp, horizontal: 5.sp),
                  child: Center(
                    child: Text(
                      '5 itens encontradaos',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  height: 1.sh - 1.sh / 3.8,
                  child: ListView.builder(
                    itemCount: itens.length,
                    padding: EdgeInsets.only(bottom: 8.sp),
                    // shrinkWrap: true,
                    // physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        color: const Color.fromARGB(5, 31, 53, 81),
                        margin: EdgeInsets.only(bottom: 8.sp),
                        child: Column(
                          children: [
                            Container(
                              width: 1.sw - 10.sp,
                              child: Text(
                                itens[index]['nome'].toString(),
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Constants.color,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              width: 1.sw - 10.sp,
                              child: Row(
                                children: [
                                  Container(
                                    width: 1.sw / 1.21 - 10.sp,
                                    child: Text(
                                      itens[index]['qtd'].toString(),
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 1.sw / 5 - 10.sp,
                                    child: Text(
                                      itens[index]['lote'] ?? ' ',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 1.sw - 10.sp,
                              height: 20.sp,
                            ),
                            Container(
                              width: 1.sw - 10.sp,
                              child: Text(
                                itens[index]['descricao'].toString(),
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              width: 1.sw - 10.sp,
                              height: 10.sp,
                            ),
                            Container(
                              width: 1.sw - 10.sp,
                              child: Row(
                                children: [
                                  Observer(builder: (_) {
                                    if (itens[index]['decreto'] == null) {
                                      return Container();
                                    }
                                    return Container(
                                      color: Constants.color,
                                      padding: EdgeInsets.all(3.sp),
                                      margin: EdgeInsets.only(right: 5.sp),
                                      child: Text(
                                        itens[index]['decreto'] ?? ' ',
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: Constants.color1,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    );
                                  }),
                                  Observer(builder: (_) {
                                    if (itens[index]['opcao'] == null) {
                                      return Container();
                                    }
                                    return Container(
                                      color: Constants.color,
                                      padding: EdgeInsets.all(3.sp),
                                      width: 1.sw / 3.5,
                                      child: Center(
                                        child: Text(
                                          itens[index]['opcao'] ?? ' ',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            color: Constants.color1,
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            ),
                            Container(
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
          GestureDetector(
            onTap: () {
              QR.to('adicionar_radar');
            },
            child: Container(
              color: Constants.color8,
              height: 40.sp,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_box_rounded,
                    color: Constants.color1,
                    size: 15.sp,
                  ),
                  Text(
                    'ADICIONAR AO RADAR',
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
    );
  }
}
