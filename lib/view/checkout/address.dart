import 'package:e_commerce/cubit/checkout_cubit/checkout_cubit.dart';
import 'package:e_commerce/shared/component/custom_under_bordered_text_field.dart';
import 'package:e_commerce/shared/component/divider_horizontal.dart';
import 'package:e_commerce/shared/component/divider_vertical.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/component/custom_text.dart';
import '../../shared/constants/constants.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<CheckoutCubit, CheckoutStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      child: Form(
        key: context.read<CheckoutCubit>().addressFormKey,
        child: Column(
          children: [
            Row(
              children: const [
                Icon(
                  Icons.check_circle,
                  color: primaryColor,
                ),
                DividerH(width: 5),
                CustomText(
                    text: "Billing address is the same as delivery address",
                    size: 14),
              ],
            ),
            const DividerV(height: 20),
            CustomUnderTextFormField(
              hint: "Street 1",
              fieldHint: "21, Alex Davidson Avenue",
              inputType: TextInputType.text,
              controller: context.read<CheckoutCubit>().street1Controller,
              validator: (value) {
                if (value.toString().isEmpty) {
                  return "Complete this field";
                }
                return null;
              },
            ),
            const DividerV(height: 20),
            CustomUnderTextFormField(
              hint: "Street 2",
              fieldHint: "Opposite Omegatron, Vicent Quarters",
              inputType: TextInputType.text,
              controller: context.read<CheckoutCubit>().street2Controller,
              validator: (value) {
                if (value.toString().isEmpty) {
                  return "Complete this field";
                }
                return null;
              },
            ),
            const DividerV(height: 20),
            CustomUnderTextFormField(
              hint: "City",
              fieldHint: "Victoria Island",
              inputType: TextInputType.text,
              controller: context.read<CheckoutCubit>().cityController,
              validator: (value) {
                if (value.toString().isEmpty) {
                  return "Complete this field";
                }
                return null;
              },
            ),
            const DividerV(height: 20),
            Row(
              children: [
                Expanded(
                  child: CustomUnderTextFormField(
                    hint: "State",
                    fieldHint: "Lagos State",
                    inputType: TextInputType.text,
                    controller: context.read<CheckoutCubit>().stateController,
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return "Complete this field";
                      }
                      return null;
                    },
                  ),
                ),
                const DividerH(width: 10),
                Expanded(
                  child: CustomUnderTextFormField(
                    hint: "Country",
                    fieldHint: "Nigeria",
                    inputType: TextInputType.text,
                    controller: context.read<CheckoutCubit>().countryController,
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return "Complete this field";
                      }
                      return null;
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
