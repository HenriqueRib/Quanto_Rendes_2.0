// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$Config on ConfigBase, Store {
  late final _$selectedItemPositionMenuAtom =
      Atom(name: 'ConfigBase.selectedItemPositionMenu', context: context);

  @override
  int get selectedItemPositionMenu {
    _$selectedItemPositionMenuAtom.reportRead();
    return super.selectedItemPositionMenu;
  }

  @override
  set selectedItemPositionMenu(int value) {
    _$selectedItemPositionMenuAtom
        .reportWrite(value, super.selectedItemPositionMenu, () {
      super.selectedItemPositionMenu = value;
    });
  }

  late final _$routeNameAtom =
      Atom(name: 'ConfigBase.routeName', context: context);

  @override
  String? get routeName {
    _$routeNameAtom.reportRead();
    return super.routeName;
  }

  @override
  set routeName(String? value) {
    _$routeNameAtom.reportWrite(value, super.routeName, () {
      super.routeName = value;
    });
  }

  late final _$oldRouteNameAtom =
      Atom(name: 'ConfigBase.oldRouteName', context: context);

  @override
  String? get oldRouteName {
    _$oldRouteNameAtom.reportRead();
    return super.oldRouteName;
  }

  @override
  set oldRouteName(String? value) {
    _$oldRouteNameAtom.reportWrite(value, super.oldRouteName, () {
      super.oldRouteName = value;
    });
  }

  late final _$ConfigBaseActionController =
      ActionController(name: 'ConfigBase', context: context);

  @override
  dynamic atualiza(dynamic index) {
    final _$actionInfo =
        _$ConfigBaseActionController.startAction(name: 'ConfigBase.atualiza');
    try {
      return super.atualiza(index);
    } finally {
      _$ConfigBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setRouteName(String? v) {
    final _$actionInfo = _$ConfigBaseActionController.startAction(
        name: 'ConfigBase.setRouteName');
    try {
      return super.setRouteName(v);
    } finally {
      _$ConfigBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedItemPositionMenu: ${selectedItemPositionMenu},
routeName: ${routeName},
oldRouteName: ${oldRouteName}
    ''';
  }
}
