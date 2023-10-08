// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, deprecated_member_use, library_private_types_in_public_api, sort_child_properties_last, prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'dart:async';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:quanto_rendes_2/pages/pesquisa/section/pesquisa_detalhes.dart';
import 'package:quanto_rendes_2/pages/pesquisa/section/pesquisar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:quanto_rendes_2/utils/constants.dart';
import 'package:quanto_rendes_2/store/utils.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:quanto_rendes_2/widget/creditos.dart';

final utilStore = GetIt.I.get<Utils>();

class PesquisaView extends KFDrawerContent {
  PesquisaView({Key? key});

  @override
  _PesquisaViewState createState() => _PesquisaViewState();
}

class _PesquisaViewState extends State<PesquisaView> {
  bool campoHabilitarBool = true;

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
                                  Observer(builder: (_) {
                                    if (utilStore.pesquisaDetalhes == false) {
                                      return SizedBox(
                                        width: 40.sp,
                                      );
                                    }
                                    return Container(
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
                                            utilStore
                                                .setpesquisaDetalhes(false);
                                          },
                                        ),
                                      ),
                                    );
                                  }),
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
                                                  FontAwesomeIcons.search,
                                                  color: Constants.color1,
                                                  size: 16.sp,
                                                ),
                                                onPressed: () {},
                                              ),
                                            ),
                                            Text(
                                              "BUSCA DE LICITAÇÕES",
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
                                        "Busque licitações de acordo com o portal escolhiodo",
                                        style: TextStyle(
                                          height: 1,
                                          fontSize: 10.sp,
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
                      Expanded(
                        child: SizedBox(
                          width: 1.sw,
                          height: 1.sh,
                          child: Form(
                            key: formKey,
                            child: ListView(
                              padding: EdgeInsets.symmetric(horizontal: .01.sw),
                              children: [
                                Observer(builder: (_) {
                                  if (utilStore.pesquisaDetalhes == false) {
                                    return Pesquisar();
                                  }
                                  if (utilStore.pesquisaDetalhes == true) {
                                    return PesquisaDetalhes();
                                  }
                                  return Container();
                                }),
                                SizedBox(
                                  height: 70.sp,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Observer(builder: (_) {
                        if (utilStore.pesquisaDetalhes == true) {
                          return Creditos();
                        }
                        return Container();
                      }),
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
