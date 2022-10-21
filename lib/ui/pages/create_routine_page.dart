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
  List<String> categories = [
    'work',
    'vacation',
    'sickleave'
  ]; //TODO: replace with isar data
  String dropdownValue = 'work'; //TODO: replace with isar data

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffffffff),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => context.go('/'),
            icon: const Icon(Icons.arrow_back),
          ),
          centerTitle: true,
          title: Text(ref.watch(createRoutinePageTitleProvider)),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Category'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: DropdownButton(
                        focusColor: const Color(0xffffffff),
                        dropdownColor: const Color(0xffffffff),
                        isExpanded: true,
                        value: dropdownValue,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: categories
                            .map<DropdownMenuItem<String>>((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            dropdownValue = value!;
                          });
                        },
                      ),
                    ),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.add))
                  ],
                )
              ],
            ),
          ),
        ));
  }
}

//https://www.youtube.com/watch?v=44ziT-XdPbI&list=PLKKf8l1ne4_hMBtRykh9GCC4MMyteUTyf&index=9 
// 30:52