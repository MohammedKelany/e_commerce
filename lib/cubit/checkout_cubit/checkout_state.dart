part of 'checkout_cubit.dart';

@immutable
abstract class CheckoutStates {}

class CheckoutInitial extends CheckoutStates {}

class CheckoutNextStepState extends CheckoutStates {}

class CheckoutPreviousStepState extends CheckoutStates {}

class CheckoutChangeDeliveryState extends CheckoutStates {}

class CheckoutSendOrderSuccessState extends CheckoutStates {}

class CheckoutSuccessState extends CheckoutStates {}
class CheckoutLoadingState extends CheckoutStates {}

class CheckoutSendOrderErrorState extends CheckoutStates {}
