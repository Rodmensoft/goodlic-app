import 'dart:developer';
import 'dart:io';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:consultant_product/multi_language/languages.dart';
import 'package:consultant_product/route_generator.dart';
import 'package:consultant_product/src/api_services/local_notification_service.dart';
import 'package:consultant_product/src/api_services/logic.dart';
import 'package:consultant_product/src/api_services/post_service.dart';
import 'package:consultant_product/src/api_services/urls.dart';
import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/agora_call/agora_logic.dart';
import 'package:consultant_product/src/modules/agora_call/init_video_call_view.dart';
import 'package:consultant_product/src/modules/chat/logic.dart';
import 'package:consultant_product/src/modules/consultant/dashboard/repo_post.dart';
import 'package:consultant_product/src/modules/consultant/dashboard/view.dart';
import 'package:consultant_product/src/modules/on_board/view_1.dart';
import 'package:consultant_product/src/modules/sms/logic.dart';
import 'package:consultant_product/src/modules/user/home/view.dart';
import 'package:consultant_product/src/utils/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:resize/resize.dart';

import 'package:consultant_product/src/modules/agora_call/agora.config.dart' as config;

final GlobalKey<NavigatorState> navigatorKey =
GlobalKey(debugLabel: "Main Navigator");
RtcEngine? _engine;

_initEngine(String? route) async {
  _engine = await RtcEngine.createWithConfig(RtcEngineConfig(config.appId));

  await _engine!.enableVideo();
  await _engine!.startPreview();
  await _engine!.setChannelProfile(ChannelProfile.LiveBroadcasting);
  await _engine!.setClientRole(ClientRole.Broadcaster);
  Get.toNamed(route!);
}

Future<void> backgroundHandler(RemoteMessage message) async {
  Get.put(GeneralController());

  LocalNotificationService.display(message);
  // String route;
  //
  // if (message.data['channel'] != null) {
  //   Get.find<GeneralController>().updateCallerType(2);
  //   Get.find<GeneralController>().updateChannelForCall(message.data['channel']);
  //   Get.find<GeneralController>()
  //       .updateTokenForCall(message.data['channel_token']);
  // }
  // if (message.data['routeApp'] != null) {
  //   route = message.data['routeApp'];
  //
  //   runApp(NavigationFromNotification(route:route));
  //   // Get.toNamed(route);
  // }

  log('MessageData0---->>>${message.data.toString()}');
  log('MessageData1---->>>${message.notification!.title.toString()}');
  log('MessageData2---->>>${message.data['routeApp']}');
}


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  await Firebase.initializeApp();
  await GetStorage.init();

  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);

    var swAvailable = await AndroidWebViewFeature.isFeatureSupported(
        AndroidWebViewFeature.SERVICE_WORKER_BASIC_USAGE);
    var swInterceptAvailable = await AndroidWebViewFeature.isFeatureSupported(
        AndroidWebViewFeature.SERVICE_WORKER_SHOULD_INTERCEPT_REQUEST);

    if (swAvailable && swInterceptAvailable) {
      AndroidServiceWorkerController serviceWorkerController =
      AndroidServiceWorkerController.instance();

      serviceWorkerController.serviceWorkerClient = AndroidServiceWorkerClient(
        shouldInterceptRequest: (request) async {
          log(request.toString());
          return null;
        },
      );
    }
  }
  Get.put(GeneralController());
  Get.put(ApiLogic());
  Get.put(AgoraLogic());
  Get.put(SmsLogic());

  //-----load-configurations-from-local-json
  await GlobalConfiguration().loadFromAsset("configurations");

  log("---->> base_url: ${GlobalConfiguration().get('base_url')}");

  runApp(const InitClass());
}

class InitClass extends StatefulWidget {
  const InitClass({Key? key}) : super(key: key);

  @override
  _InitClassState createState() => _InitClassState();
}

