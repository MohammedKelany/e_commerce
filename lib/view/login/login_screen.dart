import 'package:e_commerce/cubit/auth_cubit/auth_cubit.dart';
import 'package:e_commerce/shared/component/custom_text.dart';
import 'package:e_commerce/shared/component/custom_under_bordered_text_field.dart';
import 'package:e_commerce/shared/component/divider_vertical.dart';
import 'package:e_commerce/shared/component/social_auth_button.dart';
import 'package:e_commerce/shared/constants/constants.dart';
import 'package:e_commerce/view/signup/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/component/custom_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocConsumer<AuthCubit, AuthStates>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) => Form(
              key: context.read<AuthCubit>().loginFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustomText(
                        text: "Welcome,",
                        size: 30,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpScreen(),
                            ),
                          );
                        },
                        child: const CustomText(
                          text: "Sign Up",
                          size: 16,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  const DividerV(height: 10),
                  const CustomText(
                    text: "Sign in to Continue",
                    size: 14,
                    color: Colors.black26,
                  ),
                  const DividerV(height: 30),
                  CustomUnderTextFormField(
                    hint: "Email",
                    controller: context.read<AuthCubit>().loginEmail,
                    fieldHint: "www.mohammed@gmail.com",
                    inputType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return "Email Can't be Empty";
                      } else if (!value.toString().contains("@")) {
                        return "The Email Must Contain @ sign";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const DividerV(height: 20),
                  CustomUnderTextFormField(
                    hint: "Password",
                    controller: context.read<AuthCubit>().loginPassword,
                    fieldHint: "**************",
                    inputType: TextInputType.visiblePassword,
                    isPass: true,
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return "Password Can't be Empty";
                      } else if (value.toString().length < 6) {
                        return "The Password Must Contain at Least 6 characters ";
                      } else {
                        return null;
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          print("hhhhh");
                        },
                        child: const CustomText(
                          text: "Forgot Password?",
                          size: 14,
                        ),
                      ),
                    ],
                  ),
                  state is EmailSignInLoadingState
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        )
                      : CustomButton(
                    width: double.infinity,
                          onPressed: () {
                            if (context
                                .read<AuthCubit>()
                                .loginFormKey
                                .currentState!
                                .validate()) {
                              context
                                  .read<AuthCubit>()
                                  .signInWithEmailAndPassword(
                                    context,
                                    emailAddress: context
                                        .read<AuthCubit>()
                                        .loginEmail
                                        .text,
                                    password: context
                                        .read<AuthCubit>()
                                        .loginPassword
                                        .text,
                                  );
                            }
                          },
                          text: "SIGN IN",
                          color: primaryColor,
                          textColor: Colors.white,
                        ),
                  const DividerV(height: 10),
                  const CustomText(
                    text: "-OR-",
                    size: 16,
                    align: Alignment.center,
                  ),
                  const DividerV(height: 5),
                  SocialAuthButton(
                    image: "assets/images/google.png",
                    text: "Sign In With Google",
                    onPressed: () {
                      context.read<AuthCubit>().signInWithGoogle(context);
                    },
                  ),
                  const DividerV(height: 10),
                  SocialAuthButton(
                    image: "assets/images/facebook.png",
                    text: "Sign In With Facebook",
                    onPressed: () {
                      context.read<AuthCubit>().signInWithFacebook(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
