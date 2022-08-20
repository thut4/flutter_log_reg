import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:register/view/login.dart';
import 'package:register/view/register.dart';
import 'package:register/view/loading.dart';

import 'controller/login_controller.dart';
import 'controller/register_controller.dart';
import 'utli/constant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
        statusBarColor: TestColor().secondaryColor,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: TestColor().secondaryColor,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    Get.put(LoginController());
    Get.put(RegisterController());
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: Nav.login,
      getPages: [
        GetPage(
          name: Nav.welcome,
          page: () => const Loading(),
        ),
        GetPage(
          name: Nav.login,
          page: () => Login(),
        ),
        GetPage(
          name: Nav.register,
          page: () => const RegisterPage(),
        ),
      ],
    );
  }
}
