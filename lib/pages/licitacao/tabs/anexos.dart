// ignore_for_file: avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qlevar_router/qlevar_router.dart';

import '../../../utils/constants.dart';

class Anexos extends StatefulWidget {
  const Anexos({super.key});

  @override
  State<Anexos> createState() => _AnexosState();
}

class _AnexosState extends State<Anexos> {
  final List<Map<String, dynamic>> anexos = [
    {
      "id": 1,
      "nome": "Anexo 1",
      "nome_arquivo": "Relacaoitend24012905000102018000.pdf",
    },
    {
      "id": 2,
      "nome": "Anexo 2",
      "nome_arquivo": "SEI_01241_000974_2018_61_Filtros.pdf",
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
                      '2 anexos encontradaos',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  height: 1.sh - 1.sh / 3,
                  child: ListView.builder(
                    itemCount: anexos.length,
                    padding: EdgeInsets.only(bottom: 8.sp),
                    // shrinkWrap: true,
                    // physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        color: const Color.fromARGB(51, 31, 53, 81),
                        margin: EdgeInsets.only(bottom: 8.sp),
                        child: ListTile(
                          title: Text(
                            anexos[index]['id'].toString(),
                            style: TextStyle(
                              color: Constants.color,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            anexos[index]['nome_arquivo'],
                            style: TextStyle(
                              color: Constants.color,
                              fontSize: 12.sp,
                            ),
                          ),
                          trailing: Icon(
                            Icons.cloud_download,
                            size: 18.sp,
                            color: Constants.color,
                          ),
                          onTap: () {},
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                SizedBox(
                  height: 40.sp,
                  child: Center(
                    child: Container(
                      width: 1.sw / 1.8,
                      margin: EdgeInsets.only(bottom: 15.sp),
                      child: OutlinedButton(
                        onPressed: () async {
                          await Future.delayed(
                            const Duration(seconds: 2),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey.shade300),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0.sp),
                            ),
                          ),
                        ),
                        child: Text(
                          'BAIXAR TODOS OS ANEXOS',
                          style: TextStyle(
                            color: Constants.color,
                            fontSize: 10.sp,
                          ),
                        ),
                      ),
                    ),
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
