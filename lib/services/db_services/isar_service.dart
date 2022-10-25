import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:routine_app/data/collections/category.dart';
import 'package:routine_app/data/collections/routine.dart';

final isarProvider = Provider<IsarService>((ref) {
  return IsarService();
});

final isarStreamProvider = StreamProvider<IsarService>((ref) async* {
  yield IsarService();
});

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = openDB();
  }

  Future<void> saveCategory(Category newCategory) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.categorys.putSync(newCategory));
  }

  // Future<void> saveStudent(Student newStudent) async {
  //   final isar = await db;
  //   isar.writeTxnSync<int>(() => isar.students.putSync(newStudent));
  // }

  // Future<void> saveTeacher(Teacher newTeacher) async {
  //   final isar = await db;
  //   isar.writeTxnSync<int>(() => isar.teachers.putSync(newTeacher));
  // }

  Future<List<Category>> getAllCategories() async {
    final isar = await db;
    return await isar.categorys.where().findAll();
  }

  Stream<List<Category>> listenToCategories() async* {
    final isar = await db;
    yield* isar.categorys.where().watch();
  }

  Future<void> cleanDb() async {
    final isar = await db;
    await isar.writeTxn(() => isar.clear());
  }

  // Future<List<Student>> getStudentsFor(Course course) async {
  //   final isar = await db;
  //   return await isar.students
  //       .filter()
  //       .courses((q) => q.idEqualTo(course.id))
  //       .findAll();
  // }

  // Future<Teacher?> getTeacherFor(Course course) async {
  //   final isar = await db;

  //   final teacher = await isar.teachers
  //       .filter()
  //       .course((q) => q.idEqualTo(course.id))
  //       .findFirst();

  //   return teacher;
  // }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [RoutineSchema, CategorySchema],
        inspector: true,
      );
    }

    return Future.value(Isar.getInstance());
  }
}
