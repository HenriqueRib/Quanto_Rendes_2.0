// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qlevar_router/qlevar_router.dart';

import '../../../utils/constants.dart';

class InfoGerais extends StatefulWidget {
  const InfoGerais({super.key});

  @override
  State<InfoGerais> createState() => _InfoGeraisState();
}

class _InfoGeraisState extends State<InfoGerais> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.sh - 125.sp,
      color: Constants.color1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 5.sp, horizontal: 5.sp),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 8.sp, bottom: 8.sp),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 15.sp,
                        color: Constants.color,
                      ),
                      Container(
                        width: 1.sw - 50.sp,
                        child: Text(
                          'Rod Rdt - 287 KM 240 -S/n Cx Pst 341 - Camobi - Santa Maria (RS)',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10.5.sp,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8.sp),
                  child: Row(
                    children: [
                      Icon(
                        Icons.phone,
                        size: 15.sp,
                        color: Constants.color,
                      ),
                      Container(
                        width: 1.sw - 50.sp,
                        child: Text(
                          '13 98567-0098/11 4978-5500',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10.5.sp,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.calendar_month,
                          size: 15.sp,
                          color: Constants.color,
                        ),
                        Text(
                          'Dt. Publicação:',
                          style: TextStyle(
                              color: Constants.color,
                              fontSize: 10.5.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '16/08/2019',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10.5.sp,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 150.sp,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.calendar_month,
                            size: 15.sp,
                            color: Constants.color,
                          ),
                          Text(
                            'Inicio Disputa:',
                            style: TextStyle(
                                color: Constants.color,
                                fontSize: 10.5.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '------',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 10.5.sp,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(10.sp),
                  child: Divider(
                    color: Colors.grey,
                    height: 2,
                    thickness: 1.sp,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(2.5.sp),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Empresa Aviso:',
                            style: TextStyle(
                                color: Constants.color,
                                fontSize: 10.5.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Forseti',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 10.5.sp,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 150.sp,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Número Aviso:',
                              style: TextStyle(
                                  color: Constants.color,
                                  fontSize: 10.5.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '------',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 10.5.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.sp, bottom: 8.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Objeto:',
                        style: TextStyle(
                            color: Constants.color,
                            fontSize: 10.5.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        width: 1.sw - 16.sp,
                        child: Text(
                          'Aquisição de materiais para manutenção corretiva e preventiva das UTA´s | Unidade de Tratamento de Ar, sistema de ar condicionado para controle de umidade, pressão e temperatura do ambiente laboratorial) do CTL conforme condições, quantidades e exigências estabelecidas no Edital em anexo',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10.5.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.sp, bottom: 8.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Palavras Utilizadas:',
                        style: TextStyle(
                            color: Constants.color,
                            fontSize: 10.5.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        width: 1.sw - 16.sp,
                        child: Text(
                          '---',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10.5.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.sp, bottom: 8.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Observação:',
                        style: TextStyle(
                            color: Constants.color,
                            fontSize: 10.5.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        width: 1.sw - 16.sp,
                        child: Text(
                          '---',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10.5.sp,
                          ),
                        ),
                      ),
                    ],
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
                      fontSize: 13.sp,
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
