// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:quanto_rendes_2/pages/login/componentes/logo_login.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quanto_rendes_2/store/utils.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:quanto_rendes_2/utils/constants.dart';
import 'package:qlevar_router/qlevar_router.dart';

import '../login/componentes/menssage_login.dart';

final utilStore = GetIt.I.get<Utils>();

class AcolhimentoView extends StatefulWidget {
  const AcolhimentoView({Key? key}) : super(key: key);

  @override
  State<AcolhimentoView> createState() => _AcolhimentoViewState();
}

class _AcolhimentoViewState extends State<AcolhimentoView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 1.sh,
            width: 1.sw,
            child: Stack(
              children: [
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: const AssetImage('assets/img/_cadastro.png'),
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
                SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: .05.sw, right: .05.sw, top: .2.sw),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              LogoLogin(),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: .05.sw,
                            right: .05.sw,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'Olá, ',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.normal,
                                        color: Constants.color2,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Carolana Matos',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.sp,
                                        color: Constants.color2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20.sp),
                              RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    TextSpan(
                                      text:
                                          'Receba as notificações de todas as suas licitações monitoradas no Môdulo eLicitaRadar diretamente no seu celular com o elicitaRadar APP, ',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.normal,
                                        color: Constants.color2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 8.sp),
                              RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    TextSpan(
                                      text:
                                          'Com ele, você não perderá nenhuma convocação do pregoeiro e ainda receberá notificações a cada atualização ocorrida.',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.normal,
                                        color: Constants.color2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 8.sp),
                              RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    TextSpan(
                                      text:
                                          'Os processos são monitorados 24 horas por dia e você é avisado em tempo real, em qualquer lugar que esteja. Além disso é possivel adicionar uma licitação para monitoramento na palma de sua mão.',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.normal,
                                        color: Constants.color2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 8.sp),
                              RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    TextSpan(
                                      text:
                                          'Sej bem vindo ao elicitaRadar APP.',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.normal,
                                        color: Constants.color2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 8.sp),
                              RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'Equipe eLicitação',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.normal,
                                        color: Constants.color2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 40.sp,
                        ),
                        SizedBox(
                          height: 60.sp,
                          child: Stack(
                            children: [
                              Positioned(
                                width: 150.sp,
                                height: 40.sp,
                                top: 10.sp,
                                right: -20.sp,
                                child: GestureDetector(
                                  onTap: () {
                                    QR.to("main");
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Constants.color7,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        top: 10.sp,
                                        bottom: 5.sp,
                                        right: 30.sp,
                                      ),
                                      child: Text(
                                        "COMEÇAR",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Constants.color1,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const MessageLogin(),
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
