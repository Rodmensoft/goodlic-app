import 'package:consultant_product/src/modules/login/view.dart';
import 'package:consultant_product/src/modules/sign_up/view.dart';
import 'package:consultant_product/src/modules/user/book_appointment/view_appointment_question.dart';
import 'package:consultant_product/src/modules/user/book_appointment/view_payment.dart';
import 'package:consultant_product/src/modules/user/book_appointment/view_slot_selection.dart';
import 'package:consultant_product/src/modules/user/consultant_profile/view.dart';
import 'package:consultant_product/src/modules/user/home/view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

routes() => [
      GetPage(name: "/login", page: () => const LoginPage()),
      GetPage(name: "/signUp", page: () => const SignUpPage()),
      GetPage(name: "/userHome", page: () => const UserHomePage()),
      GetPage(
          name: "/consultantProfileForUser",
          page: () => const ConsultantProfilePage(),
          transition: Transition.zoom),
      GetPage(
          name: "/slotSelection", page: () => const SlotSelection()),
      GetPage(
          name: "/appointmentQuestion", page: () => const AppointmentQuestionPage(),
      transition: Transition.noTransition),
      GetPage(
          name: "/paymentView", page: () => const PaymentView(),
      transition: Transition.noTransition),
    ];

class PageRoutes {
  static const String login = '/login';
  static const String signUp = '/signUp';
  static const String userHome = '/userHome';
  static const String consultantProfileForUser = '/consultantProfileForUser';
  static const String slotSelection = '/slotSelection';
  static const String appointmentQuestion = '/appointmentQuestion';
  static const String paymentView = '/paymentView';

  Map<String, WidgetBuilder> routes() {
    return {
      login: (context) => const LoginPage(),
      signUp: (context) => const SignUpPage(),
      userHome: (context) => const UserHomePage(),
      consultantProfileForUser: (context) => const ConsultantProfilePage(),
      slotSelection: (context) => const SlotSelection(),
      appointmentQuestion: (context) => const AppointmentQuestionPage(),
      paymentView: (context) => const PaymentView(),
    };
  }
}
