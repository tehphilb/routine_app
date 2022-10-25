import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dropdownValueProvider = StateProvider<String>((ref) {
  return 'test';
});

class CustomDropdown extends ConsumerWidget {
  final Icon icon;
  final Future<List> dropdownItems;
  const CustomDropdown(
      {super.key, required this.icon, required this.dropdownItems});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dropdownValue = ref.watch(dropdownValueProvider);
    return StreamBuilder(
      stream: dropdownItems.,
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return DropdownButton(
              icon: icon,
              focusColor: const Color(0xffffffff),
              dropdownColor: const Color(0xffffffff),
              isExpanded: true,
              value: dropdownValue,
              items: snapshot.data
                  ?.map(
                    (e) => DropdownMenuItem(
                      value: e.name,
                      child: Text(e.name),
                    ),
                  )
                  .toList(),
              onChanged: (value) => ref
                  .watch(dropdownValueProvider.state)
                  .state = value.toString());
        }
        return const CircularProgressIndicator();
      },
    );
  }
}


// DropdownButton(
//                       focusColor: const Color(0xffffffff),
//                       dropdownColor: const Color(0xffffffff),
//                       isExpanded: true,
//                       value: dropdownValue,
//                       icon: const Icon(Icons.keyboard_arrow_down),
//                       items: categories
//                           .map<DropdownMenuItem<Category>>((Category item) {
//                         return DropdownMenuItem<Category>(
//                           value: item,
//                           child: Text(item.name),
//                         );
//                       }).toList(),
//                       onChanged: (Category? value) {
//                         setState(() {
//                           dropdownValue = value!;
//                         });
//                       },
//                     ),