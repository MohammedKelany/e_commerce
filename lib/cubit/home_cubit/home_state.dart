part of 'home_cubit.dart';

@immutable
abstract class HomeStates {}

class HomeInitial extends HomeStates {}

class GetCategoriesLoadingState extends HomeStates {}

class GetCategoriesSuccessState extends HomeStates {}

class GetCategoriesErrorState extends HomeStates {}

class GetProductsLoadingState extends HomeStates {}

class GetProductsSuccessState extends HomeStates {}

class GetProductsErrorState extends HomeStates {}

class ChangeScreenState extends HomeStates {}

