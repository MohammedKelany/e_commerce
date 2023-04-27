import 'package:e_commerce/model/cart_product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../constants/constants.dart';
import 'custom_text.dart';
import 'divider_horizontal.dart';
import 'divider_vertical.dart';

class CartProductItem extends StatelessWidget {
  const CartProductItem({
    Key? key,
    required this.model,
    required this.delete,
    required this.star,
    required this.increase,
    required this.decrease,
  }) : super(key: key);
  final CartProductModel model;
  final Function delete, star, increase, decrease;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: Key(model.productId!),
      startActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            borderRadius: BorderRadius.circular(10),
            onPressed: (context) {
              star();
            },
            backgroundColor: Colors.amberAccent,
            icon: Icons.star,
            foregroundColor: Colors.white,
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            borderRadius: BorderRadius.circular(10),
            onPressed: (context) {
              delete();
            },
            backgroundColor: Colors.red,
            icon: Icons.delete,
          ),
        ],
      ),
      child: SizedBox(
        height: 150,
        child: Row(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  model.image!,
                  fit: BoxFit.fill,
                  width: 150,
                )),
            const DividerH(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(text: model.name!, size: 16),
                const DividerV(height: 5),
                CustomText(
                  text: "\$ ${model.price!}",
                  size: 18,
                  color: primaryColor,
                ),
                const DividerV(height: 15),
                Container(
                  width: 150,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade200,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          increase();
                        },
                        icon: const Icon(
                          Icons.add,
                        ),
                      ),
                      CustomText(
                        text: model.quantity!.toString(),
                        size: 18,
                      ),
                      IconButton(
                        style: const ButtonStyle(
                          padding: MaterialStatePropertyAll(
                            EdgeInsets.only(
                              bottom: 10,
                            ),
                          ),
                        ),
                        onPressed: () {
                          decrease();
                        },
                        icon: const Icon(Icons.minimize),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
