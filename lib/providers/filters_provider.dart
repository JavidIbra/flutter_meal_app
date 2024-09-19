import 'package:flutter_meal_app/screens/filters.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Filters {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FilterNotifier extends StateNotifier<Map<Filters, bool>> {}

final filtersProvider = StateNotifierProvider((ref) => null);
