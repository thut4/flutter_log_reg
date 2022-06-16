import 'package:flutter/material.dart';
import 'package:register/login.dart';
import 'package:register/register.dart';
import 'package:register/loading.dart';

void main() => runApp(MaterialApp(
        initialRoute: '/login',
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const Loading(),
          '/login': (context) => Login(),
          '/register': (context) => const RegisterPage(),
        }
        //home: Login(),
        ));
