import 'package:flutter/material.dart';

extension NavigationExtension on BuildContext {
  Future<T?> push<T>(String routeName, {Object? arguments}) =>
      Navigator.of(this).pushNamed<T>(routeName, arguments: arguments);

  Future<T?> pushReplacement<T, Result>(
    String routeName, {
    Object? arguments,
  }) => Navigator.of(this).pushReplacementNamed<T, Result>(
    routeName,
    arguments: arguments,
  );

  void get pop => Navigator.maybePop(this);

  void popWith<T>([T? result]) => Navigator.pop<T>(this, result);
}
