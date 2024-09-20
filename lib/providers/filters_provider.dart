import 'package:flutter_meal_app/providers/meals_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Filters {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FilterNotifier extends StateNotifier<Map<Filters, bool>> {
  FilterNotifier()
      : super({
          Filters.glutenFree: false,
          Filters.lactoseFree: false,
          Filters.vegetarian: false,
          Filters.vegan: false,
        });

  void setFilters(Map<Filters, bool> chosenFilters) {
    state = chosenFilters;
  }

  void setFilter(Filters filter, bool isActive) {
    state = {...state, filter: isActive};
  }
}

final filtersProvider =
    StateNotifierProvider<FilterNotifier, Map<Filters, bool>>(
  (ref) => FilterNotifier(),
);

final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filtersProvider);

  return meals.where((meal) {
    if (activeFilters[Filters.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (activeFilters[Filters.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (activeFilters[Filters.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    if (activeFilters[Filters.vegan]! && !meal.isVegan) {
      return false;
    }

    return true;
  }).toList();
});
