import 'dart:async';
import 'dart:developer';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:resize/resize.dart';

import 'agora.config.dart' as config;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
              body: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Text(
                        Get.find<GeneralController>()
                                    .storageBox
                                    .read('userRole')
                                    .toString()
                                    .toUpperCase() ==
                                'MENTOR'
                            ? 'MENTEE'
                            : 'MENTOR',
                        style: TextStyle(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.bold,
                            color: customThemeColor),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: Stack(
                          children: [
                            Align(
                                alignment: Alignment.center,
                                child: SvgPicture.asset(
                                  'assets/appBarLogo.svg',
                                  width: MediaQuery.of(context).size.width * .7,
                                )),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(40)),
                                  color: Colors.white.withOpacity(0.7)),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(40)),
                                  color: customThemeColor.withOpacity(0.4)),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                                          radius: 30,
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
                                          radius: 30,
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
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              // bottomNavigationBar: SafeArea(
              //   child: Container(
              //     width: MediaQuery.of(context).size.width,
              //     height: 80,
              //     decoration: const BoxDecoration(
              //     color: customThemeColor,
              //     borderRadius: BorderRadius.vertical(top: Radius.circular(20))
              //     ),
              //     child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceAround,
              //     children: [
              //       InkWell(
              //         onTap: (){
              //           _switchSpeakerphone();
              //         },
              //         child:  CircleAvatar(
              //           radius: 25,
              //           backgroundColor: enableSpeakerphone
              //               ?Colors.white24
              //               :Colors.transparent,
              //           child: Icon(
              //             enableSpeakerphone
              //                 ?Icons.volume_off
              //                 :Icons.volume_up,
              //             color: Colors.white,
              //             size: 25,
              //           ),
              //         ),
              //       ),
              //       InkWell(
              //         onTap: (){
              //           _switchMicrophone();
              //         },
              //         child:  CircleAvatar(
              //           radius: 25,
              //           backgroundColor: !openMicrophone
              //               ?Colors.white24
              //               :Colors.transparent,
              //           child: Icon(
              //             openMicrophone
              //                 ?Icons.mic
              //                 :Icons.mic_off,
              //             color: Colors.white,
              //             size: 25,
              //           ),
              //         ),
              //       ),
              //       InkWell(
              //         onTap: (){
              //           _leaveChannel();
              //           Get.back();
              //         },
              //         child: const CircleAvatar(
              //           radius: 25,
              //           backgroundColor: Colors.red,
              //           child: Icon(
              //             Icons.call_end,
              //             color: Colors.white,
              //             size: 25,
              //           ),
              //         ),
              //       ),
              //     ],
              //     ),
              //   ),
              // ),
            ),
    );
  }

  void _onCallEnd(BuildContext context) {
    Navigator.pop(context);
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
                'you are receiving a call from ${Get.find<GeneralController>().storageBox.read('userRole').toString().toUpperCase() == 'MENTEE' ? 'MENTOR' : 'MENTEE'}',
                style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                    color: customLightThemeColor),
              ),
              Expanded(
                  child: Row(
                children: [
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
