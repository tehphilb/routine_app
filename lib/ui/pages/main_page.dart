import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:routine_app/services/provider/text_provider.dart';

class MainPage extends ConsumerWidget {
  static String get routeName => 'main';
  static String get routeLocation => '/';
  
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final mainPageTitle = ref.watch(mainPageTitleProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(mainPageTitle),
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
