import 'dart:collection';
import 'dart:developer';
import 'dart:io';

import 'package:consultant_product/multi_language/language_constants.dart';
import 'package:consultant_product/src/api_services/urls.dart';
import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/user/book_appointment/logic.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/widgets/custom_app_bar.dart';
import 'package:consultant_product/src/widgets/custom_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:resize/resize.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentEasyPaisaView extends StatefulWidget {
  const PaymentEasyPaisaView({Key? key}) : super(key: key);

  @override
  _PaymentEasyPaisaViewState createState() => _PaymentEasyPaisaViewState();
}

class _PaymentEasyPaisaViewState extends State<PaymentEasyPaisaView>
    with TickerProviderStateMixin {
  final logic = Get.put(BookAppointmentLogic());
  final state = Get.find<BookAppointmentLogic>().state;

  bool _canVibrate = true;
  final Iterable<Duration> pauses = [
    const Duration(milliseconds: 500),
    const Duration(milliseconds: 1000),
    const Duration(milliseconds: 500),
  ];

  final GlobalKey<FormState> _paymentFormKey = GlobalKey();
  final TextEditingController _jazzCashTextController = TextEditingController();

  AnimationController? slidAbleAnimationController1;
  AnimationController? slidAbleAnimationController2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    slidAbleAnimationController1 = AnimationController.unbounded(vsync: this);
    slidAbleAnimationController2 = AnimationController.unbounded(vsync: this);
    _init();
  }

  Future<void> _init() async {
    bool canVibrate = await Vibrate.canVibrate;
    setState(() {
      _canVibrate = canVibrate;
      _canVibrate
          ? debugPrint('This device can vibrate')
          : debugPrint('This device cannot vibrate');
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    slidAbleAnimationController1!.dispose();
    slidAbleAnimationController2!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: GetBuilder<BookAppointmentLogic>(
        builder: (_bookAppointmentLogicController) =>
            GetBuilder<GeneralController>(builder: (_generalController) {
          return ModalProgressHUD(
            progressIndicator: const CircularProgressIndicator(
              color: customThemeColor,
            ),
            inAsyncCall: _generalController.formLoaderController!,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.white,
              appBar: const MyCustomAppBar(
                  drawerShow: false, whiteBackground: true),
              body: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Form(
                    key: _paymentFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ///---fee-section
                        Container(
                          height: 52,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: customThemeColor,
                              borderRadius: BorderRadius.circular(8)),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Align(
                                    alignment: _generalController
                                            .isDirectionRTL(context)
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                    child: Text(
                                      '${'you_will_be_charge'.tr}:',
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    '${'rs'.tr}. ${Get.find<BookAppointmentLogic>().selectMentorAppointmentType!.fee}',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),

                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
              bottomNavigationBar: InkWell(
                onTap: () {
                  if (_canVibrate) {
                    Vibrate.feedback(FeedbackType.heavy);
                  }
                  log('InitialUrl ${baseUrl}easypaisa?'
                      'amount=${Get.find<BookAppointmentLogic>().selectMentorAppointmentType!.fee}&'
                      'bookAppointmentId=${Get.find<BookAppointmentLogic>().bookAppointmentModel.data!.appointmentNo}');
                  Get.to(InAppWebViewExampleScreen());
                },
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20.w, 0, 20.w, 0),
                  child: MyCustomBottomBar(
                    title: LanguageConstant.continueText.tr,
                    disable: false,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class InAppWebViewExampleScreen extends StatefulWidget {
  @override
  _InAppWebViewExampleScreenState createState() =>
      new _InAppWebViewExampleScreenState();
}

class _InAppWebViewExampleScreenState extends State<InAppWebViewExampleScreen> {
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  late PullToRefreshController pullToRefreshController;
  late ContextMenu contextMenu;
  String url = "";
  double progress = 0;
  final urlController = TextEditingController();

  @override
  void initState() {
    super.initState();

    contextMenu = ContextMenu(
        menuItems: [
          ContextMenuItem(
              androidId: 1,
              iosId: "1",
              title: "Special",
              action: () async {
                print("Menu item Special clicked!");
                print(await webViewController?.getSelectedText());
                await webViewController?.clearFocus();
              })
        ],
        options: ContextMenuOptions(hideDefaultSystemContextMenuItems: false),
        onCreateContextMenu: (hitTestResult) async {
          print("onCreateContextMenu");
          print(hitTestResult.extra);
          print(await webViewController?.getSelectedText());
        },
        onHideContextMenu: () {
          print("onHideContextMenu");
        },
        onContextMenuActionItemClicked: (contextMenuItemClicked) async {
          var id = (Platform.isAndroid)
              ? contextMenuItemClicked.androidId
              : contextMenuItemClicked.iosId;
          print("onContextMenuActionItemClicked: " +
              id.toString() +
              " " +
              contextMenuItemClicked.title);
        });

    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(
              urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(children: <Widget>[
      Expanded(
        child: Stack(
          children: [
            InAppWebView(
              key: webViewKey,
              // contextMenu: contextMenu,
              initialUrlRequest: URLRequest(
                url: Uri.parse("${baseUrl}easypaisa?"
                    "amount=${Get.find<BookAppointmentLogic>().selectMentorAppointmentType!.fee}&"
                    "bookAppointmentId=${Get.find<BookAppointmentLogic>().bookAppointmentModel.data!.appointmentNo}"),
              ),
              // initialFile: "assets/index.html",
              initialUserScripts: UnmodifiableListView<UserScript>([]),
              initialOptions: options,
              pullToRefreshController: pullToRefreshController,
              onWebViewCreated: (controller) {
                webViewController = controller;
              },
              onLoadStart: (controller, url) {
                setState(() {
                  this.url = url.toString();
                  urlController.text = this.url;
                });
              },
              androidOnPermissionRequest:
                  (controller, origin, resources) async {
                return PermissionRequestResponse(
                    resources: resources,
                    action: PermissionRequestResponseAction.GRANT);
              },
              shouldOverrideUrlLoading: (controller, navigationAction) async {
                var uri = navigationAction.request.url!;

                if (![
                  "http",
                  "https",
                  "file",
                  "chrome",
                  "data",
                  "javascript",
                  "about"
                ].contains(uri.scheme)) {
                  if (await canLaunch(url)) {
                    // Launch the App
                    await launch(
                      url,
                    );
                    // and cancel the request
                    return NavigationActionPolicy.CANCEL;
                  }
                }

                return NavigationActionPolicy.ALLOW;
              },
              onLoadStop: (InAppWebViewController controller, Uri? url) async {
                pullToRefreshController.endRefreshing();
                setState(() {
                  this.url = url.toString();
                  urlController.text = this.url;
                });
                log('URL--->>> ${url.toString()}');
                if (url.toString().contains("easypaisa-after-payment")) {
                  // get your token from url
                  // Navigator.pop(scaffoldKey.currentContext); // No need of this
                  // Navigator.pushReplacement(scaffoldKey.currentContext,
                  //     MaterialPageRoute(builder: (context) => DD()));
                  Future.delayed(const Duration(seconds: 4))
                      .whenComplete(() => Get.back());
                }
              },
              onLoadError: (controller, url, code, message) {
                pullToRefreshController.endRefreshing();
              },
              onProgressChanged: (controller, progress) {
                if (progress == 100) {
                  pullToRefreshController.endRefreshing();
                }
                setState(() {
                  this.progress = progress / 100;
                  urlController.text = this.url;
                });
              },
              onUpdateVisitedHistory: (controller, url, androidIsReload) {
                setState(() {
                  this.url = url.toString();
                  urlController.text = this.url;
                });
              },
              onConsoleMessage: (controller, consoleMessage) {
                print(consoleMessage);
              },
            ),
            progress < 1.0
                ? LinearProgressIndicator(value: progress)
                : Container(),
          ],
        ),
      ),
    ])));
  }
}
