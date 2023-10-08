import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teste_projeto_47/pages/acolhimento/login_view.dart';
import 'package:teste_projeto_47/utils/constants.dart';

class LogoLogin extends StatelessWidget {
  const LogoLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Observer(builder: (_) {
          //   return utilStore.formLogin != true
          //       ? SizedBox(height: .01.sh)
          //       : SizedBox(height: .05.sh);
          // }),
          SizedBox(height: .05.sh),
          Padding(
            padding: EdgeInsets.only(bottom: .02.sw),
            child: Image.asset(
              'assets/img/logo.png',
              height: .05.sh,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 15.sp),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Gerencie seu gastos com combustivel em poucos cliques',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Constants.color1,
                    fontSize: 13.sp,
                  ),
                ),
              ],
            ),
          ),
          Observer(builder: (_) {
            return utilStore.formLogin != true
                ? SizedBox(height: .05.sh)
                : SizedBox(height: .1.sh);
          }),
        ],
      ),
    );
  }
}
