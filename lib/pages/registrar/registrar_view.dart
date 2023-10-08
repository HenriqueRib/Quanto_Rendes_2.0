// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, deprecated_member_use, library_private_types_in_public_api, sort_child_properties_last, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quanto_rendes_2/utils/constants.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../store/utils.dart';

final utilStore = GetIt.I.get<Utils>();

class RegistrarView extends KFDrawerContent {
  RegistrarView({Key? key});

  @override
  _RegistrarViewState createState() => _RegistrarViewState();
}

class _RegistrarViewState extends State<RegistrarView> {
  @override
  void initState() {
    super.initState();
  }

  final TextEditingController _controllerkmAtual = TextEditingController();
  // final TextEditingController _controllerValorLitro =
  //     MoneyMaskedTextController(decimalSeparator: '.');
  // final TextEditingController _controllerValorReais =
  //     MoneyMaskedTextController(decimalSeparator: '.');
  // final TextEditingController _controllerQtdLitrosAbastecido =
  //     MoneyMaskedTextController(decimalSeparator: '.');

  final TextEditingController _controllerValorLitro = TextEditingController();
  final TextEditingController _controllerValorReais = TextEditingController();
  final TextEditingController _controllerQtdLitrosAbastecido =
      TextEditingController();

  final TextEditingController _controllerPosto = TextEditingController();
  final FocusNode _focusKmAtual = FocusNode();
  final FocusNode _focusValorLitro = FocusNode();
  final FocusNode _focusValorReais = FocusNode();
  // final FocusNode _focusQtdLitro = FocusNode();
  final FocusNode _focusPosto = FocusNode();
  String dropdownValue = 'Etanol';
  String _textoResultado = "Registre seu abastecimento";

