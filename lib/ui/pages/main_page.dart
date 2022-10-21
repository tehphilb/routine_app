import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:routine_app/main.dart';

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
