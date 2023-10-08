// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quanto_rendes_2/utils/constants.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter/material.dart';

class Creditos extends StatelessWidget {
  const Creditos({super.key});

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      var tamanho;
      if (QR.navigator.currentRoute.name == 'escolher_itens') {
        tamanho = 35.sp;
      } else {
        tamanho = 75.sp;
      }
      return Column(
        children: [
          Stack(
            children: [
              SizedBox(
                // color: Colors.amber,
                height: tamanho,
                width: double.infinity,
              ),
              Positioned(
                width: 1.sw,
                child: const SizedBox(
                  child: Padding(
                    padding: EdgeInsets.all(.0),
                    child: Text(
                      "_____",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Observer(builder: (_) {
                double top = 2.sp;
                String? textIntCredito = "10%";
                if (QR.navigator.currentRoute.name == 'escolher_itens') {
                  top = 6.sp;
                  textIntCredito = "10";
                }

                return Positioned(
                  width: 1.sw,
                  left: 40.sp,
                  top: top,
                  child: SizedBox(
                    child: Padding(
                      padding: EdgeInsets.all(.0.sp),
                      child: Text(
                        textIntCredito,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                );
              }),
              Observer(builder: (_) {
                String? textCredito = 'Créditos utilizados';
                double top = 2.sp;
                double left = 70.sp;

                if (QR.navigator.currentRoute.name == 'escolher_itens') {
                  textCredito = 'ITENS';
                  top = 6.sp;
                  left = 60.sp;
                }
                return Positioned(
                  width: 1.sw,
                  left: left,
                  top: top,
                  child: SizedBox(
                    child: Padding(
                      padding: EdgeInsets.all(.0.sp),
                      child: Text(
                        textCredito,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              }),
              Observer(builder: (_) {
                if (QR.navigator.currentRoute.name == 'escolher_itens') {
                  return Container();
                }
                return Positioned(
                  width: 1.sw,
                  left: 40.sp,
                  top: 13.4.sp,
                  child: SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.all(.0),
                      child: Text(
                        "1 licitação monitorada de 10",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 8.5.sp,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
          Observer(builder: (_) {
            if (QR.navigator.currentRoute.name != 'escolher_itens') {
              return Container();
            }
            return GestureDetector(
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
            );
          })
        ],
      );
    });
  }
}
