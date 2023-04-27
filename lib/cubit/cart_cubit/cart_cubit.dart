import 'package:bloc/bloc.dart';
import 'package:e_commerce/helper/db/local_database_helper.dart';
import 'package:e_commerce/shared/component/custom_toast.dart';
import 'package:flutter/material.dart';

import '../../model/cart_product_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartStates> {
  CartCubit() : super(CartInitial());

  List<CartProductModel> cartProducts = [];
  int totalPrice = 0;
  bool loading = false;

  void addProductToCart(CartProductModel model) {
    for (int i = 0; i < cartProducts.length; i++) {
      if (cartProducts[i].productId == model.productId) {
        showToast(
          text: "The Item is already Exists",
          state: ToastStates.EDIT,
        );
        return;
      }
    }
    DBHelper.addProduct(model).then((value) {
      showToast(
        text: "The Item is Added Successfully",
        state: ToastStates.SUCCESS,
      );
      emit(AddCartProductSuccessState());
      getCartProducts();
    }).catchError((error) {
      emit(AddCartProductErrorState());
    });
  }

  void getCartProducts() {
    cartProducts = [];
    loading = true;
    emit(GetCartProductsLoadingState());
    DBHelper.getAllProducts().then((value) {
      print(value);
      value.forEach((element) {
        cartProducts.add(CartProductModel.fromJson(element));
      });
      loading = false;
      calculatingTotalPrice();
      emit(GetCartProductsSuccessState());
      print("products $cartProducts");
    }).catchError((error) {
      print(error.toString());
      loading = false;
      emit(GetCartProductsErrorState());
    });
  }

  void deleteCartProduct({required CartProductModel model}) {
    DBHelper.deleteProduct(id: model.id!).then(
      (value) {
        cartProducts.remove(model);
        calculatingTotalPrice();
        showToast(text: "Deleted Successfully", state: ToastStates.SUCCESS);
        emit(DeleteCartProductSuccessState());
      },
    ).catchError(
      (error) {
        print(error);
        emit(DeleteCartProductErrorState());
      },
    );
  }

  void deleteAllProducts() {
    cartProducts = [];
    DBHelper.deleteCart().then(
      (value) {
        emit(DeleteCartProductSuccessState());
      },
    ).catchError(
      (error) {
        print(error);
        emit(DeleteCartProductErrorState());
      },
    );
  }

  void increaseQuantity({required CartProductModel model}) {
    model.quantity = model.quantity! + 1;
    calculatingTotalPrice();
    emit(IncreaseCartProductSuccessState());
  }

  void decreaseQuantity({required CartProductModel model}) {
    if (model.quantity! > 1) {
      model.quantity = model.quantity! - 1;
      calculatingTotalPrice();
      emit(DecreaseCartProductSuccessState());
    }
  }

  void calculatingTotalPrice() {
    totalPrice = 0;
    cartProducts.forEach((element) {
      totalPrice += element.quantity! * int.parse(element.price!);
    });
  }
}
