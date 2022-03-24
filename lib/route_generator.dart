
import 'package:consultant_product/src/modules/chat/view.dart';
import 'package:consultant_product/src/modules/consultant/consultant_appointment/view.dart';
import 'package:consultant_product/src/modules/consultant/consultant_appointment_detail/view.dart';
import 'package:consultant_product/src/modules/consultant/consultant_drawer/view.dart';
import 'package:consultant_product/src/modules/consultant/create_profile/view.dart';
import 'package:consultant_product/src/modules/consultant/dashboard/view.dart';
import 'package:consultant_product/src/modules/consultant/schedule/view.dart';
import 'package:consultant_product/src/modules/consultant/schedule_info/view.dart';
import 'package:consultant_product/src/modules/created_password/view.dart';
import 'package:consultant_product/src/modules/login/view.dart';
import 'package:consultant_product/src/modules/new_password/view.dart';
import 'package:consultant_product/src/modules/on_board/view_1.dart';
import 'package:consultant_product/src/modules/on_board/view_2.dart';
import 'package:consultant_product/src/modules/on_board/view_3.dart';
import 'package:consultant_product/src/modules/on_board/view_4.dart';
import 'package:consultant_product/src/modules/otp/view.dart';
import 'package:consultant_product/src/modules/reset_password/view.dart';
import 'package:consultant_product/src/modules/sign_up/view.dart';
import 'package:consultant_product/src/modules/user/all_consultants/view.dart';
import 'package:consultant_product/src/modules/user/appointment_detail/view.dart';
import 'package:consultant_product/src/modules/user/book_appointment/view_appointment_question.dart';
import 'package:consultant_product/src/modules/user/book_appointment/view_confirmation.dart';
import 'package:consultant_product/src/modules/user/book_appointment/view_payment.dart';
import 'package:consultant_product/src/modules/user/book_appointment/view_slot_selection.dart';
import 'package:consultant_product/src/modules/user/consultant_profile/view.dart';
import 'package:consultant_product/src/modules/user/edit_user_profile/view.dart';
import 'package:consultant_product/src/modules/user/home/view.dart';
import 'package:consultant_product/src/modules/user/my_appointment/view.dart';
import 'package:consultant_product/src/modules/user/user_drawer/view.dart';
import 'package:consultant_product/src/modules/wallet/view.dart';
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
      GetPage(name: "/slotSelection", page: () => const SlotSelection()),
      GetPage(
          name: "/appointmentQuestion",
          page: () => const AppointmentQuestionPage(),
          transition: Transition.noTransition),
      GetPage(
          name: "/paymentView",
          page: () => const PaymentView(),
          transition: Transition.noTransition),
      GetPage(name: "/allConsultants", page: () => const AllConsultantsPage()),
      GetPage(name: "/resetPassword", page: () => const ResetPasswordPage()),
      GetPage(name: "/enterOtp", page: () => const OtpPage()),
      GetPage(name: "/newPassword", page: () => const NewPasswordPage()),
      GetPage(
          name: "/createdPassword", page: () => const CreatedPasswordPage()),
      GetPage(
          name: "/appointmentConfirmation",
          page: () => const AppointmentConfirmationView()),
      GetPage(
        name: "/userDrawer",
        page: () => const UserDrawerPage(),
        transition: Transition.leftToRight,
        transitionDuration: const Duration(milliseconds: 500),
      ),
      GetPage(name: "/myAppointment", page: () => const MyAppointmentPage()),
      GetPage(
          name: "/appointmentDetail",
          page: () => const AppointmentDetailPage()),
      GetPage(name: "/chatScreen", page: () => const ChatPage()),
      GetPage(name: "/walletScreen", page: () => const WalletPage()),
      GetPage(
          name: "/onBoard1Screen",
          page: () => const OnBoard1Page(),
          transition: Transition.noTransition),
      GetPage(
          name: "/onBoard2Screen",
          page: () => const OnBoard2Page(),
          transition: Transition.noTransition),
      GetPage(
          name: "/onBoard3Screen",
          page: () => const OnBoard3Page(),
          transition: Transition.noTransition),
      GetPage(
          name: "/onBoard4Screen",
          page: () => const OnBoard4Page(),
          transition: Transition.noTransition),
      GetPage(
          name: "/editUserProfile", page: () => const EditUserProfilePage()),
      GetPage(
          name: "/createConsultantProfile",
          page: () => const CreateProfilePage()),
      GetPage(
          name: "/consultantDashboard",
          page: () => const ConsultantDashboardPage()),
      GetPage(
          name: "/consultantDrawer",
          page: () => const ConsultantDrawerPage(),
        transition: Transition.leftToRight,
        transitionDuration: const Duration(milliseconds: 500),),
      GetPage(
          name: "/scheduleCreate",
          page: () => const ScheduleCreatePage()),
      GetPage(
          name: "/consultantAllAppointment",
          page: () => const ConsultantAppointmentPage()),
      GetPage(
          name: "/consultantAppointmentDetail",
          page: () => const ConsultantAppointmentDetailPage()),
    ];

