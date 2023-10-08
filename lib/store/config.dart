import 'package:mobx/mobx.dart';
part 'config.g.dart';

class Config = ConfigBase with _$Config;

abstract class ConfigBase with Store {
  @observable
  int selectedItemPositionMenu = 2;

  @action
  atualiza(index) {
    selectedItemPositionMenu = index;
  }

  @observable
  String? routeName;

  @observable
  String? oldRouteName;

  @action
  setRouteName(String? v) {
    oldRouteName = routeName;
    routeName = v;
  }
}
