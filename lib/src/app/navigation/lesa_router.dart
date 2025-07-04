import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lesa/src/narrated_reading/ui/pages/narrated_reading_flow_page/narrated_reading_flow_page.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class LesaRouter {
  static GoRouter create() {
    return GoRouter(
      navigatorKey: navigatorKey,
      observers: [],
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const NarratedReadingFlowPage(),
        ),
      ],
    );
  }
}
