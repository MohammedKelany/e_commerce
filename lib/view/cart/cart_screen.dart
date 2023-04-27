import 'package:e_commerce/cubit/cart_cubit/cart_cubit.dart';
import 'package:e_commerce/shared/component/cart_product_item.dart';
import 'package:e_commerce/shared/component/custom_button.dart';
import 'package:e_commerce/shared/component/custom_text.dart';
import 'package:e_commerce/shared/component/divider_vertical.dart';
import 'package:e_commerce/shared/constants/constants.dart';
import 'package:e_commerce/view/checkout/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) => context.read<CartCubit>().loading
          ? const Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            )
          : context.read<CartCubit>().cartProducts.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/images/cart_empty.svg",
                        height: 200,
                      ),
                      const DividerV(height: 20),
                      const CustomText(
                        text: "The Cart is Empty",
                        size: 20,
                        align: Alignment.center,
                        color: Colors.black54,
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.separated(
                            itemBuilder: (context, index) => CartProductItem(
                                  model: context
                                      .read<CartCubit>()
                                      .cartProducts[index],
                                  delete: () {
                                    context.read<CartCubit>().deleteCartProduct(
                                          model: context
                                              .read<CartCubit>()
                                              .cartProducts[index],
                                        );
                                  },
                                  star: () {},
                                  increase: () {
                                    context.read<CartCubit>().increaseQuantity(
                                          model: context
                                              .read<CartCubit>()
                                              .cartProducts[index],
                                        );
                                  },
                                  decrease: () {
                                    context.read<CartCubit>().decreaseQuantity(
                                          model: context
                                              .read<CartCubit>()
                                              .cartProducts[index],
                                        );
                                  },
                                ),
                            separatorBuilder: (context, index) =>
                                const DividerV(height: 10),
                            itemCount:
                                context.read<CartCubit>().cartProducts.length),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              const CustomText(text: "Total", size: 18),
                              CustomText(
                                text:
                                    "\$${context.read<CartCubit>().totalPrice}",
                                size: 18,
                                color: primaryColor,
                              ),
                            ],
                          ),
                          CustomButton(
                            text: "CHECKOUT",
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CheckoutScreen(),
                                ),
                              );
                            },
                            color: primaryColor,
                            textColor: Colors.white,
                            width: 200,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
    );
  }
}
