import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/helper/cache/cache_helper.dart';
import 'package:e_commerce/model/user_model.dart';
import 'package:e_commerce/shared/constants/constants.dart';
import 'package:e_commerce/view/layout/home_layout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../view/login/login_screen.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitial());
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController loginEmail = TextEditingController();
  TextEditingController loginPassword = TextEditingController();
  TextEditingController signupEmail = TextEditingController();
  TextEditingController signupPassword = TextEditingController();
  TextEditingController signupUsername = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  //Sign in using Google
  Future<void> signInWithGoogle(context) async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((user1) async {
        await saveUserToFirestore(
          id: user1.user!.uid,
          name: user1.user!.displayName!,
          email: user1.user!.email!,
        );
        await CacheHelper.setData(key: "uid", value: user1.user!.uid);
        String? userJson = await CacheHelper.getData(key: "user");
        uid = user1.user!.uid;
        user = UserModel.fromJson(
          json.decode(userJson!),
        );
      });
      navigateToHome(context);
      emit(GoogleSignInSuccessState());
    } catch (e) {
      print(e.toString());
      emit(GoogleSignInErrorState());
    }
  }

  // Sign in with Facebook
  Future<void> signInWithFacebook(context) async {
    try {
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login();

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      // Once signed in, return the UserCredential
      await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential)
          .then((user1) async {
        await saveUserToFirestore(
          id: user1.user!.uid,
          name: user1.user!.displayName!,
          email: user1.user!.email!,
        );
        await CacheHelper.setData(key: "uid", value: user1.user!.uid);
        String? userJson = await CacheHelper.getData(key: "user");
        uid = user1.user!.uid;
        user = UserModel.fromJson(
          json.decode(userJson!),
        );
        navigateToHome(context);

        emit(FacebookSignInSuccessState());
      });
    } catch (e) {
      print(e.toString());
      emit(FacebookSignInErrorState());
    }
  }

  Future<void> signUpWithEmailAndPassword(context,
      {required String emailAddress, required String password}) async {
    try {
      emit(EmailSignUpLoadingState());
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      )
          .then(
        (user) {
          saveUserToFirestore(
            id: user.user!.uid,
            name: signupUsername.text,
            email: signupEmail.text,
          );
          Navigator.maybePop(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
          );
        },
      );
      emit(EmailSignUpSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      emit(EmailSignUpErrorState());
    } catch (e) {
      print(e);
      emit(EmailSignUpErrorState());
    }
  }

  Future<void> signInWithEmailAndPassword(context,
      {required String emailAddress, required String password}) async {
    try {
      emit(EmailSignInLoadingState());
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      await CacheHelper.setData(key: "uid", value: credential.user!.uid);
      navigateToHome(context);
      emit(EmailSignInSuccessState());
      String? userJson = await CacheHelper.getData(key: "user");
      uid = credential.user!.uid;
      user = UserModel.fromJson(
        json.decode(userJson!),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      emit(EmailSignInErrorState());
    } catch (e) {
      print(e);
      emit(EmailSignInErrorState());
    }
  }

  Future<void> saveUserToFirestore(
      {required String id, required String email, required String name}) async {
    UserModel model = UserModel(
      uId: id,
      email: email,
      username: name,
    );
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(id)
        .set(model.toJson());
    await CacheHelper.setData(key: "user", value: json.encode(model.toJson()));
  }

  Future<void> signOut(context) async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
    await FacebookAuth.instance.logOut();
    CacheHelper.remove("uid");
    CacheHelper.remove("user");
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
      (route) => false,
    );
    emit(SignOutState());
  }

  void navigateToHome(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeLayout(),
        ),
        (route) => false);
  }
}
