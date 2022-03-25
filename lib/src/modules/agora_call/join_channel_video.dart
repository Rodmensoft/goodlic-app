import 'dart:async';
import 'dart:developer';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as rtc_local_view;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as rtc_remote_view;
import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:resize/resize.dart';
import 'agora.config.dart' as config;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// MultiChannel Example
class JoinChannelVideo extends StatefulWidget {
  const JoinChannelVideo({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<JoinChannelVideo> {
  late final RtcEngine _engine;

  bool isJoined = false, switchCamera = true, switchRender = true;
  List<int> remoteUid = [];

  _callEndCheckMethod() {
    log('----->>>CallEndCheck');
    if (callEnd == 2) {
      _leaveChannel();
      Get.back();
    }
  }

  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      _callEndCheckMethod();
    });
    if (Get.find<GeneralController>().callerType == 1) {
      Future.delayed(
        const Duration(seconds: 2),
      ).whenComplete(() => _joinChannel());
    }

    _initEngine();
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
    _engine.destroy();
  }

  int? callEnd = 0;

  _initEngine() async {
    _engine = await RtcEngine.createWithConfig(RtcEngineConfig(config.appId));
    _addListeners();

    await _engine.enableVideo();
    await _engine.startPreview();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(ClientRole.Broadcaster);
  }

  _addListeners() {
    _engine.setEventHandler(RtcEngineEventHandler(
      joinChannelSuccess: (channel, uid, elapsed) {
        log('joinChannelSuccess--------------->>> $channel $uid $elapsed');
        setState(() {
          isJoined = true;
        });
      },
      userJoined: (uid, elapsed) {
        log('userJoined--------------->>>  $uid $elapsed');
        setState(() {
          remoteUid.add(uid);
          callEnd = 1;
        });
      },
      userOffline: (uid, reason) {
        log('userOffline--------------->>>  $uid $reason');
        setState(() {
          remoteUid.removeWhere((element) => element == uid);
          if (callEnd == 1) {
            callEnd = 2;
          }
        });
        if (remoteUid.isEmpty) {}
      },
      leaveChannel: (stats) {
        log('leaveChannel--------------->>> ${stats.toJson()}');
        setState(() {
          isJoined = false;
          remoteUid.clear();
        });
      },
    ));
  }

  Future<dynamic> _joinChannel() async {
    log('---------->>> joined-start');
    if (defaultTargetPlatform == TargetPlatform.android) {
      await [Permission.microphone, Permission.camera].request();
    }
    await _engine.joinChannel(
        Get.find<GeneralController>().tokenForCall,
        Get.find<GeneralController>().channelForCall!,
        null,
        Get.find<GeneralController>().callerType);
    _addListeners();
  }

  _leaveChannel() async {
    await _engine.leaveChannel();
  }

  _switchCamera() {
    _engine.switchCamera().then((value) {
      setState(() {
        switchCamera = !switchCamera;
      });
    }).catchError((err) {
      log('switchCamera--------------->>> $err');
    });
  }

  _switchRender() {
    setState(() {
      switchRender = !switchRender;
      remoteUid = List.of(remoteUid.reversed);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: _renderVideo(),
        onWillPop: () async {
          return false;
        });
  }

  void _onCallEnd(BuildContext context) {
    Navigator.pop(context);
  }

  bool muted = false;

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    _engine.muteLocalAudioStream(muted);
  }

  void _onSwitchCamera() {
    _engine.switchCamera();
  }

