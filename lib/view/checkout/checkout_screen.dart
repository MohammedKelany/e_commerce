import 'package:another_stepper/another_stepper.dart';
import 'package:e_commerce/cubit/cart_cubit/cart_cubit.dart';
import 'package:e_commerce/cubit/checkout_cubit/checkout_cubit.dart';
import 'package:e_commerce/shared/component/custom_button.dart';
import 'package:e_commerce/shared/component/divider_horizontal.dart';
import 'package:e_commerce/shared/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/home_cubit/home_cubit.dart';
import '../../shared/component/custom_toast.dart';
import '../layout/home_layout.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Checkout",
        ),
        centerTitle: true,
      ),
      body: Center(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: BlocConsumer<CheckoutCubit, CheckoutStates>(
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        AnotherStepper(
                          stepperList:
                              context.read<CheckoutCubit>().stepperData,
                          stepperDirection: Axis.horizontal,
                          activeIndex: context.read<CheckoutCubit>().activeStep,
                          activeBarColor: primaryColor,
                          scrollPhysics: const NeverScrollableScrollPhysics(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 40.0),
                          child: context
                              .read<CheckoutCubit>()
                              .steps[context.read<CheckoutCubit>().activeStep],
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment:
                              context.read<CheckoutCubit>().activeStep == 0
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.spaceAround,
                          children: [
                            if (context.read<CheckoutCubit>().activeStep != 0)
                              OutlinedButton(
                                onPressed: () {
                                  context.read<CheckoutCubit>().previousStep();
                                },
                                style: ButtonStyle(
                                  foregroundColor:
                                      const MaterialStatePropertyAll(
                                          Colors.black),
                                  shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  side: const MaterialStatePropertyAll(
                                      BorderSide(color: primaryColor)),
                                  minimumSize: const MaterialStatePropertyAll(
                                    Size(150, 50),
                                  ),
                                ),
                                child: const Text("BACK"),
                              ),
                            CustomButton(
                              text: "NEXT",
                              onPressed: () {
                                context.read<CheckoutCubit>().nextStep(
                                      currentScreen: context
                                          .read<HomeCubit>()
                                          .currentScreen = 0,
                                      context,
                                      cartProducts: context
                                          .read<CartCubit>()
                                          .cartProducts,
                                      deleteCart:(){
                                        context
                                            .read<CartCubit>()
                                            .deleteAllProducts();
                                      }
                                    );
                              },
                              color: primaryColor,
                              textColor: Colors.white,
                              width: 150,
                            ),
                            if (context.read<CheckoutCubit>().activeStep == 0)
                              const DividerH(width: 10),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
