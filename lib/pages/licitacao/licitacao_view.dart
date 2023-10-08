// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, deprecated_member_use, library_private_types_in_public_api, sort_child_properties_last, prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:teste_projeto_47/pages/licitacao/tabs/anexos.dart';
import 'package:teste_projeto_47/pages/licitacao/tabs/anotacoes.dart';
import 'package:teste_projeto_47/pages/licitacao/tabs/info_gerais.dart';
import 'package:teste_projeto_47/pages/licitacao/tabs/itens.dart';
import 'package:teste_projeto_47/pages/licitacao/tabs/menssagens.dart';
import 'package:teste_projeto_47/pages/licitacao/tabs/menu_tab.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teste_projeto_47/store/utils.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:teste_projeto_47/utils/constants.dart';
import 'package:qlevar_router/qlevar_router.dart';

final utilStore = GetIt.I.get<Utils>();

class LicitacaoView extends StatefulWidget {
  const LicitacaoView({super.key});

  @override
  _LicitacaoViewState createState() => _LicitacaoViewState();
}

class _LicitacaoViewState extends State<LicitacaoView>
    with SingleTickerProviderStateMixin {
  PageController? pageController = PageController();
  TabController? _tabController;

  void _initActions() async {
    if (_tabController == null) {
      _tabController = TabController(
        length: 5,
        vsync: this,
        initialIndex: utilStore.indexPageLicitacao,
      );
      _tabController?.addListener(() {
        int? index = _tabController?.index;
        if (index is int) {
          delayedAction(
            () {
              utilStore.setIndexPageLicitacao(index);
              setState(() {});
              pageController?.animateToPage(
                index,
                duration: const Duration(milliseconds: 150),
                curve: Curves.bounceIn,
              );
            },
            duration: const Duration(milliseconds: 150),
          );
        }
      });
    }
    delayedAction(
      () {
        _tabController?.animateTo(utilStore.indexPageLicitacao);
        pageController?.animateToPage(
          utilStore.indexPageLicitacao,
          duration: const Duration(milliseconds: 150),
          curve: Curves.bounceIn,
        );
      },
      duration: const Duration(milliseconds: 500),
    );
    // if (_reactionDisposer == null) {
    //   _reactionDisposer = reaction(
    //     (_) => mainStore.routeName,
    //     (_) async {
    //       String? currentRouteNameOnList = QR.currentRoute.name;
    //       printData('reactionDisposer called. $currentRouteNameOnList');
    //       if (currentRouteNameOnList == 'Loyalty') {
    //         _initActions();
    //       }
    //     },
    //   );
    // }
  }

  @override
  void initState() {
    super.initState();
    _initActions();
  }

  Future<void> Function(VoidCallback, {Duration? duration}) delayedAction =
      (VoidCallback? c, {Duration? duration}) async {
    await Future.delayed(duration ?? Duration(seconds: 0)).then((_) {
      c?.call();
    });
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 1.sw,
        height: 1.sh,
        color: Constants.color,
        child: RefreshIndicator(
          onRefresh: () async {
            utilStore.setLoading(false);
            utilStore.setMensagem();
            setState(() {});
            List<Future> futures = [];
            await Future.wait(futures);
            return Future.delayed(const Duration(seconds: 0));
          },
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Stack(
                children: [
                  Container(
                    height: 1.sh / 6.2,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/img/bg17.png'),
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
                    top: 35.sp,
                    child: SizedBox(
                      width: 1.sw,
                      height: 60.sp,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 30.sp,
                            padding: EdgeInsets.only(left: 10.sp, top: 10.sp),
                            child: ClipRRect(
                              child: IconButton(
                                padding: EdgeInsets.only(bottom: 5),
                                icon: FaIcon(
                                  FontAwesomeIcons.solidArrowAltCircleLeft,
                                  color: Constants.color1,
                                  size: 16.sp,
                                ),
                                onPressed: () {
                                  QR.back();
                                },
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 8.sp),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'COMISSÃO REGIONAL DE OBRAS/1-RJ',
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Roboto',
                                    color: Constants.color1,
                                  ),
                                ),
                                Text(
                                  'CN - 102018/160301    Tomada de Preço',
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontFamily: 'Roboto',
                                    color: Constants.color1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 20.sp,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    width: 1.sw,
                    top: 95.sp,
                    child: MenuTab(
                      tabController: _tabController,
                    ),
                  ),
                ],
              ),
              ExpandablePageView(
                controller: pageController,
                onPageChanged: (index) {
                  utilStore.setIndexPageLicitacao(index);
                  setState(() {});
                  delayedAction(
                    () {
                      _tabController?.animateTo(index);
                    },
                    duration: const Duration(milliseconds: 150),
                  );
                },
                children: [
                  InfoGerais(),
                  Anexos(),
                  Itens(),
                  Mensagens(),
                  Anotacoes(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
