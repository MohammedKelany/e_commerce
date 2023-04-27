import 'package:e_commerce/shared/component/custom_button.dart';
import 'package:e_commerce/shared/component/custom_text.dart';
import 'package:e_commerce/shared/component/custom_under_bordered_text_field.dart';
import 'package:e_commerce/shared/component/divider_vertical.dart';
import 'package:e_commerce/shared/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/profile_cubit/profile_cubit.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocConsumer<ProfileCubit, ProfileStates>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            context.read<ProfileCubit>().usernameController.text =
                user!.username!;
            context.read<ProfileCubit>().emailController.text = user!.email!;
            return CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Form(
                    key: context.read<ProfileCubit>().updateFormKey,
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 62,
                              backgroundColor: Colors.black12,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: user?.image == null
                                    ? const AssetImage(
                                            "assets/images/Avatar.png")
                                        as ImageProvider
                                    : NetworkImage(user!.image!),
                              ),
                            ),
                            CircleAvatar(
                              radius: 23,
                              backgroundColor: primaryColor.withOpacity(.5),
                              child: IconButton(
                                icon: const Icon(Icons.camera_alt_outlined,
                                    color: Colors.white, size: 30),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const CustomText(
                                            text: "Choose By What", size: 16),
                                        content: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            CustomButton(
                                                text: "By Camera",
                                                onPressed: () {
                                                  context
                                                      .read<ProfileCubit>()
                                                      .getCameraImage();
                                                },
                                                color: Colors.white,
                                                textColor: Colors.black,
                                                width: 100),
                                            CustomButton(
                                              text: "By Gallery",
                                              onPressed: () {
                                                context
                                                    .read<ProfileCubit>()
                                                    .getGalleryImage();
                                              },
                                              color: primaryColor,
                                              textColor: Colors.white,
                                              width: 100,
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        const DividerV(height: 50),
                        CustomUnderTextFormField(
                          hint: "UserName",
                          fieldHint: "Mohammed Fathy",
                          inputType: TextInputType.name,
                          controller:
                              context.read<ProfileCubit>().usernameController,
                        ),
                        const DividerV(height: 30),
                        CustomUnderTextFormField(
                            hint: "Email",
                            fieldHint: "Mohammed Fathy",
                            inputType: TextInputType.emailAddress,
                            controller:
                                context.read<ProfileCubit>().emailController),
                        const Spacer(),
                        CustomButton(
                          text: "Update",
                          onPressed: () {},
                          color: primaryColor,
                          textColor: Colors.white,
                          width: 100,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
