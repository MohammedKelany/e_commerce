part of 'auth_cubit.dart';

@immutable
abstract class AuthStates {}

class AuthInitial extends AuthStates {}

class GoogleSignInSuccessState extends AuthStates {}

class GoogleSignInErrorState extends AuthStates {}

class FacebookSignInSuccessState extends AuthStates {}

class FacebookSignInErrorState extends AuthStates {}

class EmailSignInSuccessState extends AuthStates {}

class EmailSignInErrorState extends AuthStates {}

class EmailSignUpSuccessState extends AuthStates {}

class EmailSignInLoadingState extends AuthStates {}

class EmailSignUpLoadingState extends AuthStates {}

class EmailSignUpErrorState extends AuthStates {}

class SignOutState extends AuthStates {}
