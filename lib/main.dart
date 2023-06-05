import 'package:ecommercecourse42/bindings/intialbindings.dart';
import 'package:ecommercecourse42/core/localization/translation.dart';
import 'package:ecommercecourse42/core/services/services.dart';
import 'package:ecommercecourse42/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/localization/changelocal.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    LocaleController controller = Get.put(LocaleController());
    return GetMaterialApp(
      translations: MyTranslation(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      locale: controller.language,
      theme: controller.appTheme, 
      initialBinding:InitialBindings() ,
      // routes: routes,
      getPages: routes,
    );
  }
}
