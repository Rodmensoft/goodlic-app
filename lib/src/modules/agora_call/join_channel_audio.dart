import 'dart:async';
import 'dart:developer';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:consultant_product/multi_language/language_constants.dart';
import 'package:consultant_product/src/api_services/urls.dart';
import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/agora_call/agora_logic.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:consultant_product/src/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:resize/resize.dart';

import 'agora.config.dart' as config;

/// JoinChannelAudio Example

class JoinChannelAudio extends StatefulWidget {
  final String? channelId;

  const JoinChannelAudio({Key? key, this.channelId}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<JoinChannelAudio> {
  late final RtcEngine _engine;
  bool isJoined = false,
      openMicrophone = true,
      enableSpeakerphone = false,
      playEffect = false;

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
    _initEngine();
    if (Get.find<GeneralController>().callerType == 1) {
      Future.delayed(
        const Duration(seconds: 2),
      ).whenComplete(() => _joinChannel());
    }
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
    _engine.destroy();
  }

  int? callEnd = 0;

  _initEngine() async {
    _engine = await RtcEngine.createWithContext(RtcEngineContext(config.appId));
    _addListeners();

    await _engine.enableAudio();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(ClientRole.Broadcaster);
  }

  _addListeners() {
    _engine.setEventHandler(RtcEngineEventHandler(
      joinChannelSuccess: (channel, uid, elapsed) {
        log('joinAudioChannelSuccess--------------->>> $channel $uid $elapsed');
        setState(() {
          isJoined = true;
        });
      },
      leaveChannel: (stats) async {
        log('leaveChannel--------------->>> ${stats.toJson()}');
        setState(() {
          isJoined = false;
        });
      },
      userJoined: (uid, elapsed) {
        log('userJoined--------------->>>  $uid $elapsed');
        setState(() {
          callEnd = 1;
        });
      },
      userOffline: (uid, reason) {
        log('userOffline--------------->>>  $uid $reason');
        setState(() {
          if (callEnd == 1) {
            callEnd = 2;
          }
        });
      },
    ));
  }

  _joinChannel() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      await Permission.microphone.request();
    }

