import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'package:routine_app/data/collections/category.dart';
import 'package:routine_app/data/collections/routine.dart';
import 'package:routine_app/services/provider/text_provider.dart';
import 'package:routine_app/services/routes/routes.dart';

final initDirIsarProvider = FutureProvider<Isar>((ref) async {
  log('building initDirIsarProvider');
  final dir = await getApplicationSupportDirectory();
  return await Isar.open(
    [RoutineSchema, CategorySchema],
    directory: dir.path,
  );
});

Future<void> main() async {
  runApp(
    const Center(
      child: CircularProgressIndicator(),
    ),
  );

  WidgetsFlutterBinding.ensureInitialized();
  final container = ProviderContainer();
  container.read(initDirIsarProvider);

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,
      title: ref.watch(appTitleProvider),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
