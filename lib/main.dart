import 'dart:developer';

import 'package:consultant_product/multi_language/languages.dart';
import 'package:consultant_product/route_generator.dart';
import 'package:consultant_product/src/api_services/logic.dart';
import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:resize/resize.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  // await Firebase.initializeApp();
  await GetStorage.init();

  Get.put(GeneralController());
  Get.put(ApiLogic());

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
        !Get.find<GeneralController>().storageBox.hasData('onlineStatus')) {
      switch (state) {
        case AppLifecycleState.resumed:
          log('----->>> RESUMED <<-----');

          break;
        case AppLifecycleState.inactive:
          log('----->>> INACTIVE <<-----');

          break;
        case AppLifecycleState.paused:
          log('----->>> PAUSED <<-----');

          break;
        case AppLifecycleState.detached:
          log('----->>> DETACHED <<-----');

          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // LocalNotificationService.initialize(context);

    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
    ]);

    return Resize(
        allowtextScaling: true,
        size: const Size(375, 812),
        builder: () {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,

            translations: LanguagesChang(),
            locale: Locale(
                '${Get.find<GeneralController>().storageBox.read('languageCode')}',
                '${Get.find<GeneralController>().storageBox.read('countryCode')}'),
            fallbackLocale: Locale(
                '${Get.find<GeneralController>().storageBox.read('languageCode')}',
                '${Get.find<GeneralController>().storageBox.read('countryCode')}'),

            // initialRoute: PageRoutes.login,
            initialRoute: PageRoutes.userHome,
            getPages: routes(),
            themeMode: ThemeMode.light,
            theme: lightTheme(),
          );
        });
  }
}
