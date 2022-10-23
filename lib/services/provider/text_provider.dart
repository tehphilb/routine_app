import 'package:flutter_riverpod/flutter_riverpod.dart';

final appTitleProvider = Provider<String>((ref) {
  return 'Routine App';
});

final mainPageTitleProvider = Provider<String>((ref) {
  return 'Routine';
});

final createRoutinePageTitleProvider = Provider<String>((ref) {
  return 'Create routine';
});
