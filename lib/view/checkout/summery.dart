import 'package:e_commerce/cubit/cart_cubit/cart_cubit.dart';
import 'package:e_commerce/cubit/checkout_cubit/checkout_cubit.dart';
import 'package:e_commerce/shared/component/divider_horizontal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/component/custom_text.dart';
import '../../shared/component/divider_vertical.dart';
import '../../shared/constants/constants.dart';

class SummeryScreen extends StatelessWidget {
  const SummeryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartStates>(
      builder: (context, state) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 220,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => SizedBox(
                height: 150,
                child: Column(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          context.read<CartCubit>().cartProducts[index].image!,
                          fit: BoxFit.fill,
                          width: 150,
                          height: 150,
                        )),
                    const DividerV(height: 10),
                    CustomText(
                        text:
                            context.read<CartCubit>().cartProducts[index].name!,
                        size: 16),
                    CustomText(
                      text:
                          "\$ ${context.read<CartCubit>().cartProducts[index].price!}",
                      size: 18,
                      color: primaryColor,
                    ),
                  ],
                ),
              ),
              separatorBuilder: (context, index) => const DividerH(width: 10),
              itemCount: context.read<CartCubit>().cartProducts.length,
            ),
          ),
          const DividerV(height: 10),
          const CustomText(text: "Shipping Address ", size: 18),
          const DividerV(height: 20),
          CustomText(
            text: "${context.read<CheckoutCubit>().street1Controller.text}"
                ", ${context.read<CheckoutCubit>().street2Controller.text}"
                ", ${context.read<CheckoutCubit>().cityController.text}"
                ", ${context.read<CheckoutCubit>().stateController.text}"
                ", ${context.read<CheckoutCubit>().countryController.text}",
            size: 15,
          ),
          TextButton(
            onPressed: () {
              context.read<CheckoutCubit>().changeOrderData();
            },
            child: const Text(
              "Change",
              style: TextStyle(color: primaryColor),
            ),
          )
        ],
      ),
    );
  }
}
