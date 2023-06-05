// ignore_for_file: avoid_print

import 'package:ecommercecourse42/core/class/statusrequest.dart';
import 'package:ecommercecourse42/core/constant/routes.dart';
import 'package:ecommercecourse42/core/functions/handingdatacontroller.dart';
import 'package:ecommercecourse42/data/datasource/remote/forgetpassword/checkemail.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

abstract class ForgetPasswordController extends GetxController {
  checkemail();
}

class ForgetPasswordControllerImp extends ForgetPasswordController {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  late TextEditingController email;

  StatusRequest? statusRequest = StatusRequest.none;
  CheckEmailData checkEmailData = CheckEmailData(Get.find());

  @override
  checkemail() async {
    if (formstate.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();

      var response = await checkEmailData.postdata(email.text);
      print("=============================== Controller $response ");
      statusRequest = handlingData(response);

      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          // data.addAll(response['data']);
          Get.offNamed(AppRoute.verfiyCode, arguments: {"email": email.text});
        } else {
          Get.defaultDialog(title: "ُWarning", middleText: "Email Not Found");
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
    email = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }
}
