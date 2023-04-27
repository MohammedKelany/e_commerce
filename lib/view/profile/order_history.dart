import 'package:e_commerce/shared/component/divider_vertical.dart';
import 'package:e_commerce/shared/component/order_history_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/profile_cubit/profile_cubit.dart';

class OrderHistory extends StatelessWidget {
  const OrderHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Track Order"),
        centerTitle: true,
      ),
      body: Padding(
          padding: const EdgeInsets.all(5.0),
          child: BlocConsumer<ProfileCubit, ProfileStates>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) => ListView.separated(
              itemBuilder: (context, index) => OrderHistoryItem(
                  order: context.read<ProfileCubit>().orders[index]),
              separatorBuilder: (context, index) => const DividerV(height: 10),
              itemCount: context.read<ProfileCubit>().orders.length,
            ),
          ),),
    );
  }
}
