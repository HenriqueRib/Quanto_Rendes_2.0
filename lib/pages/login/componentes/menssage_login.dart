import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quanto_rendes_2/utils/constants.dart';
import 'package:quanto_rendes_2/store/utils.dart';
import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:qlevar_router/qlevar_router.dart';

final List<Map> _info = <Map>[
  {
    'id': '1',
    'titulo': 'Avisos recebidos em Tempo Real',
    'descricao': 'Tenha sues gastos monitoradas na palma da mão.',
  },
  {
    'id': '2',
    'titulo': 'Atualize-se',
    'descricao':
        'Registre todos seus abastecimentos e verifique em um só lugar.',
  },
  {
    'id': '3',
    'titulo': 'Não perca tempo!',
    'descricao': 'Aonde quer que você esteja registre seus gastos',
  },
  {
    'id': '4',
    'titulo': 'Sem internet?',
    'descricao':
        'Isso não é um problema. Seu aplicativo de gerenciamento de combustivel funciona mesmo sem internet',
  },
];

final utilStore = GetIt.I.get<Utils>();

class MessageLogin extends StatefulWidget {
  const MessageLogin({super.key});

  @override
  State<MessageLogin> createState() => _MessageLoginState();
}

class _MessageLoginState extends State<MessageLogin> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Observer(
          builder: (_) {
            if (QR.navigator.currentRoute.name == 'acolhimento') {
              return Container();
            }
            return Container(
              color: Colors.black.withOpacity(0.5),
              height: 75.sp,
              width: 1.sw,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    _info[utilStore.indexPageLogin]['titulo'],
                    style: TextStyle(
                        color: Constants.color1,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    _info[utilStore.indexPageLogin]['descricao'],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Constants.color1,
                      fontSize: 13.sp,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        SizedBox(
          height: 25.sp,
        ),
        Observer(
          builder: (_) {
            if (QR.navigator.currentRoute.name == 'acolhimento') {
              return Container();
            }
            return SizedBox(
              width: 1.sw / 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 20.sp,
                    height: 5.sp,
                    decoration: BoxDecoration(
                      color: utilStore.indexPageLogin == 0
                          ? Constants.color1
                          : Constants.color1.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(30.sp),
                    ),
                  ),
                  Container(
                    width: 20.sp,
                    height: 5.sp,
                    decoration: BoxDecoration(
                      color: utilStore.indexPageLogin == 1
                          ? Constants.color1
                          : Constants.color1.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(30.sp),
                    ),
                  ),
                  Container(
                    width: 20.sp,
                    height: 5.sp,
                    decoration: BoxDecoration(
                      color: utilStore.indexPageLogin == 2
                          ? Constants.color1
                          : Constants.color1.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(30.sp),
                    ),
                  ),
                  Container(
                    width: 20.sp,
                    height: 5.sp,
                    decoration: BoxDecoration(
                      color: utilStore.indexPageLogin == 3
                          ? Constants.color1
                          : Constants.color1.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(30.sp),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        SizedBox(
          height: 25.sp,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: .0),
          child: Text(
            Constants.versionApp,
            style: TextStyle(
              color: Constants.color1,
            ),
          ),
        ),
        SizedBox(
          height: 5.sp,
        ),
        Container(
          width: 1.sw / 3,
          height: 2.sp,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(510.sp),
            color: Constants.color2,
          ),
        ),
      ],
    );
  }
}
