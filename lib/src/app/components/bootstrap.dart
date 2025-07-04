import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:lesa/src/src.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    logger.e(details.exceptionAsString(), stackTrace: details.stack);
  };

  runApp(await builder());
}
