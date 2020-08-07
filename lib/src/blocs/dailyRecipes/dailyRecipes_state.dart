import 'package:equatable/equatable.dart';
import 'package:recipes/src/models/recipe.dart';

abstract class DailyRecipesState extends Equatable {
  const DailyRecipesState();

  @override
  List<Object> get props => [];
}

class RecipesInitial extends DailyRecipesState {}

class RecipesLoadInProgress extends DailyRecipesState {}

class RecipesLoadSuccess extends DailyRecipesState {
  final List<Recipe> recipes;

//  RecipesLoadSuccess(this.recipes);


  const RecipesLoadSuccess([this.recipes = const []]);

  @override
  List<Object> get props => recipes;

//  @override
//  String toString() => 'TodosLoadSuccess { recipes: $recipes }';
}

class RecipesLoadFailure extends DailyRecipesState {}
