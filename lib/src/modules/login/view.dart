import 'dart:io';

import 'package:consultant_product/multi_language/language_constants.dart';
import 'package:consultant_product/route_generator.dart';
import 'package:consultant_product/src/api_services/post_service.dart';
import 'package:consultant_product/src/api_services/urls.dart';
import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/login/repo.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/widgets/custom_app_bar.dart';
import 'package:consultant_product/src/widgets/custom_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:resize/resize.dart';

import 'logic.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  //****************** Login with Google ******************
  // String? _pickFirstNamedContact(Map<String, dynamic> data) {
  //   final List<dynamic>? connections = data['connections'] as List<dynamic>?;
  //   final Map<String, dynamic>? contact = connections?.firstWhere(
  //     (dynamic contact) => contact['names'] != null,
  //     orElse: () => null,
  //   ) as Map<String, dynamic>?;
  //   if (contact != null) {
  //     final Map<String, dynamic>? name = contact['names'].firstWhere(
  //       (dynamic name) => name['displayName'] != null,
  //       orElse: () => null,
  //     ) as Map<String, dynamic>?;
  //     if (name != null) {
  //       return name['displayName'] as String?;
  //     }
  //   }
  //   return null;
  // }

  // Future<void> loginWithGoogle() async {
  //   // await GoogleSignIn().signOut();
  //   // return;
  //   try {
  //     final GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();
  //
  //     final GoogleSignInAuthentication? googleSignInAuthentication = await googleSignInAccount?.authentication;
  //     if (googleSignInAuthentication?.accessToken == null) {
  //       // AppDialog().showOSDialog(context, “Error”, “User cancel sign up procedure”, “OK”, () {});
  //       return;
  //     }
  //
  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleSignInAuthentication?.accessToken,
  //       idToken: googleSignInAuthentication?.idToken,
  //     );
  //     print('This is $credential');
  //
  //     final UserCredential authResult = await FirebaseAuth.instance.signInWithCredential(credential);
  //     final User? user = authResult.user;
  //     print(user.toString());
  //     print(user!.displayName);
  //     print(user.email);
  //     print(user.uid);
  //     // if (user != null) {
  //     // await checkUserExists(uid: user.uid);
  //     // }
  //
  //   } catch (e) {
  //     print('Google Login Error: $e');
  //   }
  // }

  final logic = Get.put(LoginLogic());

  final state = Get.find<LoginLogic>().state;
  bool? obscureText = true;
  final GlobalKey<FormState> _loginFormKey = GlobalKey();
  Future<void> loginWithGoogle() async {
    // await GoogleSignIn().signOut();
    // return;
    try {
      final GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleSignInAuthentication = await googleSignInAccount?.authentication;
      if (googleSignInAuthentication?.accessToken == null) {
        // AppDialog().showOSDialog(context, “Error”, “User cancel sign up procedure”, “OK”, () {});
        return;
      }

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication?.accessToken,
        idToken: googleSignInAuthentication?.idToken,
      );
      print('This is $credential');

      final UserCredential authResult = await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = authResult.user;
      print(user.toString());
      print(user!.displayName);
      print(user.email);
      print(user.uid);
      // if (user != null) {
      // await checkUserExists(uid: user.uid);
      // }
      postMethod(
          context,
          loginWithGoogleURL,
          {
            'email': user.email,
            'name': user.displayName,
            'role': logic.selectedRole,
            'id': user.uid,
          },
          false,
          loginWithEmailRepo);
    } catch (e) {
      print('Google Login Error: $e');
    }
  }

  // GoogleSignIn _googleSignIn = GoogleSignIn(
  //   // Optional clientId
  //   clientId: '1092278578798-g47tg815aeoblnqtqsn2ni18pnnvd2a0.apps.googleusercontent.com',
  //   scopes: <String>[
  //     'email',
  //     'https://www.googleapis.com/auth/contacts.readonly',
  //   ],
  // );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    logic.tabController = TabController(length: 2, vsync: this);
    // _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
    //   setState(() {
    //     _currentUser = account;
    //   });
    //   if (_currentUser != null) {
    //     _handleGetContact(_currentUser!);
    //   }
    // });
    // _googleSignIn.signInSilently();
  }

  // GoogleSignInAccount? _currentUser;
  // String _contactText = '';
  //
  // Future<void> _handleGetContact(GoogleSignInAccount user) async {
  //   setState(() {
  //     _contactText = 'Loading contact info...';
  //   });
  //   dio_instance.Response response;
  //   dio_instance.Dio dio = dio_instance.Dio();
  //   Map<String, dynamic> auth = await user.authHeaders;
  //   auth.forEach((key, value) {
  //     dio.options.headers[key] = value;
  //   });
  //
  //   response = await dio.get('https://people.googleapis.com/v1/people/me/connections'
  //       '?requestMask.includeField=person.names');
  //
  //   if (response.statusCode != 200) {
  //     setState(() {
  //       _contactText = 'People API gave a ${response.statusCode} '
  //           'response. Check logs for details.';
  //     });
  //     print('People API ${response.statusCode} response: ${response}');
  //     return;
  //   } else {
  //     print('This is My $response');
  //   }
  //   // final Map<String, dynamic> data = json.decode(response.toString()) as Map<String, dynamic>;
  //   // final String? namedContact = _pickFirstNamedContact(data);
  //   // setState(() {
  //   //   if (namedContact != null) {
  //   //     _contactText = 'I see you know $namedContact!';
  //   //   } else {
  //   //     _contactText = 'No contacts to display.';
  //   //   }
  //   // });
  // }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (_generalController) {
      return GestureDetector(
        onTap: () {
          _generalController.focusOut(context);
        },
        child: GetBuilder<LoginLogic>(builder: (_loginLogic) {
          return ModalProgressHUD(
            progressIndicator: const CircularProgressIndicator(
              color: customThemeColor,
            ),
            inAsyncCall: _generalController.formLoaderController!,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.white,
              body: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Stack(children: [
                  Positioned(
                    child: Image.asset(
                      'assets/images/loginBackground.png',
                      width: MediaQuery.of(context).size.width * .8,
                    ),
                    right: 0,
                    top: 0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ///---appBar
                      const MyCustomAppBar(
                        drawerShow: false,
                        whiteBackground: true,
                      ),

                      ///---body
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16.w, 0, 16.w, 0.h),
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                              child: Form(
                                key: _loginFormKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      LanguageConstant.login.tr,
                                      style: state.headingTextStyle,
                                    ),
                                    SizedBox(height: 6.h),
                                    Text(
                                      LanguageConstant.welcomeBackToYourAccount.tr,
                                      style: state.captionTextStyle,
                                    ),
                                    SizedBox(height: 25.h),

                                    ///---role-tabs
                                    Center(
                                      child: Container(
                                        height: 34.h,
                                        width: MediaQuery.of(context).size.width * .6,
                                        decoration:
                                            BoxDecoration(borderRadius: BorderRadius.circular(6.r), color: customTextFieldColor),
                                        child: TabBar(
                                            onTap: (index) {
                                              if (index == 0) {
                                                _loginLogic.selectedRole = 'Mentee';
                                                _loginLogic.update();
                                              } else {
                                                _loginLogic.selectedRole = 'Mentor';
                                                _loginLogic.update();
                                              }
                                            },
                                            indicator: BoxDecoration(
                                                borderRadius: BorderRadius.circular(6.r), // Creates border
                                                color: customThemeColor),
                                            indicatorSize: TabBarIndicatorSize.tab,
                                            automaticIndicatorColorAdjustment: true,
                                            controller: _loginLogic.tabController,
                                            labelColor: Colors.white,
                                            unselectedLabelColor: customThemeColor,
                                            indicatorColor: Colors.transparent,
                                            tabs: _loginLogic.loginRoleTabList),
                                      ),
                                    ),

                                    SizedBox(height: 40.h),
                                    Text(
                                      LanguageConstant.enterLoginDetails.tr,
                                      style: state.subHeadingTextStyle,
                                    ),
                                    SizedBox(height: 25.h),

                                    ///---email-field
                                    TextFormField(
                                      controller: _loginLogic.emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsetsDirectional.fromSTEB(25.w, 15.h, 25.w, 15.h),
                                        hintText: LanguageConstant.emailAddress.tr,
                                        hintStyle: state.hintTextStyle,
                                        fillColor: customTextFieldColor,
                                        filled: true,
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8.r),
                                            borderSide: const BorderSide(color: Colors.transparent)),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8.r),
                                            borderSide: const BorderSide(color: Colors.transparent)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8.r),
                                            borderSide: const BorderSide(color: customLightThemeColor)),
                                        errorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8.r),
                                            borderSide: const BorderSide(color: Colors.red)),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return LanguageConstant.fieldRequired.tr;
                                        } else if (!GetUtils.isEmail(value)) {
                                          return LanguageConstant.enterValidEmail.tr;
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    SizedBox(height: 20.h),

                                    ///---password-field

                                    TextFormField(
                                      controller: _loginLogic.passwordController,
                                      keyboardType: TextInputType.text,
                                      obscureText: obscureText!,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsetsDirectional.fromSTEB(25.w, 15.h, 25.w, 15.h),
                                        suffixIcon: InkWell(
                                          onTap: () {
                                            setState(() {
                                              obscureText = !obscureText!;
                                            });
                                          },
                                          child: Icon(obscureText! ? Icons.visibility : Icons.visibility_off,
                                              size: 20, color: const Color(0xff8085BA)),
                                        ),
                                        hintText: LanguageConstant.password.tr,
                                        hintStyle: state.hintTextStyle,
                                        fillColor: customTextFieldColor,
                                        filled: true,
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8.r),
                                            borderSide: const BorderSide(color: Colors.transparent)),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8.r),
                                            borderSide: const BorderSide(color: Colors.transparent)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8.r),
                                            borderSide: const BorderSide(color: customLightThemeColor)),
                                        errorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8.r),
                                            borderSide: const BorderSide(color: Colors.red)),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return LanguageConstant.fieldRequired.tr;
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    SizedBox(height: 24.h),

                                    ///---forgot-password
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Get.toNamed(PageRoutes.resetPassword);
                                          },
                                          child: Text(
                                            '${LanguageConstant.forgotPassword.tr}?',
                                            style: state.forgotTextStyle,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.height * .05),

                                    ///---login-button
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 30.w),
                                      child: InkWell(
                                          onTap: () {
                                            if (_loginFormKey.currentState!.validate()) {
                                              _generalController.focusOut(context);
                                              _generalController.updateFormLoaderController(true);
                                              postMethod(
                                                  context,
                                                  loginWithEmailURL,
                                                  {
                                                    'email': _loginLogic.emailController.text,
                                                    'password': _loginLogic.passwordController.text,
                                                    'role': _loginLogic.selectedRole
                                                  },
                                                  false,
                                                  loginWithEmailRepo);
                                            }
                                          },
                                          child: MyCustomBottomBar(title: LanguageConstant.login.tr, disable: false)),
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.height * .04),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          LanguageConstant.orLoginWith.tr,
                                          style: state.orTextStyle,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 28.h),

                                    ///---social-buttons
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        ///---google-button
                                        InkWell(
                                          onTap: () async {
                                            // try {
                                            //   await _googleSignIn.signIn();
                                            // } catch (error) {
                                            //   print(error);
                                            // }
                                            await loginWithGoogle();
                                          },
                                          child: Container(
                                            height: 57.h,
                                            width: 57.w,
                                            decoration: BoxDecoration(color: Colors.white, boxShadow: [
                                              BoxShadow(
                                                  color: customLightThemeColor.withOpacity(0.2),
                                                  spreadRadius: 1,
                                                  blurRadius: 30,
                                                  offset: const Offset(0, 15))
                                            ]),
                                            child: Center(child: SvgPicture.asset('assets/Icons/googleIcon.svg')),
                                          ),
                                        ),
                                        SizedBox(width: 17.w),

                                        ///---fb-button
                                        InkWell(
                                          onTap: () {
                                            loginWithFacebook();
                                          },
                                          child: Container(
                                            height: 57.h,
                                            width: 57.w,
                                            decoration: BoxDecoration(color: Colors.white, boxShadow: [
                                              BoxShadow(
                                                  color: customLightThemeColor.withOpacity(0.2),
                                                  spreadRadius: 1,
                                                  blurRadius: 30,
                                                  offset: const Offset(0, 15))
                                            ]),
                                            child: Center(child: SvgPicture.asset('assets/Icons/fbIcon.svg')),
                                          ),
                                        ),
                                        SizedBox(width: 17.w),

                                        // ///---twitter-button
                                        // Container(
                                        //   height: 57.h,
                                        //   width: 57.w,
                                        //   decoration: BoxDecoration(
                                        //       color: Colors.white,
                                        //       boxShadow: [
                                        //         BoxShadow(
                                        //             color: customLightThemeColor
                                        //                 .withOpacity(0.2),
                                        //             spreadRadius: 1,
                                        //             blurRadius: 30,
                                        //             offset: const Offset(0, 15))
                                        //       ]),
                                        //   child: Center(
                                        //       child: SvgPicture.asset(
                                        //           'assets/Icons/twitterIcon.svg')),
                                        // ),
                                      ],
                                    ),

                                    SizedBox(height: 30.h),

                                    ///---signup-route
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${LanguageConstant.doNotHaveAccount.tr}? ',
                                          style: state.descTextStyle,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Get.toNamed(PageRoutes.signUp);
                                          },
                                          child: Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(0, 5.h, 0, 5.h),
                                            child: Text(
                                              LanguageConstant.registerNow.tr,
                                              style: state.descTextStyle!
                                                  .copyWith(color: customThemeColor, decoration: TextDecoration.underline),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20.h),

                                    ///---T&C
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${LanguageConstant.byLoginYouAreAgreeWithOur.tr} ',
                                          style: state.descTextStyle,
                                        ),
                                        Text(
                                          LanguageConstant.termsAndConditions.tr,
                                          style: state.descTextStyle!
                                              .copyWith(color: customLightThemeColor, decoration: TextDecoration.underline),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20.h),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
            ),
          );
        }),
      );
    });
  }

  Future<void> loginWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login(permissions: ["email", "public_profile"]);
      // print("-=-=-=-=-=-=-=-=-=-=--=");
      // print(result.accessToken.toString());
      // print("-=-=-=-=-=-=-=-=-=-=--=");
      // if (result.accessToken == null) return;
      if (result.status == LoginStatus.success) {
        Map<String, dynamic> userData =
            await FacebookAuth.instance.getUserData(fields: "first_name,name,email,picture.width(200)");
        // print("-==-=-=-=-=-=-=-=-=-=-==-=-=-");
        // print(userData);
        //
        // print(userData["first_name"].toString());
        // print(userData["email"].toString());
        // print("-==-=-=-=-=-=-=-=-=-=-==-=-=-");
        //
        // print(userData["id"].toString());
        // print(userData.toString());
        // print(userData["picture"]["data"]["url"].toString());

        postMethod(
            context,
            loginWithGoogleURL,
            {
              'email': userData["email"],
              'name': userData["first_name"],
              'role': logic.selectedRole,
              'id': userData["id"],
            },
            false,
            loginWithEmailRepo);
      }
    } on PlatformException catch (e) {
      print("Error: ${e.toString()}");
    } on SocketException catch (e) {
      print("Error: ${e.toString()}");
    }
  }
}
