import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:register/register.dart';
import 'package:email_validator/email_validator.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _txtcontroller = TextEditingController();
  final TextEditingController _pwdcontroller = TextEditingController();
  var rememberValue = false;
  bool isPasswordVisible = false;
  void initState() {
    super.initState();
    _txtcontroller.addListener(() {
      setState(() {});
    });

    _txtcontroller.addListener(() {
      final String text = _txtcontroller.text.toLowerCase();
      _txtcontroller.value = _txtcontroller.value.copyWith(
        text: text,
        selection:
            TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
    });
  }

  @override
  final txtcolor = TextStyle(
    color: Colors.grey[900],
    fontSize: 16,
  );
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[550],
      body: Container(
        padding: const EdgeInsets.all(20),
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
              height: 30,
            ),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) => EmailValidator.validate(value!)
                          ? null
                          : "Please enter a valid email",
                      maxLines: 1,
                      controller: _txtcontroller,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        suffixIcon: _txtcontroller.text.isEmpty
                            ? Container(
                                width: 0,
                              )
                            : IconButton(
                                onPressed: (() {
                                  _txtcontroller.clear();
                                }),
                                icon: Icon(Icons.clear)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        hintText: 'Enter your name or mail',
                        hintStyle: txtcolor,
                        labelText: 'Name',
                        labelStyle: txtcolor,
                        prefixIcon: Icon(Icons.person),
                        iconColor: Colors.blueAccent,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      controller: _pwdcontroller,
                      obscureText: isPasswordVisible,
                      maxLines: 1,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        suffixIcon: IconButton(
                          icon: isPasswordVisible
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                          onPressed: () => setState(
                              () => isPasswordVisible = !isPasswordVisible),
                        ),
                        hintText: 'Enter your password',
                        hintStyle: txtcolor,
                        labelText: 'Password',
                        labelStyle: txtcolor,
                        prefixIcon: Icon(
                          Icons.lock,
                        ),
                        iconColor: Colors.blueAccent,
                      ),
                    ),
                    CheckboxListTile(
                      title: const Text("Remember me"),
                      contentPadding: EdgeInsets.zero,
                      value: rememberValue,
                      activeColor: Theme.of(context).colorScheme.primary,
                      onChanged: (newValue) {
                        setState(() {
                          rememberValue = newValue!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {}
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                      ),
                      child: const Text(
                        'Sign in',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
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
                            /* Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterPage(),
                                ));*/
                          },
                          child: const Text('Create an account'),
                        ),
                      ],
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
