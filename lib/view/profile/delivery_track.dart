import 'package:another_stepper/another_stepper.dart';
import 'package:e_commerce/cubit/profile_cubit/profile_cubit.dart';
import 'package:e_commerce/model/order_model.dart';
import 'package:e_commerce/shared/component/custom_text.dart';
import 'package:e_commerce/shared/component/divider_vertical.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/constants/constants.dart';

class OrderTrack extends StatelessWidget {
  const OrderTrack({Key? key, required this.order}) : super(key: key);
  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Track"),
        centerTitle: true,
      ),
      body: BlocListener<ProfileCubit, ProfileStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        child: Padding(
          padding:
              EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.2),
          child: Row(
            children: [
              AnotherStepper(
                stepperList: context.read<ProfileCubit>().data,
                stepperDirection: Axis.vertical,
                activeIndex: 4,
                verticalGap: MediaQuery.of(context).size.height * 0.07,
                activeBarColor: primaryColor,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.08, left: 30),
                  child: Column(
                    children: [
                      Expanded(
                        child: Column(
                          children: const [
                            CustomText(text: "Order Processed", size: 20),
                            DividerV(height: 5),
                            CustomText(
                              text: "Lagos State, Nigeria",
                              size: 16,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: const [
                            CustomText(text: "Order Processed", size: 20),
                            DividerV(height: 5),
                            CustomText(
                              text: "Lagos State, Nigeria",
                              size: 16,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: const [
                            CustomText(text: "Shipping", size: 20),
                            DividerV(height: 5),
                            CustomText(
                              text: "Lagos State, Nigeria",
                              size: 16,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: const [
                            CustomText(text: "Out For Delivery", size: 20),
                            DividerV(height: 5),
                            CustomText(
                              text: "Lagos State, Nigeria",
                              size: 16,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: const [
                            CustomText(text: "Delivered", size: 20),
                            DividerV(height: 5),
                            CustomText(
                              text: "Lagos State, Nigeria",
                              size: 16,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
