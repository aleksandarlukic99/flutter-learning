import 'package:flutter/material.dart';
import 'package:fooderlich3/api/mock_fooderlich_service.dart';
import 'package:fooderlich3/components/today_recipe_list_view.dart';

class ExploreScreen extends StatelessWidget {
  final mockService = MockFooderlichService();
  ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: mockService.getExploreData(),
      builder: (context, snapshot) {
        //TODO: Add Nested List View
        if (snapshot.connectionState == ConnectionState.done) {
          final recipes = snapshot.data?.todayRecipes ?? [];
          return TodayRecipeListView(recipes: recipes);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
