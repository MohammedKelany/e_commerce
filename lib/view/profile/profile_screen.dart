import 'package:e_commerce/cubit/auth_cubit/auth_cubit.dart';
import 'package:e_commerce/cubit/home_cubit/home_cubit.dart';
import 'package:e_commerce/shared/component/custom_text.dart';
import 'package:e_commerce/shared/component/divider_horizontal.dart';
import 'package:e_commerce/shared/component/divider_vertical.dart';
import 'package:e_commerce/shared/constants/constants.dart';
import 'package:e_commerce/view/profile/location.dart';
import 'package:e_commerce/view/profile/notifications.dart';
import 'package:e_commerce/view/profile/order_history.dart';
import 'package:e_commerce/view/profile/payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/profile_cubit/profile_cubit.dart';
import '../../shared/component/profile_list_tile.dart';
import 'edit_profile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        Row(
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage("assets/images/Avatar.png"),
            ),
            const DividerH(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text: user!.username!, size: 20),
                CustomText(
                  text: user!.email!,
                  size: 12,
                  color: Colors.grey.shade500,
                ),
              ],
            ),
          ],
        ),
        const DividerV(height: 30),
        BlocListener<ProfileCubit, ProfileStates>(
          listener: (context, state) {
            // TODO: implement listener
          },
          child: ProfileListTile(
            image: "Icon_Edit-Profile",
            title: "Edit Profile",
            destination: const EditProfile(),
            onTap: () {
              context.read<ProfileCubit>().getOrders();
            },
          ),
        ),
        ProfileListTile(
          image: "Icon_Location",
          title: "Shipping Address",
          destination: const ProfileLocation(),
          onTap: () {},
        ),
        ProfileListTile(
          image: "Icon_History",
          title: "Order History",
          destination: const OrderHistory(),
          onTap: () {},
        ),
        ProfileListTile(
          image: "Icon_Payment",
          title: "Cards",
          destination: const Payment(),
          onTap: () {},
        ),
        ProfileListTile(
          image: "Icon_Alert",
          title: "Notification",
          destination: const Notifications(),
          onTap: () {},
        ),
        ListTile(
          onTap: () {
            AuthCubit().signOut(context);
            context.read<HomeCubit>().currentScreen=0;
          },
          leading: Container(
            height: 40,
            width: 40,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(.05),
              borderRadius: BorderRadius.circular(5),
              image: const DecorationImage(
                image: AssetImage(
                  "assets/images/Icon_Exit.png",
                ),
              ),
            ),
          ),
          title: const CustomText(
            text: "Log Out",
            size: 14,
          ),
        )
      ]),
    );
  }
}
