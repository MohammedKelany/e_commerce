import 'package:e_commerce/model/product_model.dart';
import 'package:e_commerce/shared/constants/constants.dart';
import 'package:e_commerce/view/product_detail/product_detail.dart';
import 'package:flutter/material.dart';

import 'custom_text.dart';
import 'divider_vertical.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key? key,
    required this.model,
  }) : super(key: key);
  final ProductModel model;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(
              model: model,
            ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag:model.image!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                model.image!,
                fit: BoxFit.cover,
                height: 230,
              ),
            ),
          ),
          const DividerV(height: 10),
          CustomText(
            text: model.name!,
            size: 16,
          ),
          CustomText(
            text: model.brand!,
            size: 14,
            color: Colors.black26,
          ),
          const DividerV(height: 3),
          CustomText(
            text: "\$${model.price!}",
            size: 14,
            color: primaryColor,
          ),
        ],
      ),
    );
  }
}
