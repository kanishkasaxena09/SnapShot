import 'package:flutter_riverpod/flutter_riverpod.dart';

class IdSetNotifier extends StateNotifier<List<String>> {
  IdSetNotifier([List<String> initial = const [], this.maxSize])
      : super(initial.toList());

  final int? maxSize;

  void toggle(String id) {
    if (state.contains(id)) {
      state = state.where((item) => item != id).toList();
    } else if (maxSize == null || state.length < maxSize!) {
      state = [...state, id];
    }
  }

  bool contains(String id) => state.contains(id);

  void clear() => state = [];
}