    await _engine
        .joinChannel(
            Get.find<GeneralController>().tokenForCall,
            Get.find<GeneralController>().channelForCall!,
            null,
            Get.find<GeneralController>().callerType)
        .catchError((onError) {
      log('error ${onError.toString()}');
    });
  }

  _leaveChannel() async {
    await _engine.leaveChannel();
  }

  _switchMicrophone() {
    _engine.enableLocalAudio(!openMicrophone).then((value) {
      setState(() {
        openMicrophone = !openMicrophone;
      });
    }).catchError((err) {
      log('enableLocalAudio $err');
    });
  }

  _switchSpeakerphone() {
    _engine.setEnableSpeakerphone(!enableSpeakerphone).then((value) {
      setState(() {
        enableSpeakerphone = !enableSpeakerphone;
      });
    }).catchError((err) {
      log('setEnableSpeakerphone $err');
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: callEnd == 0
          ? Get.find<GeneralController>().callerType == 2
              ? _receiverView()
              : _ringingView()
          : Scaffold(
              body: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      customThemeColor,
                      customLightThemeColor,
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .1,
                      ),
                      Container(
                        height: 130.h,
                        width: 130.w,
                        decoration: const BoxDecoration(
                            color: Colors.transparent,
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/Icons/splash_logo.png'))),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .2,
                      ),
                      Expanded(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ///---mute
                                  InkWell(
                                    onTap: () {
                                      _switchMicrophone();
                                    },
                                    child: CircleAvatar(
                                      radius: 30.r,
                                      backgroundColor: !openMicrophone
                                          ? customThemeColor
                                          : Colors.white,
                                      child: Icon(
                                        openMicrophone
                                            ? Icons.mic
                                            : Icons.mic_off,
                                        color: openMicrophone
                                            ? customThemeColor
                                            : Colors.white,
                                        size: 25,
                                      ),
                                    ),
                                  ),

                                  ///---speaker
                                  InkWell(
                                    onTap: () {
                                      _switchSpeakerphone();
                                    },
                                    child: CircleAvatar(
                                      radius: 30.r,
                                      backgroundColor: enableSpeakerphone
                                          ? customThemeColor
                                          : Colors.white,
                                      child: Icon(
                                        enableSpeakerphone
                                            ? Icons.volume_off
                                            : Icons.volume_up,
                                        color: enableSpeakerphone
                                            ? Colors.white
                                            : customThemeColor,
                                        size: 25,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  _leaveChannel();
                                  Get.back();
                                },
                                child: const CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.red,
                                  child: Icon(
                                    Icons.call_end,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  void _onCallEnd(BuildContext context) {
    Navigator.pop(context);
  }

  _ringingView() {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              customThemeColor,
              customLightThemeColor,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .1,
              ),
              Container(
                height: 130.h,
                width: 130.w,
                decoration: const BoxDecoration(
                    color: Colors.transparent,
                    image: DecorationImage(
                        image: AssetImage('assets/Icons/splash_logo.png'))),
              ),
              isJoined
                  ? Padding(
                      padding: EdgeInsets.fromLTRB(0, 27.h, 0, 0),
                      child: Text(
                        'Ringing',
                        style: TextStyle(
                            fontSize: 20.sp,
                            fontFamily: SarabunFontFamily.extraBold,
                            color: Colors.white),
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.fromLTRB(0, 27.h, 0, 0),
                      child: Text(
                        'Calling',
                        style: TextStyle(
                            fontSize: 20.sp,
                            fontFamily: SarabunFontFamily.extraBold,
                            color: Colors.white),
                      ),
                    ),
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
      ),
    );
  }

  _receiverView() {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              customThemeColor,
              customLightThemeColor,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: SvgPicture.asset(
                'assets/images/callAlert.svg',
                width: MediaQuery.of(context).size.width * .6,
              )),
              Text(
                'Call Alert',
                style: TextStyle(
                    fontSize: 20.sp,
                    fontFamily: SarabunFontFamily.bold,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '${LanguageConstant.youAreReceivingCallFrom.tr}'
                '${Get.find<GeneralController>().storageBox.read('userRole').toString().toUpperCase() == 'MENTEE'
                    ? 'CONSULTANT' : 'USER'}',
                style: TextStyle(
                    fontSize: 15.sp,
                    fontFamily: SarabunFontFamily.regular,
                    color: Colors.white),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.red,
                              radius: 35.r,
                              child: const Icon(
                                Icons.clear,
                                color: Colors.white,
                                size: 35.0,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              _joinChannel();
                            },
                            child: CircleAvatar(
                              backgroundColor: customGreenColor,
                              radius: 35.r,
                              child: const Icon(
                                Icons.call,
                                color: Colors.white,
                                size: 35.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class basicAudioClass extends StatefulWidget {
  const basicAudioClass({Key? key}) : super(key: key);

  @override
  _basicAudioClassState createState() => _basicAudioClassState();
}

class _basicAudioClassState extends State<basicAudioClass> {
  late final RtcEngine _engine;
  bool isJoined = false,
      openMicrophone = true,
      enableSpeakerphone = false,
      playEffect = false;
  bool _enableInEarMonitoring = false;
  double _recordingVolume = 0, _playbackVolume = 0, _inEarMonitoringVolume = 0;

  _switchMicrophone() {
    _engine.enableLocalAudio(!openMicrophone).then((value) {
      setState(() {
        openMicrophone = !openMicrophone;
      });
    }).catchError((err) {
      log('enableLocalAudio $err');
    });
  }

  _switchSpeakerphone() {
    _engine.setEnableSpeakerphone(!enableSpeakerphone).then((value) {
      setState(() {
        enableSpeakerphone = !enableSpeakerphone;
      });
    }).catchError((err) {
      log('setEnableSpeakerphone $err');
    });
  }

  _switchEffect() async {
    if (playEffect) {
      _engine.stopEffect(1).then((value) {
        setState(() {
          playEffect = false;
        });
      }).catchError((err) {
        log('stopEffect $err');
      });
    } else {
      _engine
          .playEffect(
              1,
              await (_engine.getAssetAbsolutePath("assets/Sound_Horizon.mp3")
                  as FutureOr<String>),
              -1,
              1,
              1,
              100,
              true)
          .then((value) {
        setState(() {
          playEffect = true;
        });
      }).catchError((err) {
        log('playEffect $err');
      });
    }
  }

  _onChangeInEarMonitoringVolume(double value) {
    setState(() {
      _inEarMonitoringVolume = value;
    });
    _engine.setInEarMonitoringVolume(value.toInt());
  }

  _toggleInEarMonitoring(value) {
    setState(() {
      _enableInEarMonitoring = value;
    });
    _engine.enableInEarMonitoring(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: _switchMicrophone,
                        child: Text(
                          'Microphone ${openMicrophone ? 'on' : 'off'}',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _switchSpeakerphone,
                        child: Text(
                          enableSpeakerphone ? 'Speakerphone' : 'Earpiece',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _switchEffect,
                        child: Text(
                          '${playEffect ? 'Stop' : 'Play'} effect',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'RecordingVolume:',
                            style: TextStyle(color: Colors.black),
                          ),
                          Slider(
                            value: _recordingVolume,
                            min: 0,
                            max: 400,
                            divisions: 5,
                            label: 'RecordingVolume',
                            onChanged: (double value) {
                              setState(() {
                                _recordingVolume = value;
                              });
                              _engine
                                  .adjustRecordingSignalVolume(value.toInt());
                            },
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'PlaybackVolume:',
                            style: TextStyle(color: Colors.black),
                          ),
                          Slider(
                            value: _playbackVolume,
                            min: 0,
                            max: 400,
                            divisions: 5,
                            label: 'PlaybackVolume',
                            onChanged: (double value) {
                              setState(() {
                                _playbackVolume = value;
                              });
                              _engine.adjustPlaybackSignalVolume(value.toInt());
                            },
                          )
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(mainAxisSize: MainAxisSize.min, children: [
                            Text(
                              'InEar Monitoring Volume:',
                              style: TextStyle(color: Colors.black),
                            ),
                            Switch(
                              value: _enableInEarMonitoring,
                              onChanged: _toggleInEarMonitoring,
                              activeTrackColor: Colors.grey[350],
                              activeColor: Colors.white,
                            )
                          ]),
                          if (_enableInEarMonitoring)
                            SizedBox(
                                width: 300,
                                child: Slider(
                                  value: _inEarMonitoringVolume,
                                  min: 0,
                                  max: 100,
                                  divisions: 5,
                                  label: 'InEar Monitoring Volume',
                                  onChanged: _onChangeInEarMonitoringVolume,
                                ))
                        ],
                      ),
                    ],
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                ))
          ],
        ),
      ),
    );
  }
}
