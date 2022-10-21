import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'package:routine_app/data/collections/category.dart';
import 'package:routine_app/data/collections/routine.dart';
import 'package:routine_app/services/routes/routes.dart';

final appTitleProvider = Provider<String>((ref) {
  return 'Routine App';
});

final mainPageTitleProvider = Provider<String>((ref) {
  return 'Routine';
});

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationSupportDirectory();
  final isar = await Isar.open(
    [RoutineSchema, CategorySchema],
    directory: dir.path,
  );
  runApp(const ProviderScope(child: MyApp()));
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

class MainPage extends ConsumerStatefulWidget {
  static String get routeName => 'main';
  static String get routeLocation => '/';
  const MainPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(ref.watch(mainPageTitleProvider)),
        actions: [
          IconButton(
            onPressed: () => context.go('/create_routine'),
            icon: const Icon(Icons.add),
          )
        ],
      ),
    );
  }
}
