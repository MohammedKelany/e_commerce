import 'package:e_commerce/model/order_model.dart';
import 'package:e_commerce/view/profile/delivery_track.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';
import 'custom_text.dart';
import 'divider_vertical.dart';

class OrderHistoryItem extends StatelessWidget {
  const OrderHistoryItem({Key? key, required this.order}) : super(key: key);
  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OrderTrack(order: order,),
              ));
      },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            CustomText(text: order.time!, size: 14, color: Colors.grey),
            ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                    text: order.orderProducts![index].name!,
                                    size: 14),
                                CustomText(
                                  text:
                                      "\$ ${order.orderProducts![index].price!}",
                                  size: 14,
                                  color: primaryColor,
                                ),
                                const DividerV(height: 10),
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: order.status! == "In Transit"
                                        ? Colors.amberAccent
                                        : primaryColor,
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                  child: CustomText(
                                    text: order.status!,
                                    size: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  order.orderProducts![index].image!,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.fill,
                                )),
                          ],
                        ),
                      ),
                    ),
                separatorBuilder: (context, index) => const DividerV(height: 10),
                itemCount: order.orderProducts!.length),
          ],
        ),
      ),
    );
  }
}