class PageRoutes {
  static const String login = '/login';
  static const String signUp = '/signUp';
  static const String userHome = '/userHome';
  static const String consultantProfileForUser = '/consultantProfileForUser';
  static const String slotSelection = '/slotSelection';
  static const String appointmentQuestion = '/appointmentQuestion';
  static const String allConsultants = '/allConsultants';
  static const String resetPassword = '/resetPassword';
  static const String paymentView = '/paymentView';
  static const String enterOtp = '/enterOtp';
  static const String newPassword = '/newPassword';
  static const String createdPassword = '/createdPassword';
  static const String appointmentConfirmation = '/appointmentConfirmation';
  static const String userDrawer = '/userDrawer';
  static const String myAppointment = '/myAppointment';
  static const String appointmentDetail = '/appointmentDetail';
  static const String chatScreen = '/chatScreen';
  static const String walletScreen = '/walletScreen';
  static const String onBoard1Screen = '/onBoard1Screen';
  static const String onBoard2Screen = '/onBoard2Screen';
  static const String onBoard3Screen = '/onBoard3Screen';
  static const String onBoard4Screen = '/onBoard4Screen';
  static const String editUserProfile = '/editUserProfile';
  static const String createConsultantProfile = '/createConsultantProfile';
  static const String consultantDashboard = '/consultantDashboard';
  static const String consultantDrawer = '/consultantDrawer';
  static const String scheduleCreate = '/scheduleCreate';
  static const String consultantAllAppointment = '/consultantAllAppointment';
  static const String consultantAppointmentDetail = '/consultantAppointmentDetail';

  Map<String, WidgetBuilder> routes() {
    return {
      login: (context) => const LoginPage(),
      signUp: (context) => const SignUpPage(),
      userHome: (context) => const UserHomePage(),
      consultantProfileForUser: (context) => const ConsultantProfilePage(),
      slotSelection: (context) => const SlotSelection(),
      appointmentQuestion: (context) => const AppointmentQuestionPage(),
      allConsultants: (context) => const AllConsultantsPage(),
      resetPassword: (context) => const ResetPasswordPage(),
      paymentView: (context) => const PaymentView(),
      enterOtp: (context) => const OtpPage(),
      newPassword: (context) => const NewPasswordPage(),
      createdPassword: (context) => const CreatedPasswordPage(),
      appointmentConfirmation: (context) => const AppointmentConfirmationView(),
      userDrawer: (context) => const UserDrawerPage(),
      myAppointment: (context) => const MyAppointmentPage(),
      appointmentDetail: (context) => const AppointmentDetailPage(),
      chatScreen: (context) => const ChatPage(),
      walletScreen: (context) => const WalletPage(),
      onBoard1Screen: (context) => const OnBoard1Page(),
      onBoard2Screen: (context) => const OnBoard2Page(),
      onBoard3Screen: (context) => const OnBoard3Page(),
      onBoard4Screen: (context) => const OnBoard4Page(),
      editUserProfile: (context) => const EditUserProfilePage(),
      createConsultantProfile: (context) => const CreateProfilePage(),
      consultantDashboard: (context) => const ConsultantDashboardPage(),
      consultantDrawer: (context) => const ConsultantDrawerPage(),
      scheduleCreate: (context) => const ScheduleCreatePage(),
      consultantAllAppointment: (context) => const ConsultantAppointmentPage(),
      consultantAppointmentDetail: (context) => const ConsultantAppointmentDetailPage(),
    };
  }
}
