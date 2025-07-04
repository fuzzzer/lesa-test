import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:lesa/src/src.dart';

class Initializer {
  static Future<void> preAppInit() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Environment.initialize();

    Bloc.observer = const AppBlocObserver();

    await DependencyInjection.inject();
  }
}
