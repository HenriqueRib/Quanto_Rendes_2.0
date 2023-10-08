// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, deprecated_member_use, library_private_types_in_public_api, sort_child_properties_last, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:teste_projeto_47/utils/constants.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../store/utils.dart';

final utilStore = GetIt.I.get<Utils>();

class NotificacaoView extends KFDrawerContent {
  NotificacaoView({Key? key});

  @override
  _NotificacaoViewState createState() => _NotificacaoViewState();
}

class _NotificacaoViewState extends State<NotificacaoView> {
  @override
  void initState() {
    super.initState();
  }

  final FocusNode _focusPesquisar = FocusNode();
  final _pesquisarkey = GlobalKey<FormFieldState>();
  final TextEditingController _controllerPesquisar =
      TextEditingController(text: "");
  bool isChecked = false;
  String? _selectedOption;
  String? _selectedLicitation;
  String? _selectedResponsible;
  String? _selectedLevel;

  List<Map<String, String>> dataList = [
    {
      'id': '1',
      'title': 'CN - 102018/160301',
      'status': 'Monitorando',
      'qtd': '25',
      'responsavel': 'Bruno Cardoso',
      'description': 'Comissão Regional de Obras/1- RJ | Tomada de preço',
    },
    {
      'id': '2',
      'title': 'CN - 202018/160302',
      'status': 'Monitorando',
      'qtd': '33',
      'responsavel': 'Bruno Cardoso',
      'description': 'Comissão Regional de Obras/1- RJ | Tomada de preço',
    },
    {
      'id': '5',
      'title': 'CN - 202018/160305',
      'qtd': '13',
      'responsavel': 'Bruno Cardoso',
      'description': 'Comissão Regional de Obras/1- RJ | Tomada de preço',
    },
    {
      'id': '6',
      'title': 'CN - 202018/160306',
      'status': 'Monitorando',
      'qtd': '33',
      'responsavel': 'Bruno Cardoso',
      'description': 'Comissão Regional de Obras/1- RJ | Tomada de preço',
    }
  ];
  bool isFilterMenuOpen = false;
  String? text;
  bool? isSelected = true;
  VoidCallback? onTap;
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
                              width: 0.sp,
                              height: 50,
                            ),
                            SizedBox(
                              height: 60.sp,
                              width: 1.sw - 15.sp,
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
                                              FontAwesomeIcons.bell,
                                              color: Constants.color1,
                                              size: 16.sp,
                                            ),
                                            onPressed: () {},
                                          ),
                                        ),
                                        Text(
                                          "NOTIFICAÇÕES",
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
                                    "Visualize as mensagens ainda não lidas de suas licitações em monitoramento",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      height: 1,
                                      fontSize: 9.sp,
                                      color: Constants.color1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 0.sp,
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
                                    Observer(builder: (_) {
                                      if (utilStore.loading == true) {
                                        return _carregando();
                                      }
                                      return Stack(
                                        children: [
                                          Container(
                                            width: 1.sw - 70.sp,
                                            height: 38.sp,
                                            margin: EdgeInsets.only(
                                              bottom: 5.sp,
                                              top: 3.sp,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.grey
                                                  .withOpacity(0.2.sp),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                15.0.sp,
                                              ),
                                            ),
                                            child: TextFormField(
                                              key: _pesquisarkey,
                                              focusNode: _focusPesquisar,
                                              decoration: InputDecoration(
                                                labelStyle: TextStyle(
                                                    color: Colors.black),
                                                border: InputBorder.none,
                                                prefixIcon: IconButton(
                                                  icon: Icon(
                                                    Icons.search,
                                                    color: Constants.color1,
                                                  ),
                                                  onPressed: () async {
                                                    utilStore.setLoading(true);
                                                    await Future.delayed(
                                                      const Duration(
                                                          seconds: 2),
                                                    );
                                                    utilStore
                                                        .setpesquisaDetalhes(
                                                            true);
                                                    QR.to('pesquisa');
                                                    utilStore.setLoading(false);
                                                  },
                                                ),
                                              ),
                                              controller: _controllerPesquisar,
                                              onChanged: (value) async {},
                                            ),
                                          ),
                                          Positioned(
                                            top: 0,
                                            right: 10,
                                            child: Row(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.black,
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40.0.sp),
                                                  ),
                                                  child: IconButton(
                                                    icon:
                                                        Icon(Icons.filter_alt),
                                                    onPressed: () {
                                                      setState(() {
                                                        isFilterMenuOpen =
                                                            !isFilterMenuOpen;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                                    Container(
                                      height: 50,
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
                                    ListView.builder(
                                      padding: EdgeInsets.only(bottom: 8.sp),
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: dataList.length,
                                      itemBuilder: (context, index) {
                                        final data = dataList[index];
                                        Color color = const Color.fromARGB(
                                          58,
                                          31,
                                          53,
                                          81,
                                        );
                                        Color colorBold = Constants.color8;

                                        return GestureDetector(
                                          onTap: () {
                                            QR.to('escolher_itens');
                                          },
                                          child: Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 8.sp),
                                            child: Slidable(
                                              key: Key(index.toString()),
                                              startActionPane: ActionPane(
                                                motion: const ScrollMotion(),
                                                // dismissible: DismissiblePane(onDismissed: (_) {}),
                                                children: [
                                                  SlidableAction(
                                                    onPressed: (_) {
                                                      QR.to('licitacao');
                                                    },
                                                    backgroundColor: colorBold,
                                                    foregroundColor:
                                                        Constants.color1,
                                                    icon: Icons.edit,
                                                  ),
                                                  SlidableAction(
                                                    onPressed: (_) {
                                                      _showAnotacao();
                                                    },
                                                    backgroundColor: colorBold,
                                                    foregroundColor:
                                                        Constants.color1,
                                                    icon: Icons.note_outlined,
                                                  ),
                                                  SlidableAction(
                                                    onPressed: (_) {},
                                                    backgroundColor: colorBold,
                                                    foregroundColor:
                                                        Constants.color1,
                                                    icon: Icons.keyboard,
                                                  ),
                                                  SlidableAction(
                                                    onPressed: (_) {},
                                                    backgroundColor: colorBold,
                                                    foregroundColor:
                                                        Constants.color1,
                                                    icon: Icons.delete,
                                                  ),
                                                ],
                                              ),
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
                                                      padding:
                                                          EdgeInsets.all(7.sp),
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                data['title']!,
                                                                style:
                                                                    TextStyle(
                                                                  color:
                                                                      colorBold,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                              Container(
                                                                width: 35.sp,
                                                                // height: 25.sp,
                                                                child: Stack(
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .email,
                                                                    ),
                                                                    Observer(
                                                                        builder:
                                                                            (_) {
                                                                      if (data[
                                                                              'qtd'] ==
                                                                          null) {
                                                                        return Container();
                                                                      }
                                                                      return Positioned(
                                                                        bottom:
                                                                            10,
                                                                        left: 18
                                                                            .sp,
                                                                        child:
                                                                            Container(
                                                                          padding:
                                                                              EdgeInsets.all(
                                                                            2.sp,
                                                                          ),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Colors.grey,
                                                                            shape:
                                                                                BoxShape.circle,
                                                                          ),
                                                                          child:
                                                                              Text(
                                                                            data['qtd']!,
                                                                            style:
                                                                                TextStyle(
                                                                              color: colorBold,
                                                                              fontSize: 8.sp,
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    }),
                                                                  ],
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                data[
                                                                    'description']!,
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      10.sp,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 5.sp,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .only(
                                                                  right: 5.sp,
                                                                ),
                                                                child: Row(
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .person_sharp,
                                                                      color:
                                                                          colorBold,
                                                                      size:
                                                                          18.sp,
                                                                    ),
                                                                    Text(
                                                                      data[
                                                                          'responsavel']!,
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .grey,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontSize:
                                                                            10.sp,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        right: 5
                                                                            .sp),
                                                                child: Row(
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .edit,
                                                                      color:
                                                                          colorBold,
                                                                      size:
                                                                          18.sp,
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
                                    SizedBox(
                                      height: 70.sp,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Observer(builder: (_) {
                              if (isFilterMenuOpen) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isFilterMenuOpen = false;
                                    });
                                  },
                                  child: Container(
                                    width: 2000,
                                    color: const Color.fromARGB(46, 0, 0, 0),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        width: 180.sp,
                                        height:
                                            MediaQuery.of(context).size.height,
                                        color: Color.fromARGB(174, 31, 53, 81),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 20.sp,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.filter_alt,
                                                    size: 15.sp,
                                                    color: Constants.color1,
                                                  ),
                                                  Text(
                                                    'FILTRAR',
                                                    style: TextStyle(
                                                      color: Constants.color1,
                                                      fontSize: 15.sp,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20.sp,
                                            ),
                                            SizedBox(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Portal:',
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                      height: 1,
                                                      fontSize: 11.sp,
                                                      color: Constants.color1,
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 150.sp,
                                                    margin: EdgeInsets.only(
                                                        top: 5.sp),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        15.0.sp,
                                                      ),
                                                      border: Border.all(
                                                        color: Constants.color1,
                                                      ),
                                                    ),
                                                    child:
                                                        DropdownButtonFormField<
                                                            String>(
                                                      decoration:
                                                          const InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                      ),
                                                      value: _selectedOption,
                                                      isExpanded: true,
                                                      style: TextStyle(
                                                        fontSize: 11.sp,
                                                        color: Constants.color1,
                                                      ),
                                                      onChanged:
                                                          (String? newValue) {
                                                        setState(() {
                                                          _selectedOption =
                                                              newValue!;
                                                        });
                                                      },
                                                      dropdownColor:
                                                          const Color.fromARGB(
                                                              46, 0, 0, 0),
                                                      items: <String>[
                                                        'Compras net',
                                                        'Banpará',
                                                        'Banco do Brasil',
                                                      ].map<
                                                          DropdownMenuItem<
                                                              String>>(
                                                        (String value) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: value,
                                                            child: Container(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 10
                                                                          .sp),
                                                              child: Text(
                                                                value,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      12.sp,
                                                                  color: Colors
                                                                      .white,
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
                                              height: 20.sp,
                                            ),
                                            SizedBox(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Licitação:',
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                      height: 1,
                                                      fontSize: 11.sp,
                                                      color: Constants.color1,
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 150.sp,
                                                    margin: EdgeInsets.only(
                                                        top: 5.sp),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0.sp),
                                                      border: Border.all(
                                                        color: Constants.color1,
                                                      ),
                                                    ),
                                                    child:
                                                        DropdownButtonFormField<
                                                            String>(
                                                      decoration:
                                                          const InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                      ),
                                                      value:
                                                          _selectedLicitation,
                                                      isExpanded: true,
                                                      style: TextStyle(
                                                        fontSize: 11.sp,
                                                        color: Constants.color1,
                                                      ),
                                                      onChanged:
                                                          (String? newValue) {
                                                        setState(() {
                                                          _selectedLicitation =
                                                              newValue!;
                                                        });
                                                      },
                                                      dropdownColor:
                                                          const Color.fromARGB(
                                                              46, 0, 0, 0),
                                                      items: <String>[
                                                        '00001',
                                                        '00002',
                                                        '00003',
                                                      ].map<
                                                          DropdownMenuItem<
                                                              String>>(
                                                        (String value) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: value,
                                                            child: Container(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 10
                                                                          .sp),
                                                              child: Text(
                                                                value,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      12.sp,
                                                                  color: Colors
                                                                      .white,
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
                                              height: 20.sp,
                                            ),
                                            SizedBox(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Responsável:',
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                      height: 1,
                                                      fontSize: 11.sp,
                                                      color: Constants.color1,
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 150.sp,
                                                    margin: EdgeInsets.only(
                                                        top: 5.sp),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0.sp),
                                                      border: Border.all(
                                                        color: Constants.color1,
                                                      ),
                                                    ),
                                                    child:
                                                        DropdownButtonFormField<
                                                            String>(
                                                      decoration:
                                                          const InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                      ),
                                                      value:
                                                          _selectedResponsible,
                                                      isExpanded: true,
                                                      style: TextStyle(
                                                        fontSize: 11.sp,
                                                        color: Constants.color1,
                                                      ),
                                                      onChanged:
                                                          (String? newValue) {
                                                        setState(() {
                                                          _selectedResponsible =
                                                              newValue!;
                                                        });
                                                      },
                                                      dropdownColor:
                                                          const Color.fromARGB(
                                                              46, 0, 0, 0),
                                                      items: <String>[
                                                        'Bruno Cardoso',
                                                        'Henrique Ribeiro',
                                                        'Lucas Oliveira',
                                                      ].map<
                                                          DropdownMenuItem<
                                                              String>>(
                                                        (String value) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: value,
                                                            child: Container(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 10
                                                                          .sp),
                                                              child: Text(
                                                                value,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      12.sp,
                                                                  color: Colors
                                                                      .white,
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
                                              height: 20.sp,
                                            ),
                                            SizedBox(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Nível:',
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                      height: 1,
                                                      fontSize: 11.sp,
                                                      color: Constants.color1,
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 150.sp,
                                                    margin: EdgeInsets.only(
                                                        top: 5.sp),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0.sp),
                                                      border: Border.all(
                                                        color: Constants.color1,
                                                      ),
                                                    ),
                                                    child:
                                                        DropdownButtonFormField<
                                                            String>(
                                                      decoration:
                                                          const InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                      ),
                                                      value: _selectedLevel,
                                                      isExpanded: true,
                                                      style: TextStyle(
                                                        fontSize: 11.sp,
                                                        color: Constants.color1,
                                                      ),
                                                      onChanged:
                                                          (String? newValue) {
                                                        setState(() {
                                                          _selectedLevel =
                                                              newValue!;
                                                        });
                                                      },
                                                      dropdownColor:
                                                          const Color.fromARGB(
                                                              46, 0, 0, 0),
                                                      items: <String>[
                                                        'Nível 1',
                                                        'Nível 2',
                                                        'Nível 3',
                                                      ].map<
                                                          DropdownMenuItem<
                                                              String>>(
                                                        (String value) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: value,
                                                            child: Container(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 10
                                                                          .sp),
                                                              child: Text(
                                                                value,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      12.sp,
                                                                  color: Colors
                                                                      .white,
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
                                              height: 20.sp,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }
                              return Container();
                            }),
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
