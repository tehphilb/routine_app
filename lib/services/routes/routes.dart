import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:routine_app/ui/pages/create_routine_page.dart';
import 'package:routine_app/ui/pages/main_page.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
      navigatorKey: navigatorKey,
      debugLogDiagnostics: true,
      initialLocation: MainPage.routeLocation,
      routes: [
        GoRoute(
          path: MainPage.routeLocation,
          name: MainPage.routeName,
          builder: (context, state) {
            return const MainPage();
          },
        ),
        GoRoute(
          path: CreateRoutinePage.routeLocation,
          name: CreateRoutinePage.routeName,
          builder: (context, state) {
            return const CreateRoutinePage();
          },
        ),
      ]);
});
