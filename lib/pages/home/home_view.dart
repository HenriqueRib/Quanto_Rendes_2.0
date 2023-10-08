// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, deprecated_member_use, library_private_types_in_public_api, sort_child_properties_last, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teste_projeto_47/utils/constants.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:flutter/material.dart';
import 'package:teste_projeto_47/widget/creditos.dart';

class HomeView extends KFDrawerContent {
  HomeView({Key? key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
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
                      Container(
                        height: 40.sp,
                        color: Constants.color,
                        padding: EdgeInsets.symmetric(horizontal: .02.sw),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              height: 35.sp,
                              width: 35.sp,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(40.sp),
                                ),
                                color: Color.fromARGB(55, 0, 0, 0),
                              ),
                              child: Padding(
                                padding:
                                    EdgeInsets.only(bottom: .0.sw, left: 0),
                                child: ClipRRect(
                                  child: IconButton(
                                    icon: FaIcon(
                                      FontAwesomeIcons.bars,
                                      color: Constants.color1,
                                      size: 16.sp,
                                    ),
                                    onPressed: widget.onMenuPressed,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              color: Constants.color,
                              height: 60.sp,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    child: IconButton(
                                      padding: EdgeInsets.only(bottom: 5),
                                      icon: FaIcon(
                                        FontAwesomeIcons.houseChimney,
                                        color: Constants.color1,
                                        size: 16.sp,
                                      ),
                                      onPressed: () {},
                                    ),
                                  ),
                                  Text(
                                    "DASHBOARD",
                                    style: TextStyle(
                                      height: 1,
                                      fontSize: 18.sp,
                                      color: Constants.color1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 50.sp,
                              height: 50,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          width: 1.sw,
                          height: 1.sh,
                          child: ListView(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    height: 170.sp,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image:
                                            AssetImage('assets/img/bg19.png'),
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
                                    top: 10.sp,
                                    child: SizedBox(
                                      width: 1.sw,
                                      child: Padding(
                                        padding: const EdgeInsets.all(18.0),
                                        child: Text(
                                          "Gerencie",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            color: Constants.color1,
                                            fontSize: 18.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    width: 1.sw,
                                    top: 35.sp,
                                    child: SizedBox(
                                      child: Padding(
                                        padding: const EdgeInsets.all(18.0),
                                        child: Text(
                                          "EM ALGUNS CLIQUE",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: Constants.color1,
                                              fontSize: 26.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    width: 290.sp,
                                    height: 21.sp,
                                    top: 100.sp,
                                    right: -10.sp,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Constants.color1.withOpacity(
                                          0.3.sp,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Constants.color1
                                                .withOpacity(0.2),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          top: 5.sp,
                                          bottom: 5.sp,
                                          right: 30.sp,
                                        ),
                                        child: Text(
                                          "Registre facilmente sua ida no posto de combustivel",
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                            fontSize: 9.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Constants.color1,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    width: 180.sp,
                                    top: 130.sp,
                                    right: -10.sp,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Constants.color,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Constants.color1
                                                .withOpacity(0.2),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          top: 5.sp,
                                          bottom: 5.sp,
                                          right: 30.sp,
                                        ),
                                        child: Text(
                                          "ADICIONAR CONSUMO",
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Constants.color1,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding:
                                    EdgeInsets.symmetric(horizontal: .03.sw),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                          top: 15.sp, bottom: 15.sp),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 1.sw / 3.4,
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 5.sp),
                                                  child: FaIcon(
                                                    FontAwesomeIcons.bullhorn,
                                                    color: Constants.color,
                                                  ),
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'URGENTE',
                                                      style: TextStyle(
                                                        color: Constants.color,
                                                      ),
                                                    ),
                                                    Text(
                                                      '2256 mensagens',
                                                      style: TextStyle(
                                                          fontSize: 8.sp),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 1.sw / 3.4,
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 5.sp),
                                                  child: FaIcon(
                                                    FontAwesomeIcons
                                                        .triangleExclamation,
                                                    color: Constants.color,
                                                  ),
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text('GRAVE'),
                                                    Text(
                                                      '1594 mensagens',
                                                      style: TextStyle(
                                                          fontSize: 8.sp),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 1.sw / 3.4,
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 5.sp),
                                                  child: FaIcon(
                                                    FontAwesomeIcons.circleInfo,
                                                    color: Constants.color,
                                                  ),
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text('MODERADO'),
                                                    Text(
                                                      '12 mensagens',
                                                      style: TextStyle(
                                                          fontSize: 8.sp),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                          top: 15.sp, bottom: 15.sp),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 1.sw / 3.4,
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 5.sp),
                                                  child: FaIcon(
                                                    FontAwesomeIcons
                                                        .solidClipboard,
                                                    color: Constants.color,
                                                  ),
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'AVISO',
                                                      style: TextStyle(
                                                          color:
                                                              Constants.color),
                                                    ),
                                                    Text(
                                                      '112 mensagens',
                                                      style: TextStyle(
                                                          fontSize: 8.sp),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 1.sw / 3.4,
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 5.sp),
                                                  child: FaIcon(
                                                    FontAwesomeIcons.list,
                                                    color: Constants.color,
                                                  ),
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text('ITEM'),
                                                    Text(
                                                      '608 mensagens',
                                                      style: TextStyle(
                                                          fontSize: 8.sp),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 1.sw / 3.4,
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 5.sp),
                                                  child: FaIcon(
                                                    FontAwesomeIcons
                                                        .solidMessage,
                                                    color: Constants.color,
                                                  ),
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text('OUTROS'),
                                                    Text(
                                                      '3104 mensagens',
                                                      style: TextStyle(
                                                          fontSize: 8.sp),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.sp,
                                    ),
                                    Divider(
                                      color: Colors.grey,
                                      height: 2,
                                      thickness: 1,
                                    ),
                                    SizedBox(
                                      height: 5.sp,
                                    ),
                                    //TODO:ADICIONAR LISTA DE GASTO POR MES
                                    SizedBox(
                                      height: 70.sp,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
