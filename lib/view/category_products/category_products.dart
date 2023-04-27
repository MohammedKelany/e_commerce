import 'package:e_commerce/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../cubit/home_cubit/home_cubit.dart';
import '../../shared/component/product_item.dart';

class CategoryProductsScreen extends StatelessWidget {
  const CategoryProductsScreen({Key? key, required this.category})
      : super(key: key);
  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category.name!),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocListener<HomeCubit, HomeStates>(
          listener: (context, state) {
            // TODO: implement listener
          },
          child: AnimationLimiter(
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 1 / 2.1,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: List.generate(
                context.read<HomeCubit>().products.length,
                (int index) {
                  return AnimationConfiguration.staggeredGrid(
                    delay: const Duration(milliseconds: 400),
                    position: index,
                    duration: const Duration(milliseconds: 1000),
                    columnCount: 2,
                    child: SlideAnimation(
                      child: FadeInAnimation(
                        child: ProductItem(
                          model: context.read<HomeCubit>().products[index],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
