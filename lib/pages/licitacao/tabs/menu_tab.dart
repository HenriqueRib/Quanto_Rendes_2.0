import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:quanto_rendes_2/pages/pesquisa/section/pesquisa_detalhes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quanto_rendes_2/utils/constants.dart';
import 'package:flutter/material.dart';

class MenuTab extends StatefulWidget {
  final TabController? tabController;
  const MenuTab({
    super.key,
    this.tabController,
  });

  @override
  State<MenuTab> createState() => _MenuTabState();
}

class _MenuTabState extends State<MenuTab> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      padding: EdgeInsets.only(
        bottom: 20.sp,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Observer(builder: (_) {
                return Expanded(
                  child: TabBar(
                    controller: widget.tabController,
                    padding: EdgeInsets.zero,
                    labelPadding: EdgeInsets.symmetric(
                      horizontal: 0.sp,
                    ),
                    // indicatorColor: Colors.red,
                    onTap: (index) {
                      utilStore.setIndexPageLicitacao(index);
                    },
                    tabs: List.generate(5, (index) {
                      Map<int, String> items = {
                        0: "Inf. Gerais",
                        1: "Anexos",
                        2: "Itens",
                        3: "Mensagens",
                        4: "Anotações",
                      };
                      Color color = Constants.color;
                      if (utilStore.indexPageLicitacao != index) {
                        color = const Color.fromARGB(95, 0, 0, 0);
                      }
                      return Container(
                        color: color,
                        width: 200.sp,
                        height: 30.sp,
                        child: Center(
                          child: Text(
                            items[index] ?? "",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Constants.color1,
                              fontSize: 9.sp,
                              height: 1,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}
