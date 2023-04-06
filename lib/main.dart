import 'package:fl_toast/fl_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:quanto/routes/app_routes.dart';
import 'package:quanto/store/config.dart';
import 'package:quanto/utils/class_builder.dart';
import 'package:quanto/utils/constants.dart';
import 'package:quanto/utils/router_observer.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

final config = GetIt.I.get<Config>();
SharedPreferences? sharedPreferences;

SnakeShape snakeShape = SnakeShape.circle;
bool showSelectedLabels = true;
bool showUnselectedLabels = true;
Color selectedColor = Constants.color5;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  sharedPreferences = await SharedPreferences.getInstance();
  final getIt = GetIt.I;
  ClassBuilder.registerClasses();
  getIt.registerSingleton(Config());
  // getIt.registerSingleton(LoginStore());
  // getIt.registerSingleton(UtilsStore());
  // getIt.registerSingleton(UserStore());

  runApp(
    const QlevarApp(),
  );
}

class QlevarApp extends StatelessWidget {
  const QlevarApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appRoutes = AppRoutes();
    appRoutes.setup();
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) {
        return MaterialApp.router(
          routeInformationParser: const QRouteInformationParser(),
          routerDelegate: QRouterDelegate(
            appRoutes.routes,
            observers: [
              RouterObserver(),
            ],
          ),
          theme: ThemeData(
            colorSchemeSeed: Constants.color1,
          ),
          builder: (context, widget) {
            widget = _getMenu(widget);
            widget = EasyLoading.init()(context, widget);
            widget = _getSnackMenu(widget);
            return widget!;
          },
        );
      },
    );
  }
}

_getSnackMenu(widget) {
  return Observer(builder: (_) {
    String? routeName = config.routeName;
    if (validaTela(routeName)) {
      return SizedBox(
        width: 1.sw,
        height: 1.sh,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            widget!,
          ],
        ),
      );
    }

    return SizedBox(
      width: 1.sw,
      height: 1.sh,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          widget!,
          const CustomBottomNavBar(),
        ],
      ),
    );
  });
}

_getMenu(widget) {
  return Overlay(
    initialEntries: [
      OverlayEntry(
        builder: (context) {
          return ToastProvider(
            child: MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: widget!,
            ),
          );
        },
      ),
    ],
  );
}

// class RestartWidget extends StatefulWidget {
//   const RestartWidget({super.key, required this.child});

//   final Widget child;

//   static void restartApp(BuildContext context) {
//     context.findAncestorStateOfType<_RestartWidgetState>()?.restartApp();
//   }

//   @override
//   _RestartWidgetState createState() => _RestartWidgetState();
// }

// class _RestartWidgetState extends State<RestartWidget> {
//   Key key = UniqueKey();

//   void restartApp() {
//     setState(() {
//       key = UniqueKey();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return KeyedSubtree(
//       key: key,
//       child: widget.child,
//     );
//   }
// }

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return SnakeNavigationBar.color(
          backgroundColor: Colors.grey[800],
          behaviour: SnakeBarBehaviour.floating,
          snakeShape: SnakeShape.circle,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          padding: const EdgeInsets.all(8),
          snakeViewColor: selectedColor,
          selectedItemColor:
              snakeShape == SnakeShape.indicator ? selectedColor : null,
          unselectedItemColor: Colors.white,
          showUnselectedLabels: showUnselectedLabels,
          showSelectedLabels: showSelectedLabels,
          currentIndex: config.selectedItemPositionMenu,
          onTap: (index) {
            config.atualiza(index);
            _setRota(index);
          },
          items: const [
            BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.houseChimney,
                color: Colors.white,
              ),
              label: "inicio",
            ),
            BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.comments,
                color: Colors.white,
              ),
              label: 'Contato',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.download,
                color: Colors.white,
              ),
              label: "sobre",
            ),
            BottomNavigationBarItem(
              icon: FaIcon(
                // FontAwesomeIcons.cartShopping,
                FontAwesomeIcons.user,
                color: Colors.white,
              ),
              label: "Perfil",
              // style: const TextStyle(color: Colors.red),
            ),
          ],
        );
      },
    );
  }
}

_setRota(index) {
  switch (index) {
    case 0:
      if (QR.navigator.currentRoute.name == null) {
        QR.to('/main');
      } else {
        QR.navigator.replaceLast('/main');
      }
      break;
    case 1:
      QR.to('/contato');
      break;
    case 2:
      QR.to('/sobre');
      break;
    case 3:
      QR.to('/perfil');
      break;
    default:
      QR.navigator.replaceLast('/main');
      break;
    // case 4:
    //   QR.to('/perfil');
    //   break;
  }
}

validaTela(tela) {
  switch (tela) {
    case "/main":
      return false;
    case "/perfil":
      return false;
    case "/sobre":
      return false;
    case "/contato":
      return false;
  }
  return true;
}
