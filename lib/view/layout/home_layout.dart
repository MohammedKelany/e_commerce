import 'package:e_commerce/cubit/home_cubit/home_cubit.dart';
import 'package:e_commerce/shared/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          toolbarHeight: 25,
        ),
        body: context
            .read<HomeCubit>()
            .screens[context.read<HomeCubit>().currentScreen],
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: primaryColor,
          items: context.read<HomeCubit>().bottomNavigationBarItems,
          currentIndex: context.read<HomeCubit>().currentScreen,
          onTap: (index) {
            context.read<HomeCubit>().changeScreen(index);
          },
        ),
      ),
    );
  }
}
