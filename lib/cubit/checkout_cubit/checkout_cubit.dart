import 'dart:convert';

import 'package:another_stepper/dto/stepper_data.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/shared/constants/constants.dart';
import 'package:e_commerce/view/checkout/summery.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/cart_product_model.dart';
import '../../model/order_model.dart';
import '../../shared/component/custom_toast.dart';
import '../../view/checkout/address.dart';
import '../../view/checkout/delivery.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';

import '../../view/layout/home_layout.dart';

part 'checkout_state.dart';

enum DeliveryStates { standard, nextDay, nominated }

class CheckoutCubit extends Cubit<CheckoutStates> {
  CheckoutCubit() : super(CheckoutInitial());

  List<StepperData> stepperData = [
    StepperData(
      title: StepperText(
        "Delivery",
      ),
    ),
    StepperData(
      title: StepperText(
        "Address",
      ),
    ),
    StepperData(
      title: StepperText(
        "Summery",
      ),
    ),
  ];
  List<Widget> steps = [
    const DeliveryScreen(),
    const AddressScreen(),
    const SummeryScreen(),
  ];
  int activeStep = 0;
  DeliveryStates currentDeliveryState = DeliveryStates.standard;
  TextEditingController street1Controller = TextEditingController();
  TextEditingController street2Controller = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

  void changeOrderData() {
    activeStep = 0;
    emit(CheckoutPreviousStepState());
  }

  void changeDeliveryState({required DeliveryStates state}) {
    currentDeliveryState = state;
    emit(CheckoutChangeDeliveryState());
    print(currentDeliveryState);
  }

  Future<void> nextStep(
    context, {
    required List<CartProductModel> cartProducts,
    required Function deleteCart,
    required int currentScreen,
  }) async {
    if (activeStep == 1) {
      if (addressFormKey.currentState!.validate()) {
        ++activeStep;
        emit(CheckoutNextStepState());
        print("active step is $activeStep");
      }
    } else {
      if (activeStep == 0) {
        ++activeStep;
        emit(CheckoutNextStepState());
        print("active step is $activeStep");
      } else {
        OrderModel order = OrderModel(
          location: Location(
            city: cityController.text,
            country: countryController.text,
            state: stateController.text,
            street1: street1Controller.text,
            street2: street2Controller.text,
          ),
          status: "In Transit",
          time: DateFormat("MMM dd,yyyy").format(DateTime.now()),
          orderProducts: List.generate(cartProducts.length, (index) {
            return OrderProducts.fromJson(
              cartProducts[index].toJson(),
            );
          }),
        );

        await sendOrder(order: order).then((value) async {
          makePayment(
              context: context,
              amount: '10',
              currency: "USD",
              deleteCart: () {
                deleteCart();
              });
          showToast(text: "Cart Sent Successfully", state: ToastStates.SUCCESS);
          emit(CheckoutSuccessState());
        });
      }
    }
  }

  void previousStep() {
    if (activeStep > 0) {
      --activeStep;
      emit(CheckoutPreviousStepState());
      print("active step is $activeStep");
    }
  }

  Future<void> sendOrder({
    required OrderModel order,
  }) async {
    //Todo
    FirebaseFirestore.instance
        .collection("Users")
        .doc(uid)
        .collection("Orders")
        .add(order.toJson())
        .then((value) {
      emit(CheckoutSendOrderSuccessState());
    }).catchError((error) {
      emit(CheckoutSendOrderErrorState());
    });
  }

  void resetData() {
    cityController.text = "";
    countryController.text = "";
    stateController.text = "";
    street1Controller.text = "";
    street2Controller.text = "";
    activeStep = 0;
  }

  Map<String, dynamic>? paymentIntentData;

  Future<void> makePayment(
      {required String amount,
      required String currency,
      required context,
      required Function deleteCart}) async {
    try {
      paymentIntentData = await createPaymentIntent(amount, currency);
      if (paymentIntentData != null) {
        await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
          merchantDisplayName: 'Prospects',
          customerId: paymentIntentData!['customer'],
          paymentIntentClientSecret: paymentIntentData!['client_secret'],
          customerEphemeralKeySecret: paymentIntentData!['ephemeralKey'],
        ));
        displayPaymentSheet(context, deleteCart);
      }
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet(context, Function deleteCart) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        showToast(
            text: "Payment Done Successfully", state: ToastStates.SUCCESS);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeLayout(),
          ),
          (route) => false,
        );
      }).whenComplete(() {
        resetData();
        deleteCart();
      });
    } on Exception catch (e) {
      if (e is StripeException) {
        print("Error from Stripe: ${e.error.localizedMessage}");
      } else {
        print("Unforeseen error: ${e}");
      }
    } catch (e) {
      print("exception:$e");
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51N1GipCxJfAPp9WpXggB9OIMqN796xcBSbT0S8tTCGeSEsf62CyT82s6TWZXihk1PY5K0dtapfAJcKW7ig80dyBy00TIH2Czhd',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }
}
