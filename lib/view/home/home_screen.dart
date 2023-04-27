import 'package:e_commerce/cubit/home_cubit/home_cubit.dart';
import 'package:e_commerce/shared/component/custom_text.dart';
import 'package:e_commerce/shared/component/divider_vertical.dart';
import 'package:e_commerce/shared/component/product_item.dart';
import 'package:e_commerce/shared/constants/constants.dart';
import 'package:e_commerce/view/category_products/category_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../shared/component/divider_horizontal.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocConsumer<HomeCubit, HomeStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return context.read<HomeCubit>().products.isNotEmpty &&
                      context.read<HomeCubit>().categories.isNotEmpty
                  ? AnimationLimiter(
                      child: Column(
                        children: AnimationConfiguration.toStaggeredList(
                          delay: const Duration(milliseconds: 300),
                          duration: const Duration(milliseconds: 600),
                          childAnimationBuilder: (widget) => SlideAnimation(
                            horizontalOffset: 50.0,
                            child: FadeInAnimation(
                              child: widget,
                            ),
                          ),
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      prefixIcon: Image.asset(
                                        "assets/images/Icon_Search.png",
                                        height: 10,
                                      ),
                                      hintText: "Search..."),
                                )),
                            const DividerV(height: 10),
                            const CustomText(text: "Categories", size: 22),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: SizedBox(
                                height: 100,
                                child: ListView.separated(
                                  itemBuilder: (context, index) => InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CategoryProductsScreen(
                                            category: context
                                                .read<HomeCubit>()
                                                .categories[index],
                                          ),
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5.0, horizontal: 3),
                                      child: Column(
                                        children: [
                                          Container(
                                            width: 60,
                                            height: 60,
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black26,
                                                    offset: Offset(1, 1),
                                                    blurRadius: 3,
                                                    spreadRadius: 1),
                                              ],
                                            ),
                                            child: Image.network(
                                              context
                                                  .read<HomeCubit>()
                                                  .categories[index]
                                                  .image!,
                                            ),
                                          ),
                                          const DividerV(height: 8),
                                          CustomText(
                                            text: context
                                                .read<HomeCubit>()
                                                .categories[index]
                                                .name!,
                                            size: 14,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  separatorBuilder: (context, index) =>
                                      const DividerH(width: 10),
                                  itemCount: context
                                      .read<HomeCubit>()
                                      .categories
                                      .length,
                                  scrollDirection: Axis.horizontal,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                CustomText(text: "Best Selling", size: 20),
                                CustomText(text: "See more", size: 14),
                              ],
                            ),
                            const DividerV(height: 25),
                            GridView.count(
                              physics: const NeverScrollableScrollPhysics(),
                              crossAxisCount: 2,
                              shrinkWrap: true,
                              childAspectRatio: 1 / 2.1,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              children: List.generate(
                                context.read<HomeCubit>().products.length,
                                (index) => ProductItem(
                                  model:
                                      context.read<HomeCubit>().products[index],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : const CircularProgressIndicator(
                      color: primaryColor,
                    );
            },
          ),
        ),
      ),
    );
  }
}