  Widget _toolbar() {

    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
            onPressed: _onToggleMute,
            child: Icon(
              muted ? Icons.mic_off : Icons.mic,
              color: muted ? Colors.white : customThemeColor,
              size: 20.0,
            ),
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: muted ? customThemeColor : Colors.white,
            padding: const EdgeInsets.all(12.0),
          ),
          RawMaterialButton(
            onPressed: () {
              _leaveChannel();
              // _onCallEnd(context);
              Get.back();
            },
            child: const Icon(
              Icons.clear,
              color: Colors.white,
              size: 35.0,
            ),
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.redAccent,
            padding: const EdgeInsets.all(15.0),
          ),
          RawMaterialButton(
            onPressed: _onSwitchCamera,
            child: const Icon(
              Icons.switch_camera,
              color: customThemeColor,
              size: 20.0,
            ),
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.white,
            padding: const EdgeInsets.all(12.0),
          )
        ],
      ),
    );
  }

  _renderVideo() {
    return Container(
      color: Colors.white,
      height: double.infinity,
      width: double.infinity,
      child: SafeArea(
        child: remoteUid.isEmpty && callEnd == 0
            ? Get.find<GeneralController>().callerType == 2
                ? _receiverView()
                : _ringingView()
            : Stack(
                children: [
                  remoteUid.isEmpty
                      ? const SizedBox()
                      : rtc_remote_view.SurfaceView(
                          uid: remoteUid[0],
                        ),
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: rtc_local_view.SurfaceView(),
                  ),
                  _toolbar()
                ],
              ),
      ),
    );
  }

  _ringingView() {
    return Scaffold(
      body: Container(
        color: Colors.white,
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            isJoined
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                    child: Text(
                      'RINGING.....',
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: customThemeColor),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                    child: Text(
                      'CALLING.....',
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: customThemeColor),
                    ),
                  ),
            Expanded(child: Image.asset('assets/calling.gif')),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: RawMaterialButton(
                    onPressed: () {
                      _leaveChannel();
                      _onCallEnd(context);
                    },
                    child: const Icon(
                      Icons.clear,
                      color: Colors.white,
                      size: 35.0,
                    ),
                    shape: const CircleBorder(),
                    elevation: 2.0,
                    fillColor: Colors.redAccent,
                    padding: const EdgeInsets.all(15.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _receiverView() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(Icons.arrow_back_ios, color: customThemeColor)),
        title: SvgPicture.asset(
          'assets/appBarLogo.svg',
          width: MediaQuery.of(context).size.width * .1,
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        height: double.infinity,
        width: double.infinity,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: SvgPicture.asset(
                'assets/callAlert.svg',
                width: MediaQuery.of(context).size.width * .6,
              )),
              Text(
                'Call Alert',
                style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: customThemeColor),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'you are receiving a call from ${Get.find<GeneralController>().storageBox.read('userRole').toString().toUpperCase() == 'MENTEE'
                    ?'MENTOR'
                    :'MENTEE'}',
                style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                    color: customLightThemeColor),
              ),
              Expanded(
                  child: Row(
                    children: [
                      // Expanded(
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(0.0),
                      //     child: RawMaterialButton(
                      //       onPressed: () {
                      //         setState(() {
                      //           callEnd = 3;
                      //         });
                      //         // _onCallEnd(context);
                      //       },
                      //       child: const Icon(
                      //         Icons.clear,
                      //         color: Colors.white,
                      //         size: 35.0,
                      //       ),
                      //       shape: const CircleBorder(),
                      //       elevation: 2.0,
                      //       fillColor: Colors.redAccent,
                      //       padding: const EdgeInsets.all(15.0),
                      //     ),
                      //   ),
                      // ),
                      Expanded(
                        child: InkWell(
                            onTap: () {
                              _joinChannel();
                            },
                            child: Image.asset('assets/calling.gif')),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class CallWaitingView extends StatefulWidget {
  const CallWaitingView({Key? key}) : super(key: key);

  @override
  _CallWaitingViewState createState() => _CallWaitingViewState();
}

class _CallWaitingViewState extends State<CallWaitingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
              child: Text(
                'CALLING.....',
                style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: customThemeColor),
              ),
            ),
            Expanded(child: Image.asset('assets/calling.gif')),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: RawMaterialButton(
                    onPressed: () {
                      Get.find<GeneralController>().updateGoForCall(false);
                      Get.back();
                    },
                    child: const Icon(
                      Icons.clear,
                      color: Colors.white,
                      size: 35.0,
                    ),
                    shape: const CircleBorder(),
                    elevation: 2.0,
                    fillColor: Colors.redAccent,
                    padding: const EdgeInsets.all(15.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
