import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final createRoutinePageTitleProvider = Provider<String>((ref) {
  return 'Create routine';
});

class CreateRoutinePage extends ConsumerStatefulWidget {
  static String get routeName => 'create_routine';
  static String get routeLocation => '/$routeName';
  const CreateRoutinePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateRoutinPageState();
}

class _CreateRoutinPageState extends ConsumerState<CreateRoutinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => context.go('/'),
            icon: const Icon(Icons.arrow_back),
          ),
          centerTitle: true,
          title: Text(ref.watch(createRoutinePageTitleProvider)),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Text('Category'),
            ],
          ),
        ));
  }
}
