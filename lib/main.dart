import 'dart:convert';

import 'package:e_commerce/cubit/auth_cubit/auth_cubit.dart';
import 'package:e_commerce/cubit/cart_cubit/cart_cubit.dart';
import 'package:e_commerce/cubit/checkout_cubit/checkout_cubit.dart';
import 'package:e_commerce/helper/cache/cache_helper.dart';
import 'package:e_commerce/helper/db/local_database_helper.dart';
import 'package:e_commerce/model/user_model.dart';
import 'package:e_commerce/shared/constants/constants.dart';
import 'package:e_commerce/view/layout/home_layout.dart';
import 'package:e_commerce/view/login/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'cubit/home_cubit/home_cubit.dart';
import 'cubit/observer/observer.dart';
import 'cubit/profile_cubit/profile_cubit.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      "pk_test_51N1GipCxJfAPp9Wp4HjS78z3TVqo5PkANhOAo4xHHM0IxKnthnBrWel2KdHUqHREHShJqdVRMTtMLOVoItu5RfV300Y18A2AWv";
  Bloc.observer = Observer();
  await CacheHelper.init();
  await DBHelper.init();
  uid = await CacheHelper.getData(key: "uid");
  String? userJson = await CacheHelper.getData(key: "user");
  if (userJson != null) {
    user = UserModel.fromJson(json.decode(userJson));
  }
  print(user);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => HomeCubit()
            ..getCategories()
            ..getProducts(),
        ),
        BlocProvider(
          create: (context) => CartCubit()..getCartProducts(),
        ),
        BlocProvider(
          create: (context) => CheckoutCubit(),
        ),
        BlocProvider(
          create: (context) => ProfileCubit()..getOrders(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: "San",
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: primaryColor,
            surfaceTint: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        home: uid == null ? const LoginScreen() : const HomeLayout(),
      ),
    );
  }
}
