import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/widgets/notififcation_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

import '../../controller/general_controller.dart';
import 'logic.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final logic = Get.put(ChatLogic());

  final state = Get.find<ChatLogic>().state;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Get.find<ChatLogic>().scrollController = ScrollController()
      ..addListener(Get.find<ChatLogic>().scrollListener);
  }

  @override
  void dispose() {
    Get.find<ChatLogic>()
        .scrollController!
        .removeListener(Get.find<ChatLogic>().scrollListener);
    Get.find<ChatLogic>().scrollController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (_generalController) {
      return GetBuilder<ChatLogic>(builder: (_chatLogic) {
        return GestureDetector(
            onTap: () {
              _generalController.focusOut(context);
            },
            child: Scaffold(
              backgroundColor: const Color(0xffFBFBFB),
              body: NestedScrollView(
                controller: _chatLogic.scrollController,
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    ///---header
                    SliverAppBar(
                      expandedHeight: MediaQuery.of(context).size.height * .24,
                      floating: true,
                      pinned: true,
                      snap: true,
                      elevation: 0,
                      backgroundColor: _chatLogic.isShrink
                          ? customThemeColor
                          : Colors.transparent,
                      leading: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset('assets/Icons/whiteBackArrow.svg'),
                          ],
                        ),
                      ),
                      actions: const [
                        ///---notifications

                        CustomNotificationIcon()
                      ],
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        background: Container(
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(40.r))),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/bookAppointmentAppBar.svg',
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        .27,
                                    fit: BoxFit.fill,
                                  ),
                                  SafeArea(
                                    child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16.w, 25.h, 16.w, 16.h),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 25.h,
                                            ),

                                            ///---profile-area
                                            ListTile(
                                              contentPadding:
                                                  const EdgeInsets.all(0),
                                              leading: Container(
                                                height: 49.h,
                                                width: 49.w,
                                                decoration: const BoxDecoration(
                                                    color: Colors.grey,
                                                    shape: BoxShape.circle),
                                              ),

                                              ///---name
                                              title: Text(
                                                'William Smith',
                                                style: state.userNameTextStyle,
                                              ),

                                              ///---email
                                              subtitle: Text(
                                                'Financial Advisor',
                                                style: state.categoryTextStyle,
                                              ),
                                            ),

                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .03,
                                            ),
                                          ],
                                        )),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ];
                },
                body:
                    // _chatLogic.getMessagesLoader!
                    //     ? SizedBox(
                    //         height: MediaQuery.of(context).size.height,
                    //         width: MediaQuery.of(context).size.width,
                    //         child: SingleChildScrollView(
                    //           child: Wrap(
                    //             children: List.generate(
                    //                 _chatLogic.messageList.length, (index) {
                    //               return SkeletonLoader(
                    //                 period: const Duration(seconds: 2),
                    //                 highlightColor: Colors.grey,
                    //                 direction: SkeletonDirection.ltr,
                    //                 builder: Padding(
                    //                   padding: index % 2 == 0
                    //                       ? const EdgeInsetsDirectional.fromSTEB(
                    //                           80, 7, 15, 7)
                    //                       : const EdgeInsetsDirectional.fromSTEB(
                    //                           15, 7, 80, 7),
                    //                   child: Container(
                    //                     decoration: BoxDecoration(
                    //                         color: index % 2 == 0
                    //                             ? customThemeColor
                    //                             : customLightThemeColor,
                    //                         borderRadius: index % 2 == 0
                    //                             ? const BorderRadius.only(
                    //                                 bottomLeft: Radius.circular(20),
                    //                                 topLeft: Radius.circular(20),
                    //                                 topRight: Radius.circular(20),
                    //                               )
                    //                             : const BorderRadius.only(
                    //                                 bottomRight:
                    //                                     Radius.circular(20),
                    //                                 topLeft: Radius.circular(20),
                    //                                 topRight: Radius.circular(20),
                    //                               )),
                    //                     child: Padding(
                    //                       padding:
                    //                           const EdgeInsetsDirectional.all(14.0),
                    //                       child: Container(
                    //                         color: Colors.white,
                    //                         height: 50,
                    //                         width: double.infinity,
                    //                       ),
                    //                     ),
                    //                   ),
                    //                 ),
                    //               );
                    //             }),
                    //           ),
                    //         ),
                    //       )
                    //     :

                    Stack(
                  children: [
                    ///---message-list
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          // Padding(
                          //   padding: const EdgeInsetsDirectional.fromSTEB(
                          //       15, 0, 15, 10),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       InkWell(
                          //         onTap: () {
                          //           Get.find<ChatLogic>()
                          //               .messageScrollController
                          //               .animateTo(
                          //                   Get.find<ChatLogic>()
                          //                       .messageScrollController
                          //                       .position
                          //                       .maxScrollExtent,
                          //                   curve: Curves.easeOut,
                          //                   duration: const Duration(
                          //                       milliseconds: 500));
                          //         },
                          //         child: Text(
                          //           'answer_question'.tr,
                          //           style: state.messageTextStyle,
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          Expanded(
                              child: ListView(
                            children: List.generate(20, (index) {
                              return Padding(
                                padding: index % 2 == 0
                                    ? const EdgeInsetsDirectional.fromSTEB(
                                        80, 0, 15, 7)
                                    : const EdgeInsetsDirectional.fromSTEB(
                                        15, 15, 80, 7),
                                child: Row(
                                  mainAxisAlignment: index % 2 == 0
                                      ? MainAxisAlignment.end
                                      : MainAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: index % 2 == 0
                                                ? customTextFieldColor
                                                : customLightThemeColor,
                                            borderRadius: index % 2 == 0
                                                ? const BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(20),
                                                    topLeft:
                                                        Radius.circular(20),
                                                    topRight:
                                                        Radius.circular(20),
                                                  )
                                                : const BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(20),
                                                    topLeft:
                                                        Radius.circular(20),
                                                    topRight:
                                                        Radius.circular(20),
                                                  )),
                                        child: Padding(
                                          padding:
                                              const EdgeInsetsDirectional.all(
                                                  14.0),
                                          child: Text(
                                              'This is my Message jgg tgjrt  tjrtt trtjrt rjer trtjt  tjrt rrjer jtjet tret t tjet ej',
                                              style: index % 2 == 0
                                                  ? state.replyTextStyle
                                                  : state.messageTextStyle!),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          )),
                          const SizedBox(
                            height: 65,
                          )
                        ],
                      ),
                    ),

                    ///---text-field
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(15, 0, 15, 15),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _chatLogic.messageController,
                                onTap: () {
                                  Future.delayed(const Duration(seconds: 1))
                                      .whenComplete(() => Get.find<ChatLogic>()
                                          .messageScrollController
                                          .animateTo(
                                              Get.find<ChatLogic>()
                                                  .messageScrollController
                                                  .position
                                                  .maxScrollExtent,
                                              curve: Curves.easeOut,
                                              duration: const Duration(
                                                  milliseconds: 500)));
                                },
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                onChanged: (value) {
                                  if (_chatLogic
                                      .messageController.text.isEmpty) {
                                    _chatLogic.updateShowSendIcon(false);
                                  } else {
                                    _chatLogic.updateShowSendIcon(true);
                                  }
                                },
                                textDirection:
                                    _generalController.isDirectionRTL(context)
                                        ? TextDirection.rtl
                                        : TextDirection.ltr,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  filled: true,
                                  fillColor: customThemeColor,
                                  hintText: 'Your Text Here....',
                                  hintStyle: state.textFieldTextStyle,
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      borderSide: const BorderSide(
                                          color: Colors.white)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      borderSide: const BorderSide(
                                          color: customThemeColor)),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      borderSide:
                                          const BorderSide(color: Colors.red)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      borderSide: const BorderSide(
                                          color: Colors.white)),
                                ),
                              ),
                            ),
                            _chatLogic.showSendIcon!
                                ? Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            10, 0, 0, 0),
                                    child: InkWell(
                                      onTap: () {
                                        _chatLogic.updateMessageList(
                                            _chatLogic.messageController.text);
                                      },
                                      // onTap: () {
                                      //   Get.find<GeneralController>()
                                      //       .notificationRouteApp = null;
                                      //   postMethod(
                                      //       context,
                                      //       sendMessageUrl,
                                      //       {
                                      //         'token': '123',
                                      //         'receiver_id': Get.find<
                                      //                 PusherChatLogic>()
                                      //             .receiverMessageGetId,
                                      //         'sender_id': Get.find<
                                      //                 PusherChatLogic>()
                                      //             .senderMessageGetId,
                                      //         'message': _chatLogic
                                      //             .messageController.text
                                      //       },
                                      //       true,
                                      //       sendMessagesRepo);
                                      //  },
                                      child: const CircleAvatar(
                                        radius: 20,
                                        child: Icon(
                                          Icons.send,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                        backgroundColor: customThemeColor,
                                      ),
                                    ),
                                  )
                                : const SizedBox()
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
      });
    });
  }
}
