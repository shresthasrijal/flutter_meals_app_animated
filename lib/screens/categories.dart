import 'package:flutter/material.dart';
import 'package:proj8_meals_app_animated/data/dummy_data.dart';
import 'package:proj8_meals_app_animated/models/meal.dart';
import 'package:proj8_meals_app_animated/widgets/category_grid_item.dart';
import 'package:proj8_meals_app_animated/screens/meals.dart';
import 'package:proj8_meals_app_animated/models/category.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({
    super.key,
    required this.availableMeals,
  });

  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationControler;

  @override
  void initState() {
    super.initState();

    _animationControler = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
      lowerBound: 0,
      upperBound: 1,
    );

    _animationControler.forward();
  }

  @override
  void dispose() {
    _animationControler.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationControler,
      child: GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          for (final category in availableCategories)
            CategoryGridItem(
              category: category,
              onSelectCategory: () {
                _selectCategory(context, category);
              },
            )
        ],
      ),
      builder: (context, child) => SlideTransition(
        // position: _animationControler.drive(Tween(
        //   begin: const Offset(-0.3, 0.3),
        //   end: const Offset(0, 0),
        // )),
        position: Tween(
          begin: const Offset(0.5, 0),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(
            parent: _animationControler,
            curve: Curves.easeInOut,
          ),
        ),
        child: child,
      ),
    );
  }
}
