// ignore_for_file: avoid_print

import 'package:ecommercecourse42/core/class/statusrequest.dart';
import 'package:ecommercecourse42/core/constant/routes.dart';
import 'package:ecommercecourse42/core/functions/handingdatacontroller.dart';
import 'package:ecommercecourse42/data/datasource/remote/auth/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

abstract class LoginController extends GetxController {
  login();
  goToSignUp();
  goToForgetPassword();
}

class LoginControllerImp extends LoginController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  late TextEditingController email;
  late TextEditingController password;

  StatusRequest? statusRequest = StatusRequest.none;
  LoginData loginData = LoginData(Get.find());

  bool isshowpassword = true;
  showPassword() {
    isshowpassword = isshowpassword == true ? false : true;
    update();
  }

  @override
  login() async {
    if (formstate.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();

      var response = await loginData.postdata(email.text, password.text);
      print("=============================== Controller $response ");
      statusRequest = handlingData(response);

      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          // data.addAll(response['data']);
          Get.offNamed(AppRoute.homepage);
        } else {
          Get.defaultDialog(
              title: "ُWarning", middleText: "Email Or Password Not Correct");
          statusRequest = StatusRequest.failure;
        }
      }
      update();
    }
  }

  @override
  goToSignUp() {
    Get.offNamed(AppRoute.signUp);
  }

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  goToForgetPassword() {
    Get.toNamed(AppRoute.forgetPassword);
  }
}
