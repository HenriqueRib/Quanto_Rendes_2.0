import 'package:quanto/pages/contato/contato_view.dart';
import 'package:quanto/pages/home/home_view.dart';
import 'package:quanto/pages/perfil/perfil_view.dart';
import 'package:quanto/pages/sobre/sobre_view.dart';

typedef Constructor<T> = T Function();

final Map<String, Constructor<Object>> _constructors =
    <String, Constructor<Object>>{};

void register<T>(Constructor<T> constructor) {
  _constructors[T.toString()] = constructor as Constructor<Object>;
}

class ClassBuilder {
  static void registerClasses() {
    register<HomeView>(() => HomeView());
    register<PerfilView>(() => PerfilView());
    register<SobreView>(() => SobreView());
    register<ContatoView>(() => ContatoView());
    // register<DownloadPageView>(() => DownloadPageView());
  }

  static dynamic fromString(String type) {
    if (_constructors[type] != null) return _constructors[type]!();
  }
}
