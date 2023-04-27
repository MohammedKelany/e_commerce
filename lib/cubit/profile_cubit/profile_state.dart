part of 'profile_cubit.dart';

@immutable
abstract class ProfileStates {}

class ProfileInitial extends ProfileStates {}

class GetOrderHistorySuccessState extends ProfileStates {}

class GetOrderHistoryErrorState extends ProfileStates {}

class UpdateProfileSuccessState extends ProfileStates {}

class UpdateProfileErrorState extends ProfileStates {}

class UpdateProfileImageSuccessState extends ProfileStates {}

class UpdateProfileImageErrorState extends ProfileStates {}
