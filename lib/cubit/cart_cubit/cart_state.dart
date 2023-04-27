part of 'cart_cubit.dart';

@immutable
abstract class CartStates {}

class CartInitial extends CartStates {}

class AddCartProductSuccessState extends CartStates {}

class AddCartProductErrorState extends CartStates {}

class GetCartProductsLoadingState extends CartStates {}

class GetCartProductsSuccessState extends CartStates {}

class GetCartProductsErrorState extends CartStates {}

class DeleteCartProductSuccessState extends CartStates {}

class DeleteCartProductErrorState extends CartStates {}

class IncreaseCartProductSuccessState extends CartStates {}

class DecreaseCartProductSuccessState extends CartStates {}