class _InitClassState extends State<InitClass> with WidgetsBindingObserver {
  @override
  void initState() {
    // TODO: implement initState
    // Add the observer.
    WidgetsBinding.instance!.addObserver(this);

    ///---for-language-check
    Get.find<GeneralController>().checkLanguage();
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      String route;

      if (message != null) {
        if (message.data['channel'] != null) {
          Get.find<GeneralController>().updateCallerType(2);
          Get.find<GeneralController>()
              .updateChannelForCall(message.data['channel']);
          Get.find<GeneralController>()
              .updateTokenForCall(message.data['channel_token']);

          log('NotificationChannel---->>>${message.data['channel']}');
          log('NotificationChannelToken---->>>${message.data['channel_token']}');
        }
        if (message.data['routeApp'] != null) {
          route = message.data['routeApp'];
          // Get.toNamed(route);
          Get.to(NotificationRoute(
            route: route,
          ));

          log('MessageData0---->>>${message.data.toString()}');
          log('MessageData1---->>>${message.notification!.title.toString()}');
          log('MessageData2---->>>${message.data['routeApp']}');
        }
      }
    });

    ///forground messages
    FirebaseMessaging.onMessage.listen((message) {
      log('foreground messages----->>');
      log(message.notification.toString());

      if (message.notification != null) {
        log(message.notification!.body.toString());
        log(message.notification!.title.toString());
      }
      String route;
      if (message.data['channel'] != null) {
        Get.find<GeneralController>().updateCallerType(2);
        Get.find<GeneralController>()
            .updateChannelForCall(message.data['channel']);
        Get.find<GeneralController>()
            .updateTokenForCall(message.data['channel_token']);
        log('NotificationChannel---->>>${message.data['channel']}');
        log('NotificationChannelToken---->>>${message.data['channel_token']}');

      }
      if (message.data['routeApp'] != null) {
        route = message.data['routeApp'];
        // Get.toNamed(route);

        log('MessageData0---->>>${message.data.toString()}');
        log('MessageData1---->>>${message.notification!.title.toString()}');
        log('MessageData2---->>>${message.data['routeApp']}');
        Get.to(NotificationRoute(
          route: route,
        ));
      }
      LocalNotificationService.display(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      String route;
      if (message.data['channel'] != null) {
        Get.find<GeneralController>().updateCallerType(2);
        Get.find<GeneralController>()
            .updateChannelForCall(message.data['channel']);
        Get.find<GeneralController>()
            .updateTokenForCall(message.data['channel_token']);
        if (message.data['routeApp'] != null) {
          route = message.data['routeApp'];
          // Get.toNamed(route);
          Get.to(NotificationRoute(
            route: route,
          ));
        }
      } else if (message.data['routeApp'] != null) {
        _initEngine(message.data['routeApp']);
        route = message.data['routeApp'];
      }

      // LocalNotificationService.display(message);
    });
    super.initState();
  }

  @override
  void dispose() {
    // Remove the observer
    WidgetsBinding.instance!.removeObserver(this);

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (Get.find<GeneralController>().storageBox.hasData('userID') &&
        Get.find<GeneralController>().storageBox.hasData('authToken') &&
        !Get.find<GeneralController>().storageBox.hasData('onlineStatus')) {
      switch (state) {
        case AppLifecycleState.resumed:
          log('----->>> RESUMED <<-----');
          postMethod(
              context,
              changeMentorOnlineStatusUrl,
              {
                'token': '123',
                'user_id': Get.find<GeneralController>().storageBox.read('userID'),
                'status':'online'
              },
              true,
              changeMentorOnlineStatusRepo);
          break;
        case AppLifecycleState.inactive:
          log('----->>> INACTIVE <<-----');
          postMethod(
              context,
              changeMentorOnlineStatusUrl,
              {
                'token': '123',
                'user_id': Get.find<GeneralController>().storageBox.read('userID'),
                'status':'offline'
              },
              true,
              changeMentorOnlineStatusRepo);
          break;
        case AppLifecycleState.paused:
          log('----->>> PAUSED <<-----');
          postMethod(
              context,
              changeMentorOnlineStatusUrl,
              {
                'token': '123',
                'user_id': Get.find<GeneralController>().storageBox.read('userID'),
                'status':'offline'
              },
              true,
              changeMentorOnlineStatusRepo);
          break;
        case AppLifecycleState.detached:
          log('----->>> DETACHED <<-----');
          postMethod(
              context,
              changeMentorOnlineStatusUrl,
              {
                'token': '123',
                'user_id': Get.find<GeneralController>().storageBox.read('userID'),
                'status':'offline'
              },
              true,
              changeMentorOnlineStatusRepo);
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    LocalNotificationService.initialize(context);

    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
    ]);

    return Resize(
        allowtextScaling: true,
        size: const Size(375, 812),
        builder: () {

          Get.put(ChatLogic());
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,

            translations: LanguagesChang(),
            locale: Locale(
                '${Get.find<GeneralController>().storageBox.read('languageCode')}',
                '${Get.find<GeneralController>().storageBox.read('countryCode')}'),
            fallbackLocale: Locale(
                '${Get.find<GeneralController>().storageBox.read('languageCode')}',
                '${Get.find<GeneralController>().storageBox.read('countryCode')}'),

            home: const ScreenController(),
            // initialRoute: PageRoutes.createConsultantProfile,
            // initialRoute: PageRoutes.userHome,
            // initialRoute: PageRoutes.onBoard1Screen,
            getPages: routes(),
            themeMode: ThemeMode.light,
            theme: lightTheme(),
          );
        });
  }
}

class ScreenController extends StatelessWidget {
  const ScreenController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Get
        .find<GeneralController>()
        .storageBox
        .hasData('authToken')) {
      if (Get
          .find<GeneralController>()
          .storageBox
          .read('userRole')
          .toString() ==
          'Mentee') {
        return const UserHomePage();
      } else {
        return const ConsultantDashboardPage();
      }
    } else if(Get
        .find<GeneralController>()
        .storageBox
        .hasData('onBoard')) {
      return const UserHomePage();
    } else{
      return const OnBoard1Page();
    }
  }
}
