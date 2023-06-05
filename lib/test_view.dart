import 'package:ecommercecourse42/controller/test_controller.dart';
import 'package:ecommercecourse42/core/class/handlingdataview.dart';
import 'package:ecommercecourse42/core/constant/color.dart'; 
import 'package:flutter/material.dart';
import 'package:get/get.dart'; 

class TestView extends StatelessWidget {
  const TestView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(TestController());
    return Scaffold(

      appBar: AppBar(title: const Text("Title") , 
      backgroundColor: AppColor.primaryColor,
      ),
      body: GetBuilder<TestController>(builder: (controller) {
        return HandlingDataView(
            statusRequest: controller.statusRequest,
            widget: ListView.builder(
                itemCount: controller.data.length,
                itemBuilder: (context, index) {
                  return Text("${controller.data}");
                }));
      }),
    );
  }
}
