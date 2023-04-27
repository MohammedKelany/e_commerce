import 'package:e_commerce/cubit/cart_cubit/cart_cubit.dart';
import 'package:e_commerce/cubit/home_cubit/home_cubit.dart';
import 'package:e_commerce/model/cart_product_model.dart';
import 'package:e_commerce/model/product_model.dart';
import 'package:e_commerce/shared/component/custom_text.dart';
import 'package:e_commerce/shared/component/divider_vertical.dart';
import 'package:e_commerce/shared/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/component/custom_button.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({Key? key, required this.model}) : super(key: key);
  final ProductModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                Hero(
                  tag: model.image!,
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Image.network(
                        model.image!,
                        height: MediaQuery.of(context).size.height * .4,
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 30.0, horizontal: 10),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(Icons.star_border),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(text: model.name!, size: 30),
                        const DividerV(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width * .45,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black26),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const CustomText(text: "Size", size: 14),
                                  CustomText(text: model.size!, size: 14),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width * .45,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black26),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const CustomText(text: "Color", size: 14),
                                  CircleAvatar(
                                    backgroundColor: model.color! == "Black"
                                        ? Colors.black
                                        : Colors.blue,
                                    radius: 10,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        const DividerV(height: 30),
                        const CustomText(text: "Details", size: 20),
                        CustomText(
                            text: model.description!, size: 14, height: 2),
                      ],
                    )).animate(effects: [
                  const FadeEffect(duration: Duration(milliseconds: 600)),
                  const MoveEffect(duration: Duration(milliseconds: 300))
                ]),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const CustomText(text: "Price", size: 16),
                          CustomText(
                            text: "\$${model.price!}",
                            size: 16,
                            color: primaryColor,
                          ),
                        ],
                      ),
                      BlocListener<CartCubit, CartStates>(
                        listener: (context, state) {
                          // TODO: implement listener
                        },
                        child: CustomButton(
                          color: primaryColor,
                          textColor: Colors.white,
                          text: "ADD",
                          onPressed: () {
                            CartProductModel cartProduct =
                                CartProductModel.fromJson(model.toJson());
                            cartProduct.quantity = 1;
                            context
                                .read<CartCubit>()
                                .addProductToCart(cartProduct);
                          },
                          width: 200,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
