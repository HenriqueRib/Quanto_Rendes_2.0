import 'package:quanto_rendes_2/pages/contato/contato_view.dart';
import 'package:quanto_rendes_2/pages/home/home_view.dart';
// import 'package:quanto_rendes_2/pages/perfil/perfil_view.dart';
import 'package:quanto_rendes_2/pages/sobre/sobre_view.dart';

typedef Constructor<T> = T Function();

final Map<String, Constructor<Object>> _constructors =
    <String, Constructor<Object>>{};

void register<T>(Constructor<T> constructor) {
  _constructors[T.toString()] = constructor as Constructor<Object>;
}

class ClassBuilder {
  static void registerClasses() {
    register<HomeView>(() => HomeView());
    // register<PerfilView>(() => PerfilView());
    register<SobreView>(() => SobreView());
    register<ContatoView>(() => ContatoView());
    // register<DownloadPageView>(() => DownloadPageView());
  }

  static dynamic fromString(String type) {
    if (_constructors[type] != null) return _constructors[type]!();
  }
}
