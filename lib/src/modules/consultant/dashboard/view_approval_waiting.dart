import 'package:consultant_product/route_generator.dart';
import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MentorApprovalWaitingView extends StatefulWidget {
  const MentorApprovalWaitingView({Key? key}) : super(key: key);

  @override
  _MentorApprovalWaitingViewState createState() =>
      _MentorApprovalWaitingViewState();
}

class _MentorApprovalWaitingViewState extends State<MentorApprovalWaitingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 10, 10, 0),
                    child: InkWell(
                      onTap: (){
                        Get.find<GeneralController>()
                            .storageBox.erase();
                        Navigator.pop(context);
                        Get.offAllNamed(PageRoutes.userHome);
                      },
                      child: CircleAvatar(
                        backgroundColor: customThemeColor.withOpacity(0.3),
                        radius: 30,
                        child: const Icon(Icons.logout,color: Colors.red,size: 30,),
                      ),
                    ),
                  )
                ],
              ),
              Expanded(
                  child: Align(
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  'assets/appBarLogo.svg',
                  width: MediaQuery.of(context).size.width * .35,
                ),
              )),
              Expanded(
                  child: SvgPicture.asset(
                'assets/approvalScreen.svg',
                width: MediaQuery.of(context).size.width * .7,
              )),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'your_profile_is_under'.tr,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff727377)),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'under'.tr,
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Text(
                          'review'.tr,
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: customThemeColor),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'you_will_be_notified_once_it_get_approve'.tr,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff727377)),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
