
// ignore_for_file: avoid_print

import 'package:ecommercecourse42/core/class/statusrequest.dart';
import 'package:ecommercecourse42/core/constant/routes.dart';
import 'package:ecommercecourse42/core/functions/handingdatacontroller.dart';
import 'package:ecommercecourse42/data/datasource/remote/forgetpassword/resetpassword.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

abstract class ResetPasswordController extends GetxController {
  resetpassword();
  goToSuccessResetPassword();
}

class ResetPasswordControllerImp extends ResetPasswordController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  ResetPasswordData resetPasswordData = ResetPasswordData(Get.find());

  StatusRequest? statusRequest = StatusRequest.none;

  late TextEditingController password;
  late TextEditingController repassword;

  String? email;

  @override
  resetpassword() {}

  @override
  goToSuccessResetPassword() async {
    if (password.text != repassword.text) {
      return Get.defaultDialog(
          title: "ُWarning",
          middleText: "The first and second passwords aren/'t the same ");
    }
    if (formstate.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      var response = await resetPasswordData.postdata(email!, password.text);
      print("=============================== Controller $response ");
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          // data.addAll(response['data']);
          Get.offNamed(AppRoute.successResetpassword);
        } else {
          Get.defaultDialog(
            title: "ُWarning", middleText: "Try again");
          statusRequest = StatusRequest.failure;
        }
      }
      update();
      } else {
        print("Not Valid");
      }
    
}
    @override
    void onInit() {
      email = Get.arguments['email'];
      password = TextEditingController();
      repassword = TextEditingController();
      super.onInit();
    }

    @override
    void dispose() {
      password.dispose();
      repassword.dispose();
      super.dispose();
    }
  
}
