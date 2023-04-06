// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, deprecated_member_use, library_private_types_in_public_api, sort_child_properties_last, prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quanto/utils/constants.dart';

class HomeView extends KFDrawerContent {
  HomeView({Key? key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return SafeArea(
      child: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/img/bg38.png'),
                // alignment: Alignment.centerRight,
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
                    padding: EdgeInsets.symmetric(horizontal: .04.sw),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: 40.sp,
                          // color: Colors.black,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: .0.sw, left: 0),
                            child: ClipRRect(
                              child: IconButton(
                                icon: FaIcon(
                                  FontAwesomeIcons.bars,
                                  color: Constants.color5,
                                  size: 25.sp,
                                ),
                                onPressed: widget.onMenuPressed,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          // color: Colors.black,
                          width: 80.sp,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: .0.sw),
                            child: Image.asset(
                              'assets/img/logo.png',
                              height: .13.sh,
                            ),
                          ),
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
                          padding: EdgeInsets.symmetric(horizontal: .04.sw),
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SizedBox(height: 0),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 15,
                                bottom: 15,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'home',
                                    style: TextStyle(
                                      height: 1,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 70.sp,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
