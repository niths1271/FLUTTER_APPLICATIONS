import 'package:flutter/material.dart';
import 'package:flutter_appmealsapp/widgets/meal_item.dart';
import '../widgets/meal_item.dart';
import '../models/meals.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = './category-meals';
  final List<Meal> availableMeals;
  CategoryMealsScreen(this.availableMeals);
  @override
  CategoryMealsScreen_State createState() => CategoryMealsScreen_State();
}

class CategoryMealsScreen_State extends State<CategoryMealsScreen> {
  /*final String categoryid;
  final String categorytitle;
  CategoryMealsScreen(this.categoryid, this.categorytitle);*/
  String categoryTitle;
  List<Meal> displayedMeals;
  var _loadedinitdata = false;
  @override
  void didChangeDependencies() {
    if (!_loadedinitdata) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title'];
      final categoryId = routeArgs['id'];
      displayedMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      _loadedinitdata = true;
      super.didChangeDependencies();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: displayedMeals[index].id,
            affordability: displayedMeals[index].affordability,
            complexity: displayedMeals[index].complexity,
            duration: displayedMeals[index].duration,
            imageUrl: displayedMeals[index].title,
            title: displayedMeals[index].title,
          );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}
