import 'package:consultant_product/src/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

import '../../controller/general_controller.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../../widgets/custom_sliver_app_bar.dart';
import 'logic.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({Key? key}) : super(key: key);

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  final logic = Get.put(ContactUsLogic());

  final state = Get.find<ContactUsLogic>().state;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Get.find<ContactUsLogic>().scrollController = ScrollController()
      ..addListener(Get.find<ContactUsLogic>().scrollListener);
  }

  @override
  void dispose() {
    Get.find<ContactUsLogic>()
        .scrollController!
        .removeListener(Get.find<ContactUsLogic>().scrollListener);
    Get.find<ContactUsLogic>().scrollController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (_generalController) {
      return GetBuilder<ContactUsLogic>(builder: (_contactUsLogic) {
        return GestureDetector(
          onTap: () {
            _generalController.focusOut(context);
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: const Color(0xffFBFBFB),
            body: NestedScrollView(
                controller: _contactUsLogic.scrollController,
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    ///---header
                    MyCustomSliverAppBar(
                      heading: 'Contact Us',
                      subHeading: "We are just one step away. reach out ",
                      isShrink: _contactUsLogic.isShrink,
                    ),
                  ];
                },
                body: Container(
                    color: const Color(0xffFCFCFC),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(16.w, 0, 16.w, 0),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(height: 20.h),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * .65,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    // color: Colors.grey,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(15.r))),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      15.w, 0, 15.w, 0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 25.h),

                                      /// Adress
                                      Container(
                                        decoration: BoxDecoration(
                                            color: customThemeColor,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8.r))),
                                        height: 65.h,
                                        child: ListTile(
                                          minLeadingWidth: 20.w,
                                          minVerticalPadding: 8.h,
                                          // horizontalTitleGap: 6.w,
                                          leading: SvgPicture.asset(
                                            'assets/Icons/location.svg',
                                          ),
                                          title: Text(
                                            'Address',
                                            style: state.titleTextStyle,
                                          ),
                                          subtitle: Text(
                                            '102-c, Peoples Colony, Faisalabad',
                                            style: state.subTitleTextStyle,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 8.h),

                                      /// Call
                                      Container(
                                        decoration: BoxDecoration(
                                            color: customThemeColor,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8.r))),
                                        height: 65.h,
                                        child: ListTile(
                                          minLeadingWidth: 20.w,
                                          minVerticalPadding: 8.h,
                                          // horizontalTitleGap: 6.w,
                                          leading: SvgPicture.asset(
                                            'assets/Icons/drawerContactUsIcon.svg',
                                          ),
                                          title: Text(
                                            'Call Us',
                                            style: state.titleTextStyle,
                                          ),
                                          subtitle: Text(
                                            '+92-100235555',
                                            style: state.subTitleTextStyle,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 8.h),

                                      /// Email
                                      Container(
                                        decoration: BoxDecoration(
                                            color: customThemeColor,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8.r))),
                                        height: 65.h,
                                        child: ListTile(
                                          minLeadingWidth: 20.w,
                                          minVerticalPadding: 8.h,
                                          // horizontalTitleGap: 6.w,
                                          leading: SvgPicture.asset(
                                            'assets/Icons/message.svg',
                                          ),
                                          title: Text(
                                            'Email Us',
                                            style: state.titleTextStyle,
                                          ),
                                          subtitle: Text(
                                            'info@consultant.com',
                                            style: state.subTitleTextStyle,
                                          ),
                                        ),
                                      ),

                                      SizedBox(height: 20.h),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Name',
                                            style: state.subTitleTextStyle
                                                ?.copyWith(
                                                    color: customTextGreyColor),
                                          ),

                                          /// Name form field
                                          TextFormField(
                                            enabled: true,
                                            keyboardType: TextInputType.name,
                                            inputFormatters: [
                                              FilteringTextInputFormatter.allow(
                                                  RegExp("[a-z A-Z ]"))
                                            ],
                                          ),
                                          SizedBox(height: 20.h),
                                          Text(
                                            'Email',
                                            style: state.subTitleTextStyle
                                                ?.copyWith(
                                                    color: customTextGreyColor),
                                          ),

                                          /// email form field
                                          TextFormField(
                                            enabled: true,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                          ),
                                          SizedBox(height: 20.h),

                                          Text(
                                            'Message',
                                            style: state.subTitleTextStyle
                                                ?.copyWith(
                                                    color: customTextGreyColor),
                                          ),

                                          /// message form field
                                          TextFormField(
                                            enabled: true,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0.h,
                        left: 15.w,
                        right: 15.w,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 20.h),
                          child: InkWell(
                              onTap: () {},
                              child: const MyCustomBottomBar(
                                  title: 'Submit', disable: false)),
                        ),
                      ),
                    ]))),
          ),
        );
      });
    });
  }
}
