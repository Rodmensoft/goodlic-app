import 'package:consultant_product/src/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

import '../../controller/general_controller.dart';
import 'logic.dart';

class CreatedPasswordPage extends StatefulWidget {
  const CreatedPasswordPage({Key? key}) : super(key: key);

  @override
  State<CreatedPasswordPage> createState() => _CreatedPasswordPageState();
}

class _CreatedPasswordPageState extends State<CreatedPasswordPage> {
  final logic = Get.put(CreatedPasswordLogic());

  final state = Get.find<CreatedPasswordLogic>().state;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (_generalController) {
      return GestureDetector(
        onTap: () {
          _generalController.focusOut(context);
        },
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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // ///---appBar
                  // const MyCustomAppBar(
                  //   drawerShow: false,
                  //   whiteBackground: true,
                  // ),

                  ///---body
                  SizedBox(height: MediaQuery.of(context).size.height * .23),
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(16.w, 0, 16.w, 0.h),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                'assets/images/successfull.png',
                                height: 177.h,
                                width: 120.w,
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .02),
                              Text(
                                'Password Created',
                                style: state.headingTextStyle,
                              ),
                              SizedBox(height: 12.h),
                              Text(
                                'Successfully',
                                style: state.subheadingTextStyle,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.24,
                              ),
                              const CustomButton(title: 'Confirm')
                            ],
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
    });
  }
}
