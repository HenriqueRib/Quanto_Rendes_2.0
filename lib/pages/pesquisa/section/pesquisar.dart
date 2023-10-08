// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:quanto_rendes_2/utils/constants.dart';
import 'package:quanto_rendes_2/store/utils.dart';
import 'package:get_it/get_it.dart';

import '../../../utils/notifications.dart';

final utilStore = GetIt.I.get<Utils>();

class Pesquisar extends StatefulWidget {
  const Pesquisar({super.key});

  @override
  State<Pesquisar> createState() => _PesquisarState();
}

class _PesquisarState extends State<Pesquisar> {
  // String? _selectedOption;

  final FocusNode _focusOrgao = FocusNode();
  final FocusNode _focusPregao = FocusNode();
  // final _portalkey = GlobalKey<FormFieldState>();
  final _orgaokey = GlobalKey<FormFieldState>();
  final _pregaokey = GlobalKey<FormFieldState>();
  // final TextEditingController _controllerPortal =
  //     TextEditingController(text: "");
  final TextEditingController _controllerOrgao =
      TextEditingController(text: "");
  final TextEditingController _controllerPregao =
      TextEditingController(text: "");
  String? _selectedOption;
  final TextStyle style = const TextStyle(
    fontWeight: FontWeight.bold,
    fontFamily: 'Roboto',
    color: Constants.color1,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: 10.sp,
            bottom: 5.sp,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 1.sw / 3 - 8.sp,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Portal:',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        height: 1,
                        fontSize: 11.sp,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      width: 1.sw / 3 - 8.sp,
                      margin: EdgeInsets.only(top: 5.sp),
                      // height: 39.sp,
                      // color: Colors.green,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          15.0.sp,
                        ),
                        border: Border.all(
                          color: Colors.grey,
                        ),
                      ),
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        value: _selectedOption,
                        isExpanded: true,
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: Colors.black,
                          // height: 2.sp,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedOption = newValue!;
                          });
                        },
                        items: <String>[
                          'Compras net',
                          'Banpará',
                          'Banco do Brasil',
                        ].map<DropdownMenuItem<String>>(
                          (String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Container(
                                padding: EdgeInsets.only(left: 10.sp),
                                child: Text(
                                  value,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            );
                          },
                        ).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 1.sw / 3 - 8.sp,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 5.sp),
                      child: Text(
                        'ORGÃO (UASG):',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          height: 1,
                          fontSize: 11.sp,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Observer(builder: (_) {
                      return Container(
                        // height: 25.sp,
                        width: 250.sp,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0.sp),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: TextFormField(
                          focusNode: _focusOrgao,
                          key: _orgaokey,
                          style: const TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                            ),
                            border: InputBorder.none,
                            // contentPadding: EdgeInsets.only(top: -20),
                          ),
                          controller: _controllerOrgao,
                          onChanged: (value) async {},
                        ),
                      );
                    }),
                  ],
                ),
              ),
              SizedBox(
                // color: Colors.amber,
                width: 1.sw / 3 - 8.sp,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 5.sp),
                      child: Text(
                        'PREGÃO',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          height: 1,
                          fontSize: 11.sp,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Observer(builder: (_) {
                      return Container(
                        // height: 25.sp,
                        width: 250.sp,
                        padding: EdgeInsets.only(left: 10.0.sp),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0.sp),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: TextFormField(
                          focusNode: _focusPregao,
                          key: _pregaokey,
                          style: const TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                            ),
                            border: InputBorder.none,
                            // contentPadding: EdgeInsets.only(top: -20),
                          ),
                          controller: _controllerPregao,
                          onChanged: (value) async {},
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
        Center(
          child: Container(
            width: 1.sw / 1.5,
            padding: EdgeInsets.only(bottom: 5.sp),
            child: OutlinedButton(
              onPressed: () async {
                utilStore.setLoading(true);

                if (_selectedOption == null &&
                    _controllerOrgao.text == '' &&
                    _controllerPregao.text == '') {
                  Notifications.warning(
                    title: "Atenção",
                    message:
                        "Nenhum parametro foi escolhido. Para pesquisar escolha um portal ou um pregao ou um orgão.",
                    duration: const Duration(seconds: 10),
                  );
                  utilStore.setLoading(false);
                } else {
                  await Future.delayed(
                    const Duration(seconds: 2),
                  );
                  utilStore.setpesquisaDetalhes(true);
                  utilStore.setLoading(false);
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                  Colors.grey.shade300,
                ),
              ),
              child: const Text(
                'BUSCAR',
                style: TextStyle(
                  color: Constants.color,
                ),
              ),
            ),
          ),
        ),
        const Divider(
          color: Colors.grey,
          height: 1,
          thickness: 1,
        ),
        SizedBox(
          height: 30.sp,
        ),
        Observer(builder: (_) {
          if (utilStore.loading == true) {
            return Container();
          }
          return Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(5.sp),
                  child: Icon(
                    FontAwesomeIcons.infoCircle,
                    color: Constants.color,
                    size: 15.sp,
                  ),
                ),
                const Text(
                  'Procure uma licitação para prosseguir',
                ),
              ],
            ),
          );
        }),
        _carregando(),
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
