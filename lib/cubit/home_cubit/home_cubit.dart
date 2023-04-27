import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/model/product_model.dart';
import 'package:e_commerce/shared/constants/constants.dart';
import 'package:e_commerce/view/cart/cart_screen.dart';
import 'package:e_commerce/view/home/home_screen.dart';
import 'package:e_commerce/view/profile/profile_screen.dart';
import 'package:flutter/material.dart';

import '../../model/category_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitial());
  List<Widget> screens = [
    const HomeScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];
  List<BottomNavigationBarItem> bottomNavigationBarItems = [
    BottomNavigationBarItem(
        icon: Image.asset(
          "assets/images/Icon_Explore.png",
          height: 15,
        ),
        label: "Home"),
    BottomNavigationBarItem(
        icon: Image.asset(
          "assets/images/Icon_Cart.png",
          height: 15,
        ),
        label: "Cart"),
    BottomNavigationBarItem(
      icon: Image.asset(
        "assets/images/Icon_User.png",
        height: 15,
      ),
      label: "Profile",
    ),
  ];
  int currentScreen = 0;
  List<CategoryModel> categories = [];
  List<ProductModel> products = [];

  void changeScreen(int index) {
    currentScreen = index;
    emit(ChangeScreenState());
  }

  void getCategories() {
    categories = [];
    FirebaseFirestore.instance.collection("Categories").get().then((value) {
      emit(GetCategoriesLoadingState());
      value.docs.forEach((element) {
        categories.add(CategoryModel.fromJson(element.data()));
      });
      emit(GetCategoriesSuccessState());
    }).catchError((error) {
      emit(GetCategoriesErrorState());
    });
  }

  void getProducts() {
    products = [];
    FirebaseFirestore.instance.collection("Products").get().then((value) {
      emit(GetProductsLoadingState());
      value.docs.forEach((element) {
        products.add(ProductModel.fromJson(element.data()));
      });
      emit(GetProductsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetProductsErrorState());
    });
  }
}
