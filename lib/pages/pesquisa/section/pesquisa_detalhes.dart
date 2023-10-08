// ignore_for_file: avoid_unnecessary_containers, avoid_print

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:quanto_rendes_2/utils/constants.dart';
import 'package:quanto_rendes_2/store/utils.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final utilStore = GetIt.I.get<Utils>();

class PesquisaDetalhes extends StatefulWidget {
  const PesquisaDetalhes({super.key});

  @override
  State<PesquisaDetalhes> createState() => _PesquisaDetalhesState();
}

class _PesquisaDetalhesState extends State<PesquisaDetalhes> {
  List<Map<String, String>> dataList = [
    {
      'id': '1',
      'title': 'CN - 102018/160301',
      'status': 'Monitorando',
      'description': 'Comissão Regional de Obras/1- RJ | Tomada de preço',
    },
    {
      'id': '2',
      'title': 'CN - 202018/160302',
      'status': 'Monitorando',
      'description': 'Comissão Regional de Obras/1- RJ | Tomada de preço',
    },
    {
      'id': '3',
      'title': 'CN - 202018/160303',
      'description': 'Comissão Regional de Obras/1- RJ | Tomada de preço',
    },
    {
      'id': '4',
      'title': 'CN - 202018/160304',
      'description': 'Comissão Regional de Obras/1- RJ | Tomada de preço',
    },
    {
      'id': '5',
      'title': 'CN - 202018/160305',
      'description': 'Comissão Regional de Obras/1- RJ | Tomada de preço',
    },
    {
      'id': '6',
      'title': 'CN - 202018/160306',
      'status': 'Monitorando',
      'description': 'Comissão Regional de Obras/1- RJ | Tomada de preço',
    },
    {
      'id': '7',
      'title': 'CN - 202018/160307',
      'status': 'Monitorando',
      'description': 'Comissão Regional de Obras/1- RJ | Tomada de preço',
    },
    {
      'id': '8',
      'title': 'CN - 202018/160308',
      'status': 'Monitorando',
      'description': 'Comissão Regional de Obras/1- RJ | Tomada de preço',
    },
  ];

  final FocusNode _focusPesquisar = FocusNode();
  final _pesquisarkey = GlobalKey<FormFieldState>();
  final TextEditingController _controllerPesquisar =
      TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: .02.sw,
            vertical: 10.sp,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 1.sw / 4.2,
                child: Text(
                  'Procurando por:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10.sp,
                  ),
                ),
              ),
              Container(
                width: 1.sw / 1.46,
                padding: EdgeInsets.symmetric(horizontal: 5.sp),
                child: Text(
                  'Compras NEY | ... | 2018',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 10.sp,
                  ),
                ),
              ),
            ],
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
              borderRadius: BorderRadius.circular(15.0.sp),
            ),
            child: TextFormField(
              key: _pesquisarkey,
              focusNode: _focusPesquisar,
              decoration: InputDecoration(
                labelStyle: const TextStyle(color: Colors.black),
                border: InputBorder.none,
                prefixIcon: IconButton(
                  icon: const Icon(
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
        SizedBox(
          height: 10.sp,
        ),
        ListView.builder(
          padding: EdgeInsets.only(bottom: 8.sp),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: dataList.length,
          itemBuilder: (context, index) {
            final data = dataList[index];
            Color color;
            Color colorBold;
            if (data['status'] == 'Monitorando') {
              color = const Color.fromARGB(23, 76, 175, 79);
              colorBold = Colors.green;
            } else {
              color = const Color.fromARGB(22, 39, 50, 39);
              colorBold = Colors.grey;
            }
            //color: const Color.fromARGB(23, 76, 175, 79),
            // Colors.green

            return GestureDetector(
              onTap: () {
                print(data['id']);
                QR.to('escolher_itens');
              },
              child: Padding(
                padding: EdgeInsets.only(bottom: 8.sp),
                child: Slidable(
                  key: Key(index.toString()),
                  startActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    // dismissible: DismissiblePane(onDismissed: (_) {}),
                    children: [
                      SlidableAction(
                        onPressed: (_) {},
                        backgroundColor: colorBold,
                        foregroundColor: Constants.color1,
                        icon: Icons.email,
                      ),
                      SlidableAction(
                        onPressed: (_) {},
                        backgroundColor: colorBold,
                        foregroundColor: Constants.color1,
                        icon: Icons.download,
                      ),
                      Observer(builder: (_) {
                        if (data['status'] != 'Monitorando') {
                          return Container();
                        }
                        return SlidableAction(
                          onPressed: (_) {},
                          backgroundColor: colorBold,
                          foregroundColor: Constants.color1,
                          icon: Icons.delete,
                        );
                      }),
                    ],
                  ),
                  // endActionPane: ActionPane(
                  //   motion: const ScrollMotion(),
                  //   // dismissible: DismissiblePane(onDismissed: (_) {}),
                  //   children: [
                  //     SlidableAction(
                  //       flex: 2,
                  //       onPressed: (_) {},
                  //       backgroundColor: const Color(0xFF7BC043),
                  //       foregroundColor: Constants.color1,
                  //       icon: Icons.archive,
                  //       label: 'Archive',
                  //     ),
                  //     SlidableAction(
                  //       onPressed: (_) {},
                  //       backgroundColor: const Color(0xFF0392CF),
                  //       foregroundColor: Constants.color1,
                  //       icon: Icons.save,
                  //       label: 'Save',
                  //     ),
                  //   ],
                  // ),
                  child: Container(
                    child: Row(
                      children: [
                        Container(
                          width: 5.sp,
                          height: 70.sp,
                          color: colorBold,
                        ),
                        Container(
                          width: 1.sw - 20.sp,
                          height: 70.sp,
                          color: color,
                          padding: EdgeInsets.all(7.sp),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    data['title']!,
                                    style: TextStyle(
                                      color: colorBold,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Observer(builder: (_) {
                                    if (data['status'] != 'Monitorando') {
                                      return Container();
                                    }
                                    return Text(
                                      data['status']!,
                                      style: TextStyle(
                                        color: colorBold,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 9.sp,
                                      ),
                                    );
                                  }),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    data['description']!,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5.sp,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(right: 5.sp),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_month,
                                          color: colorBold,
                                          size: 18.sp,
                                        ),
                                        Text(
                                          data['data_init'] ?? '16/08/2023',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(right: 5.sp),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_month,
                                          color: colorBold,
                                          size: 18.sp,
                                        ),
                                        Text(
                                          data['data_end'] ?? '----',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(right: 5.sp),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.list,
                                          color: colorBold,
                                          size: 18.sp,
                                        ),
                                        Text(
                                          data['itens'] ?? '01 itens',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(right: 5.sp),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.sim_card_download,
                                          color: colorBold,
                                          size: 18.sp,
                                        ),
                                        Text(
                                          data['data_init'] ?? '42 anexos',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(right: 5.sp),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.email,
                                          color: colorBold,
                                          size: 18.sp,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
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
