import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:proj8_meals_app_animated/data/dummy_data.dart';

final mealsProvider = Provider((ref) {
  return dummyMeals;
});