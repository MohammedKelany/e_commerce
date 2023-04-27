import 'package:flutter/material.dart';

import '../constants/constants.dart';
import 'custom_text.dart';

class ProfileListTile extends StatelessWidget {
  const ProfileListTile({
    Key? key,
    required this.image,
    required this.title,
    required this.destination,
    required this.onTap,
  }) : super(key: key);
  final String image, title;
  final Widget destination;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => destination,
            ));
        onTap();
      },
      leading: Container(
        height: 40,
        width: 40,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: primaryColor.withOpacity(.07),
          borderRadius: BorderRadius.circular(5),
          image: DecorationImage(
            image: AssetImage(
              "assets/images/$image.png",
            ),
          ),
        ),
      ),
      title: CustomText(
        text: title,
        size: 14,
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: Colors.black,
        size: 14,
      ),
    );
  }
}