  final FocusNode _focusPesquisar = FocusNode();
  final _pesquisarkey = GlobalKey<FormFieldState>();
  final TextEditingController _controllerPesquisar =
      TextEditingController(text: "");
  bool isChecked = false;
  String? _selectedOption;
  String? _selectedLicitation;
  String? _selectedResponsible;
  String? _selectedLevel;

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
                              height: 50,
                            ),
                            SizedBox(
                              height: 60.sp,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                                            padding: EdgeInsets.only(bottom: 5),
                                            icon: FaIcon(
                                              FontAwesomeIcons.comments,
                                              color: Constants.color1,
                                              size: 16.sp,
                                            ),
                                            onPressed: () {},
                                          ),
                                        ),
                                        Text(
                                          "CHAT / Registrar",
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
                                    "Visualize as Registrar das licitações que esteja monitorando",
                                    style: TextStyle(
                                      height: 1,
                                      fontSize: 10.sp,
                                      color: Constants.color1,
                                    ),
                                  ),
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
                        child: Stack(
                          children: [
                            SizedBox(
                              width: 1.sw,
                              height: 1.sh,
                              child: Form(
                                key: formKey,
                                child: ListView(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: .01.sw),
                                  children: [
                                    SizedBox(
                                      height: 15.sp,
                                    ),
                                    Container(
                                      height: 0.sp,
                                      padding: EdgeInsets.only(left: 5.sp),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Ordenar por:",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13.sp,
                                            ),
                                          ),
                                          Spacer(),
                                          GestureDetector(
                                            onTap: () {},
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 15.sp,
                                                vertical: 5.sp,
                                              ),
                                              margin: EdgeInsets.symmetric(
                                                horizontal: 10.sp,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  20.sp,
                                                ),
                                                border: Border.all(
                                                  color: Constants.color,
                                                  width: 2.sp,
                                                ),
                                              ),
                                              child: Text(
                                                "Portal",
                                                style: TextStyle(
                                                  color: Constants.color,
                                                ),
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {},
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 15.sp,
                                                vertical: 5.sp,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  20.sp,
                                                ),
                                                border: Border.all(
                                                  color: Colors.grey,
                                                  width: 2.sp,
                                                ),
                                              ),
                                              child: Text(
                                                "Mensagem",
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.sp,
                                    ),
                                    Center(
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                bottom: 90,
                                              ),
                                              child: Text(
                                                _textoResultado,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            TextField(
                                              focusNode: _focusKmAtual,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                labelText:
                                                    "Km Atual, ex: 118877.5",
                                                suffixIcon: IconButton(
                                                  onPressed: () =>
                                                      _controllerkmAtual
                                                          .clear(),
                                                  icon: const Icon(
                                                    Icons.clear,
                                                  ),
                                                ),
                                              ),
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 19),
                                              controller: _controllerkmAtual,
                                            ),
                                            TextField(
                                              focusNode: _focusValorLitro,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                labelText:
                                                    "Valor do Litro, ex: 5.14",
                                                suffixIcon: IconButton(
                                                  onPressed: () =>
                                                      _controllerValorLitro
                                                          .clear(),
                                                  icon: const Icon(
                                                    Icons.clear,
                                                  ),
                                                ),
                                              ),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 19,
                                              ),
                                              controller: _controllerValorLitro,
                                            ),
                                            TextField(
                                              focusNode: _focusValorReais,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                labelText:
                                                    "Valor em reais, ex: 209.09",
                                                suffixIcon: IconButton(
                                                  onPressed: () =>
                                                      _controllerValorReais
                                                          .clear(),
                                                  icon: const Icon(
                                                    Icons.clear,
                                                  ),
                                                ),
                                              ),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 19,
                                              ),
                                              controller: _controllerValorReais,
                                            ),
                                            // TextField(
                                            //   focusNode: _focusQtdLitro,
                                            //   keyboardType: TextInputType.number,
                                            //   decoration: InputDecoration(
                                            //     labelText: "Qtd em litros abastecido, ex: 40.61",
                                            //     suffixIcon: IconButton(
                                            //       onPressed: () => _controllerQtdLitrosAbastecido.clear(),
                                            //       icon: const Icon(
                                            //         Icons.clear,
                                            //       ),
                                            //     ),
                                            //   ),
                                            //   style: const TextStyle(
                                            //     color: Colors.white,
                                            //     fontSize: 19,
                                            //   ),
                                            //   controller: _controllerQtdLitrosAbastecido,
                                            // ),
                                            TextField(
                                              focusNode: _focusPosto,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                labelText:
                                                    "Posto de combustível",
                                                suffixIcon: IconButton(
                                                  onPressed: () =>
                                                      _controllerPosto.clear(),
                                                  icon: const Icon(
                                                    Icons.clear,
                                                  ),
                                                ),
                                              ),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 19,
                                              ),
                                              controller: _controllerPosto,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 5,
                                                left: 5,
                                                right: 5,
                                                bottom: 15,
                                              ),
                                              child: DropdownButton<String>(
                                                isExpanded: true,
                                                value: dropdownValue,
                                                icon: const Icon(
                                                  Icons.arrow_downward,
                                                  color: Colors.white,
                                                ),
                                                elevation: 16,
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                ),
                                                underline: Container(
                                                  height: 2,
                                                  color: Colors.teal,
                                                ),
                                                onChanged: (String? newValue) {
                                                  setState(() {
                                                    dropdownValue = newValue!;
                                                  });
                                                },
                                                items: <String>[
                                                  'Etanol',
                                                  'Gasolina'
                                                ].map<DropdownMenuItem<String>>(
                                                    (String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(
                                                      value,
                                                    ),
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                TextButton(
                                                  onPressed: () async {
                                                    // _limpar();
                                                  },
                                                  child: Ink(
                                                    decoration: BoxDecoration(
                                                      gradient:
                                                          const LinearGradient(
                                                              colors: [
                                                            Constants.color7,
                                                            Constants.color7,
                                                          ]),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(10.sp),
                                                      ),
                                                    ),
                                                    child: Container(
                                                      constraints:
                                                          BoxConstraints(
                                                        minWidth: 150.sp,
                                                        minHeight: 30.sp,
                                                      ),
                                                      alignment:
                                                          Alignment.center,
                                                      child: const Text(
                                                        'Limpar info',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color:
                                                              Constants.color2,
                                                          fontSize: 21,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () async {
                                                    // _salvarAbastecimento();
                                                  },
                                                  child: Ink(
                                                    decoration: BoxDecoration(
                                                      gradient:
                                                          const LinearGradient(
                                                              colors: [
                                                            Constants.color7,
                                                            Constants.color7,
                                                          ]),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(10.sp),
                                                      ),
                                                    ),
                                                    child: Container(
                                                      constraints:
                                                          BoxConstraints(
                                                        minWidth: 150.sp,
                                                        minHeight: 30.sp,
                                                      ),
                                                      alignment:
                                                          Alignment.center,
                                                      child: const Text(
                                                        'Salvar',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color:
                                                              Constants.color2,
                                                          fontSize: 21,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 70.sp,
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
              ),
            ],
          ),
        ),
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
