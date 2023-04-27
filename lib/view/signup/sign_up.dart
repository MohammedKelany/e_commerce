import 'package:e_commerce/cubit/auth_cubit/auth_cubit.dart';
import 'package:e_commerce/shared/component/custom_button.dart';
import 'package:e_commerce/shared/component/custom_text.dart';
import 'package:e_commerce/shared/component/custom_under_bordered_text_field.dart';
import 'package:e_commerce/shared/component/divider_vertical.dart';
import 'package:e_commerce/shared/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

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
              key: context.read<AuthCubit>().signupFormKey,
              child: Column(
                children: [
                  const CustomText(text: "Sign Up", size: 30),
                  const DividerV(height: 50),
                  CustomUnderTextFormField(
                    hint: "Name",
                    fieldHint: "Dave Harry",
                    inputType: TextInputType.name,
                    controller: context.read<AuthCubit>().signupUsername,
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return "Name Can't be Empty";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const DividerV(height: 30),
                  CustomUnderTextFormField(
                    hint: "Email",
                    fieldHint: "daveharry@gmail.com",
                    inputType: TextInputType.emailAddress,
                    controller: context.read<AuthCubit>().signupEmail,
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
                  const DividerV(height: 30),
                  CustomUnderTextFormField(
                    hint: "Password",
                    fieldHint: "***********",
                    inputType: TextInputType.visiblePassword,
                    isPass: true,
                    controller: context.read<AuthCubit>().signupPassword,
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
                  const DividerV(height: 70),
                  state == EmailSignUpLoadingState()
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        )
                      : CustomButton(
                    width: double.infinity,
                          text: "Sign Up",
                          onPressed: () {
                            if (context
                                .read<AuthCubit>()
                                .signupFormKey
                                .currentState!
                                .validate()) {
                              context
                                  .read<AuthCubit>()
                                  .signUpWithEmailAndPassword(
                                    context,
                                    emailAddress: context
                                        .read<AuthCubit>()
                                        .signupEmail
                                        .text,
                                    password: context
                                        .read<AuthCubit>()
                                        .signupPassword
                                        .text,
                                  );
                            }
                          },
                          color: primaryColor,
                          textColor: Colors.white,
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
