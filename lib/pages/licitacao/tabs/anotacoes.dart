import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../utils/constants.dart';
import '../../../store/utils.dart';

final utilStore = GetIt.I.get<Utils>();

class Anotacoes extends StatefulWidget {
  const Anotacoes({super.key});

  @override
  State<Anotacoes> createState() => _AnotacoesState();
}

class _AnotacoesState extends State<Anotacoes> {
  final FocusNode _focusPesquisar = FocusNode();
  final _pesquisarkey = GlobalKey<FormFieldState>();
  final TextEditingController _controllerPesquisar =
      TextEditingController(text: "");
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.sh - 125.sp,
      color: Constants.color1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Observer(builder: (_) {
            if (utilStore.loading == true) {
              return _carregando();
            }
            return Container(
              color: const Color.fromARGB(27, 0, 0, 0),
              height: 50.sp,
              padding: EdgeInsets.symmetric(horizontal: 13.sp, vertical: 2.sp),
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
                            Icons.add,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            _showAnotacao();
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
          SizedBox(
            height: 1.sh - 175.sp,
            child: ListView.builder(
              padding: EdgeInsets.only(bottom: 8.sp),
              itemCount: 2,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(05.sp),
                      child: Container(
                        width: 1.sw,
                        padding: EdgeInsets.all(10.sp),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 10.sp),
                                      child: Icon(
                                        Icons.note_outlined,
                                        size: 15.sp,
                                      ),
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry.',
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      color: Constants.color1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 5.sp),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                '05/05/2020 14:24',
                                style: TextStyle(
                                  color: Constants.color1,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
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

  _showAnotacao() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(0.sp),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0.sp),
          ),
          content: Container(
            width: 1.sw,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(20.0.sp),
              ),
              color: Constants.color,
            ),
            padding: EdgeInsets.only(
              top: 0.sp,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 10.sp, bottom: 10.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 20.sp,
                        child: const Icon(
                          Icons.note_outlined,
                          color: Constants.color1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10.sp),
                        child: Text(
                          'NOVA ANOTAÇÃO',
                          style: TextStyle(
                            color: Constants.color1,
                            fontSize: 15.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 200.sp,
                  color: Constants.color1,
                  padding: EdgeInsets.all(20.sp),
                  child: ClipRRect(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20.sp),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 10.sp),
                      child: const TextField(
                        maxLines: 2,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Digite aqui...',
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    ),
                    color: Constants.color2,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                        child: Ink(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Colors.grey,
                              Colors.grey,
                            ]),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Container(
                            constraints: BoxConstraints(
                              minWidth: 0.5.sw,
                              minHeight: 35.sp,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Salvar',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color.fromARGB(146, 0, 0, 0),
                                fontSize: 17.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
