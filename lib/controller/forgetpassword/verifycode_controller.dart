import 'package:ecommercecourse42/core/class/statusrequest.dart';
import 'package:ecommercecourse42/core/constant/routes.dart';
import 'package:ecommercecourse42/core/functions/handingdatacontroller.dart';
import 'package:ecommercecourse42/data/datasource/remote/forgetpassword/verifycode.dart';
import 'package:get/get.dart';

abstract class VerifyCodeController extends GetxController {
  checkCode();
  goToResetPassword(String verfiyCode);
}

class VerifyCodeControllerImp extends VerifyCodeController {
  String? email;
  StatusRequest? statusRequest = StatusRequest.none;
  VerifyCodeForgetPasswordData verifyCodeForgetPasswordData = VerifyCodeForgetPasswordData(Get.find());


  @override
  checkCode() {}

  @override
  goToResetPassword(verfiyCode) async {
    statusRequest = StatusRequest.loading;
    update();

        var response = await verifyCodeForgetPasswordData.postdata(email!, verfiyCode); 
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") { 
        Get.offNamed(AppRoute.resetPassword,arguments: {"email": email});
      } else {
        Get.defaultDialog(
            title: "ُWarning",
            middleText: "Verify Code Wrong");
        statusRequest = StatusRequest.failure;
      }
    }
    update();

    Get.offNamed(AppRoute.resetPassword);
  }

  @override
  void onInit() {
    email = Get.arguments['email'];
    super.onInit();
  }
}
