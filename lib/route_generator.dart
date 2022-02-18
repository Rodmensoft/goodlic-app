import 'package:consultant_product/src/modules/login/view.dart';
import 'package:consultant_product/src/modules/sign_up/view.dart';
import 'package:consultant_product/src/modules/user/user_home/view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

routes() =>
    [

      GetPage(name: "/login", page: () => const LoginPage()),
      GetPage(name: "/signUp", page: () => const SignUpPage()),
      GetPage(name: "/userHome", page: () => const UserHomePage()),
    ];

class PageRoutes {
  static const String login = '/login';
  static const String signUp = '/signUp';
  static const String userHome = '/userHome';

  Map<String, WidgetBuilder> routes() {
    return {
      login: (context) => const LoginPage(),
      signUp: (context) => const SignUpPage(),
      userHome: (context) => const UserHomePage(),
    };
  }
}
