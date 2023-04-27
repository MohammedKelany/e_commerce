import 'package:e_commerce/shared/component/custom_text.dart';
import 'package:e_commerce/shared/component/divider_vertical.dart';
import 'package:e_commerce/shared/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/checkout_cubit/checkout_cubit.dart';

class DeliveryScreen extends StatelessWidget {
  const DeliveryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutCubit, CheckoutStates>(
      builder: (context, state) => Column(
        children: [
          const DividerV(height: 40),
          RadioListTile<DeliveryStates>(
              value: DeliveryStates.standard,
              groupValue: context.read<CheckoutCubit>().currentDeliveryState,
              onChanged: (DeliveryStates? value) {
                context
                    .read<CheckoutCubit>()
                    .changeDeliveryState(state: value!);
              },
              activeColor: primaryColor,
              title: const CustomText(text: "Standard Delivery", size: 18),
              subtitle: const CustomText(
                size: 14,
                text: "Order will be delivered between 3 - 5 business days",
              )),
          const DividerV(height: 40),
          RadioListTile<DeliveryStates>(
              value: DeliveryStates.nextDay,
              groupValue: context.read<CheckoutCubit>().currentDeliveryState,
              onChanged: (value) {
                context
                    .read<CheckoutCubit>()
                    .changeDeliveryState(state: value!);
              },
              activeColor: primaryColor,
              title: const CustomText(text: "Next Day Delivery", size: 18),
              subtitle: const CustomText(
                size: 14,
                text:
                    "Place your order before 6pm and your items will be delivered the next day",
              )),
          const DividerV(height: 40),
          RadioListTile<DeliveryStates>(
              value: DeliveryStates.nominated,
              groupValue: context.read<CheckoutCubit>().currentDeliveryState,
              onChanged: (value) {
                context
                    .read<CheckoutCubit>()
                    .changeDeliveryState(state: value!);
              },
              activeColor: primaryColor,
              title: const CustomText(text: "Nominated Delivery", size: 18),
              subtitle: const CustomText(
                size: 14,
                text: "Order will be delivered between 3 - 5 business days",
              )),
        ],
      ),
    );
  }
}
