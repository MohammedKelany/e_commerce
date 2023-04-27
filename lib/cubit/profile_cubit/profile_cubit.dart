import 'dart:io';

import 'package:another_stepper/dto/stepper_data.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/shared/constants/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/order_model.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(ProfileInitial());
  List<OrderModel> orders = [];
  File? profileImage;
  List<StepperData> data = [
    StepperData(
      title: StepperText("23/4/18"),
      subtitle: StepperText("10:00Pm"),
    ),
    StepperData(
      title: StepperText("23/4/18"),
      subtitle: StepperText("10:00Pm"),
    ),
    StepperData(
      title: StepperText("23/4/18"),
      subtitle: StepperText("10:00Pm"),
    ),
    StepperData(
      title: StepperText("23/4/18"),
      subtitle: StepperText("10:00Pm"),
    ),
    StepperData(
      title: StepperText("23/4/18"),
      subtitle: StepperText("10:00Pm"),
    ),
  ];
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> updateFormKey = GlobalKey<FormState>();

  void getOrders() {
    orders = [];
    FirebaseFirestore.instance
        .collection("Users")
        .doc(uid)
        .collection("Orders")
        .orderBy("time")
        .get()
        .then((value) {
      for (var element in value.docs) {
        orders.add(
          OrderModel.fromJson(
            element.data(),
          ),
        );
      }
      print(orders);
      emit(GetOrderHistorySuccessState());
    }).catchError((error) {
      print(error);
      emit(GetOrderHistoryErrorState());
    });
  }

  Future<void> getGalleryImage() async {
    final ImagePicker picker = ImagePicker();
// Pick an image.
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      profileImage = File(image.path);
      saveProfileImageToFirebase();
    }
    return;
  }
  Future<void> getCameraImage() async {
    final ImagePicker picker = ImagePicker();
// Capture a photo.
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      profileImage = File(photo.path);
      saveProfileImageToFirebase();
    }
    return;
  }

  Future<void> saveProfileImageToFirebase() async {
    FirebaseStorage.instance
        .ref()
        .child("Profiles/${Uri.file(profileImage!.path).pathSegments.last}")
        .putFile(profileImage!)
        .then(
      (image) {
        image.ref.getDownloadURL().then(
          (value) {
            updateUserProfileImage(image: value);
            emit(UpdateProfileSuccessState());
          },
        ).catchError(
          (error) {
            emit(UpdateProfileErrorState());
          },
        );
      },
    ).catchError(
      (error) {
        emit(UpdateProfileErrorState());
      },
    );
  }

  void updateUserProfileImage({required String image}) {
    FirebaseFirestore.instance.collection("Users").doc(uid).update(
      {"image": image},
    ).then(
      (value) {
        emit(UpdateProfileImageSuccessState());
      },
    ).catchError(
      (error) {
        emit(UpdateProfileImageErrorState());
      },
    );
  }


}
