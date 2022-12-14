import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:routine_app/data/collections/category.dart';
import 'package:routine_app/services/db_services/isar_service.dart';
import 'package:routine_app/services/provider/text_provider.dart';
import 'package:routine_app/ui/widgets/custom_dropdown.dart';

class CreateRoutinePage extends ConsumerStatefulWidget {
  static String get routeName => 'create_routine';
  static String get routeLocation => '/$routeName';
  const CreateRoutinePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateRoutinPageState();
}

class _CreateRoutinPageState extends ConsumerState<CreateRoutinePage> {
  //List<Category>? categories;
  Category? dropdownValue;

  List<String> days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ]; //TODO: replace with isar data
  String dropdownValueDay = 'Monday'; //TODO: replace with isar data

  TimeOfDay selectedTime = TimeOfDay.now();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _newCategoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isar = ref.watch(isarProvider);
    final isarStream = ref.watch(isarStreamProvider);

    final width = MediaQuery.of(context).size.width * 0.7;

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
              const Text(
                'Category',
                style: TextStyle(
                    color: Colors.black38, fontWeight: FontWeight.w600),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: width,
                      child: CustomDropdown(
                        icon: const Icon(Icons.keyboard_arrow_down),
                        dropdownItems: isar.getAllCategories(),
                      )),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('New Category'),
                          content: TextFormField(
                            controller: _newCategoryController,
                          ),
                          actions: [
                            ElevatedButton(
                              onPressed: () async {
                                if (_newCategoryController.text.isNotEmpty) {
                                  isar.saveCategory(Category()
                                    ..name = _newCategoryController.text);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          "New course '${_newCategoryController.text}' saved in DB"),
                                    ),
                                  );
                                  Navigator.pop(context);
                                }
                              },
                              child: const Text('Add'),
                            )
                          ],
                        ),
                      );
                    },
                    icon: const Icon(Icons.add),
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Text(
                  'Title',
                  style: TextStyle(
                      color: Colors.black38, fontWeight: FontWeight.w600),
                ),
              ),
              TextFormField(
                controller: _titleController,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Text(
                  'Start Time',
                  style: TextStyle(
                      color: Colors.black38, fontWeight: FontWeight.w600),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: width,
                    child: TextFormField(
                      controller: _timeController,
                      enabled: false,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _selectedTime(context);
                    },
                    icon: const Icon(Icons.calendar_month),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16),
              ),
              SizedBox(
                width: width,
                child: DropdownButton(
                  focusColor: const Color(0xffffffff),
                  dropdownColor: const Color(0xffffffff),
                  isExpanded: true,
                  value: dropdownValueDay,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: days.map<DropdownMenuItem<String>>((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      dropdownValueDay = value!;
                    });
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16),
              ),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Add'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _selectedTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        initialEntryMode: TimePickerEntryMode.dial);

    if (timeOfDay != null && timeOfDay != selectedTime) {
      selectedTime = timeOfDay;
      setState(() {
        _timeController.text =
            "${selectedTime.hour}:${selectedTime.minute} ${selectedTime.period.name}";
      });
    }
  }
}
