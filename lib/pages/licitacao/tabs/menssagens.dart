// ignore_for_file: deprecated_member_use, sized_box_for_whitespace

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qlevar_router/qlevar_router.dart';
import '../../../utils/constants.dart';
import 'package:get_it/get_it.dart';
import '../../../store/utils.dart';
import '../../../utils/trianglePainter.dart';

final utilStore = GetIt.I.get<Utils>();

class Mensagens extends StatefulWidget {
  const Mensagens({super.key});

  @override
  State<Mensagens> createState() => _MensagensState();
}

class _MensagensState extends State<Mensagens> {
  final FocusNode _focusPesquisar = FocusNode();
  final _pesquisarkey = GlobalKey<FormFieldState>();
  final TextEditingController _controllerPesquisar =
      TextEditingController(text: "");
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.sh - 125.sp,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Observer(builder: (_) {
            if (utilStore.mensagem == null) {
              return Container();
            }
            return _sectionMensagem();
          }),
          Observer(builder: (_) {
            if (utilStore.mensagem != null) {
              return Container();
            }
            return Container(
              height: 1.sh - 125.sp,
              color: Constants.color1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 1.sw,
                    padding: EdgeInsets.only(top: 15.sp),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(5.sp),
                              child: Icon(
                                FontAwesomeIcons.infoCircle,
                                color: Colors.grey,
                                size: 10.sp,
                              ),
                            ),
                            Text(
                              'Nenhuma mensagem encontrada',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 10.sp,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: 1.sw,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10.sp,
                                    ),
                                    children: const [
                                      TextSpan(
                                        text: 'Adicione esta licitação ao ',
                                      ),
                                      TextSpan(
                                        text: 'elicitaRadar',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' e acompanhe todas as mensagens',
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
          })
        ],
      ),
    );
  }

  _sectionMensagem() {
    if (utilStore.loading == true) {
      return _carregando();
    }

    return Container(
      height: 1.sh - 130.sp,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                color: Colors.grey[50],
                height: 50.sp,
                padding:
                    EdgeInsets.symmetric(horizontal: 13.sp, vertical: 2.sp),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 1.sw - 75.sp,
                      margin: EdgeInsets.only(
                        bottom: 3.sp,
                        top: 3.sp,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2.sp),
                        borderRadius: BorderRadius.circular(
                          15.0.sp,
                        ),
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
                              // setState(() {});
                              utilStore.setLoading(false);
                            },
                          ),
                        ),
                        controller: _controllerPesquisar,
                        onChanged: (value) async {},
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          height: 42.sp,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(40.0.sp),
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.check,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: 1.sh - 250.sp,
                color: Constants.color1,
                child: ListView.builder(
                  padding: EdgeInsets.only(bottom: 8.sp),
                  // shrinkWrap: true,
                  // physics: const NeverScrollableScrollPhysics(),
                  itemCount: utilStore.mensagem!.length,
                  itemBuilder: (context, index) {
                    final data = utilStore.mensagem![index];
                    Color colorIcon = Constants.color8;
                    Color colorBalao = Colors.grey.shade200;
                    Color colorTxt = Constants.color1;
                    Color colorData = Constants.color8;
                    Icon icone = const Icon(
                      Icons.gavel,
                      color: Constants.color1,
                    );

                    if (data['remetente'] == 'PREGOEIRO') {}
                    if (data['remetente'] == 'Usuario') {
                      colorData = Constants.color2;
                      colorTxt = Constants.color2;
                      colorBalao = Constants.color8;
                    }
                    if (data['remetente'] == 'FORNECEDOR') {
                      colorIcon = Colors.grey;
                      icone = const Icon(
                        Icons.person,
                        color: Constants.color1,
                      );
                    }

                    return GestureDetector(
                      onTap: () {},
                      child: Center(
                        child: Container(
                          margin: EdgeInsets.all(2.sp),
                          width: 400.sp,
                          child: Row(
                            children: [
                              Observer(builder: (_) {
                                if (data['remetente'] == 'Usuario') {
                                  return Container();
                                }

                                return Container(
                                  width: 80.sp,
                                  padding: EdgeInsets.only(top: 15.sp),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 50.sp,
                                        padding: EdgeInsets.all(2.5.sp),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: colorIcon,
                                          border: Border.all(
                                            color: Constants.color1,
                                            width: 1.sp,
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 40.sp,
                                              height: 40.sp,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: colorIcon,
                                                border: Border.all(
                                                  color: Constants.color1,
                                                  width: 2.sp,
                                                ),
                                              ),
                                              child: Container(
                                                width: 70.sp,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: colorIcon,
                                                ),
                                                child: icone,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(3.sp),
                                        child: Text(
                                          data['remetente'],
                                          style: TextStyle(
                                            color: colorIcon,
                                            fontSize: 10.sp,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                              Observer(builder: (_) {
                                double tamanho = 1.sw / 1.5;
                                double left = 8.sp;
                                double angle = pi + 1;
                                if (data['remetente'] == 'Usuario') {
                                  tamanho = 1.sw / 1.2;
                                  left = 303.sp;
                                }
                                return Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Container(
                                        margin: EdgeInsets.only(left: 10.sp),
                                        width: tamanho,
                                        padding: EdgeInsets.symmetric(
                                          vertical: 10.sp,
                                          horizontal: 15.sp,
                                        ),
                                        decoration: BoxDecoration(
                                          color: colorBalao,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data['messagem'],
                                              style: TextStyle(
                                                fontSize: 11.sp,
                                                color: colorTxt,
                                              ),
                                            ),
                                            SizedBox(height: 5.sp),
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: Text(
                                                data['data'],
                                                style: TextStyle(
                                                  color: colorData,
                                                  fontSize: 12.sp,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: left,
                                      top: 20.sp,
                                      child: Transform.rotate(
                                        angle: angle,
                                        child: CustomPaint(
                                          painter: TrianglePainter(colorBalao),
                                          child: Container(
                                            width: 20.sp,
                                            height: 20.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Container(
            color: Colors.grey.shade200,
            height: 70.sp,
            padding: EdgeInsets.symmetric(horizontal: 10.sp),
            child: Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(30.sp),
                      right: Radius.circular(0.sp),
                    ),
                    child: Container(
                      color: Colors.grey[300],
                      padding: EdgeInsets.symmetric(horizontal: 10.sp),
                      child: const TextField(
                        maxLines: 2,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Digite aqui sua nova mensagem...',
                        ),
                      ),
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(0.sp),
                      right: Radius.circular(30.sp)),
                  child: Container(
                    color: Constants.color8,
                    width: 100,
                    height: 55.sp,
                    child: TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(
                            vertical: 10.sp,
                            horizontal: 15.sp,
                          ),
                        ),
                      ),
                      child: const Text(
                        'ENVIAR',
                        style: TextStyle(
                          color: Constants.color1,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
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
