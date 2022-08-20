import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:register/controller/login_controller.dart';
import 'package:register/controller/register_controller.dart';
import 'package:register/view/loading.dart';

import '../utli/constant.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final txtcolor = TextStyle(
    color: Colors.grey[900],
    fontSize: 16,
  );
  @override
  Widget build(BuildContext context) {
    Future<bool> showExitPopup() async {
      return await Get.dialog(
            AlertDialog(
              title: Text(
                'Are you sure?',
                style: Theme.of(context).textTheme.headline5,
              ),
              content: const Text(
                'Do you really want to exit?',
              ),
              actions: [
                TextButton(
                  onPressed: () => Get.back(canPop: true, closeOverlays: false),
                  child: Text(
                    'Stay',
                    style: TextStyle(color: TestColor().primaryColor),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.back();
                    SystemNavigator.pop();
                  },
                  //Get.back(canPop: false, closeOverlays: true, result: true),
                  child: Text(
                    'Leave',
                    style: TextStyle(color: TestColor().primaryColor),
                  ),
                ),
              ],
            ),
          ) ??
          false;
    }

    return Scaffold(
      backgroundColor: Colors.grey[550],
      body: WillPopScope(onWillPop: () async {
        return showExitPopup();
      }, child: GetBuilder<LoginController>(builder: (loginController) {
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Sign in here',
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 25,
              ),
              Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      if (!value!.isNotEmpty) {
                        return 'This field is required';
                      }

                      return null;
                    },
                    keyboardType: TextInputType.text,
                    controller: loginController.phoneController,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      hintText: 'Enter your name or mail',
                      hintStyle: txtcolor,
                      labelText: 'Name',
                      labelStyle: txtcolor,
                      prefixIcon: const Icon(Icons.person),
                      iconColor: Colors.blueAccent,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isNotEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    controller: loginController.passwordController,
                    obscureText: loginController.isHiddenPassword.value,
                    //maxLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Enter your password',
                      hintStyle: txtcolor,
                      labelText: 'Password',
                      labelStyle: txtcolor,
                      prefixIcon: const Icon(
                        Icons.lock,
                      ),
                      iconColor: Colors.blueAccent,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GetBuilder<RegisterController>(builder: (registerController) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: TestColor().primaryColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Colors.blueAccent,
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            var loginController = LoginController();
                            var registerController = RegisterController();
                            if (loginController.passwordController.text !=
                                registerController.userBox
                                    .read(Keys.password)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.redAccent,
                                  duration: Duration(seconds: 2),
                                  content:
                                      Text("Invalid phone number and password"),
                                ),
                              );
                            } else {
                              loginController.login();
                            }
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    );
                  }),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Not registered yet?'),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/register');
                        },
                        child: const Text('Create an account'),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      })),
    );
  }
}
