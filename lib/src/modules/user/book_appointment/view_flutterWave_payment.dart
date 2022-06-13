import 'package:consultant_product/src/api_services/post_service.dart';
import 'package:consultant_product/src/api_services/urls.dart';
import 'package:consultant_product/src/controller/general_controller.dart';
import 'package:consultant_product/src/modules/user/book_appointment/flutter_wave_repo.dart';
import 'package:consultant_product/src/modules/user/book_appointment/logic.dart';
import 'package:consultant_product/src/modules/user/home/logic.dart';
import 'package:consultant_product/src/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:flutterwave_standard/models/requests/customer.dart';
import 'package:flutterwave_standard/models/subaccount.dart';
import 'package:flutterwave_standard/view/flutterwave_style.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:uuid/uuid.dart';

class FlutterWave extends StatefulWidget {
  const FlutterWave({Key? key}) : super(key: key);

  @override
  _FlutterWaveState createState() => _FlutterWaveState();
}

class _FlutterWaveState extends State<FlutterWave> {
  final formKey = GlobalKey<FormState>();
  final amountController = TextEditingController();
  // Get.find<BookAppointmentLogic>().selectMentorAppointmentType!.fee;
  final currencyController = TextEditingController();

  // final narrationController = TextEditingController();
  // final publicKeyController = TextEditingController();
  // final encryptionKeyController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final nameController = TextEditingController();

  String selectedCurrency = "";

  bool isTestMode = true;

  final pbk = "FLWPUBK_TEST";

  @override
  Widget build(BuildContext context) {
    currencyController.text = selectedCurrency;

    return GetBuilder<GeneralController>(builder: (_generalController) {
      return GetBuilder<BookAppointmentLogic>(builder: (_bookAppointmentLogic) {
        return ModalProgressHUD(
          inAsyncCall: _generalController.formLoaderController!,
          progressIndicator: const CircularProgressIndicator(
            color: customThemeColor,
          ),
          child: Scaffold(
            appBar: AppBar(),
            body: Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Form(
                key: formKey,
                child: ListView(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                      child: TextFormField(
                        controller: amountController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(hintText: "Amount"),
                        //  validator: (value) =>
                        //  value.isNotEmpty ? null : "Amount is required",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Amount Required';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),

                    /// Currency
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                      child: TextFormField(
                        controller: currencyController,
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(color: Colors.black),
                        readOnly: true,
                        onTap: _openBottomSheet,
                        decoration: const InputDecoration(
                          hintText: "Currency",
                        ),
                        // validator: (value) =>
                        //     value.isNotEmpty ? null : "Currency is required",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Currency Required';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),

                    /// name
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                      child: TextFormField(
                        controller: nameController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(hintText: "Name"),
                        //  validator: (value) =>
                        //  value.isNotEmpty ? null : "Amount is required",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Field is Required';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),

                    /// Email
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                      child: TextFormField(
                        controller: emailController,
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          hintText: "Email",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Email is Required';
                          } else if (!GetUtils.isEmail(value)) {
                            return 'Enter Valid Email';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),

                    /// Phone number
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                      child: TextFormField(
                        controller: phoneNumberController,
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          hintText: "Phone Number",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Phone is Required';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),

                    /// Switch
                    // Container(
                    //   width: double.infinity,
                    //   margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                    //   child: Row(
                    //     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Text("Use Debug"),
                    //       Switch(
                    //         onChanged: (value) => {
                    //           setState(() {
                    //             isTestMode = value;
                    //           })
                    //         },
                    //         value: this.isTestMode,
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Container(
                      color: Colors.blue,
                      width: double.infinity,
                      height: 50,
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                      child: ElevatedButton(
                        onPressed: _onPressed,
                        child: const Text(
                          "Make Payment",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ), // This trailing comma makes auto-formatting nicer for build methods.
          ),
        );
      });
    });
  }

  _onPressed() {
    if (formKey.currentState!.validate()) {
      _handlePaymentInitialization();
    }
  }

  _handlePaymentInitialization() async {
    final style = FlutterwaveStyle(
      appBarText: "Pay Your Consultant",
      buttonColor: Colors.white,
      buttonTextStyle: const TextStyle(
        color: Colors.deepOrangeAccent,
        fontSize: 16,
      ),
      appBarColor: const Color(0xff101276),
      dialogCancelTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 18,
      ),
      dialogContinueTextStyle: const TextStyle(
        color: Colors.red,
        fontSize: 18,
      ),
      mainBackgroundColor: Colors.indigo,
      mainTextStyle:
          const TextStyle(color: Colors.indigo, fontSize: 19, letterSpacing: 2),
      dialogBackgroundColor: Colors.greenAccent,
      appBarIcon: const Icon(Icons.message, color: Colors.purple),
      buttonText:
          "Click to Pay $selectedCurrency ${Get.find<BookAppointmentLogic>().selectMentorAppointmentType!.fee.toString()}",
      appBarTitleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 18,
      ),
    );

    final Customer customer = Customer(
        name: nameController.text,
        phoneNumber: phoneNumberController.text,
        email: emailController.text);

    final subAccounts = [
      SubAccount(
          id: "RS_1A3278129B808CB588B53A14608169AD",
          transactionChargeType: "flat",
          transactionPercentage: 25),
      SubAccount(
          id: "RS_C7C265B8E4B16C2D472475D7F9F4426A",
          transactionChargeType: "flat",
          transactionPercentage: 50)
    ];

    final Flutterwave flutterwave = Flutterwave(
        context: context,
        style: style,
        publicKey: 'FLWPUBK_TEST-361fcefccf136098e8c7a5763ce70f74-X',
        // encryptionKey: 'FLWSECK_TESTa144fbd78848',
        //  this.publicKeyController.text.trim().isEmpty
        // ? this.getPublicKey()
        // : this.publicKeyController.text.trim(),
        currency: selectedCurrency,
        txRef: const Uuid().v1(),
        amount: amountController.text.toString().trim(),
        customer: customer,
        subAccounts: subAccounts,
        paymentOptions: "card, payattitude",
        customization: Customization(title: "Test Payment"),
        redirectUrl: "https://www.google.com",
        isTestMode: isTestMode);
    final ChargeResponse response = await flutterwave.charge();
    if (response != null) {
      showLoading(response.status.toString());
      print("${response.toJson()}");
    } else {
      showLoading("No Response!");
    }
  }

  // String getPublicKey() {
  //   if (isTestMode) return "FLWPUBK_TEST--X";
  //   return "FLWPUBK-X";
  // }

  void _openBottomSheet() {
    showModalBottomSheet(
        context: this.context,
        builder: (context) {
          return this._getCurrency();
        });
  }

  Widget _getCurrency() {
    final currencies = ["USD"];
    return Container(
      height: 250,
      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
      color: Colors.white,
      child: ListView(
        children: currencies
            .map((currency) => ListTile(
                  onTap: () => {this._handleCurrencyTap(currency)},
                  title: Column(
                    children: [
                      Text(
                        currency,
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(height: 4),
                      Divider(height: 1)
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }

  _handleCurrencyTap(String currency) {
    setState(() {
      selectedCurrency = currency;
      currencyController.text = currency;
    });
    Navigator.pop(context);
  }

  Future<void> showLoading(String message) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            margin: const EdgeInsets.fromLTRB(30, 20, 30, 20),
            width: double.infinity,
            height: 50,
            child: Column(
              children: [
                Text(message),
                InkWell(
                    onTap: () {
                      Get.find<GeneralController>()
                          .updateFormLoaderController(true);
                      // postMethod(
                      //     context,
                      //     flutterWaveUrl,
                      //     {
                      //       'appointment_id': Get.find<BookAppointmentLogic>()
                      //           .selectMentorAppointmentType!
                      //           .appointmentType!
                      //           .id,
                      //     },
                      //     true,
                      //     flutterWaveRepo);
                      postMethod(
                          context,
                          bookAppointmentUrl,
                          {
                            'token': '123',
                            'mentee_id': Get.find<GeneralController>()
                                .storageBox
                                .read('userID'),
                            'mentor_id':
                                Get.find<UserHomeLogic>().selectedConsultantID,
                            'payment': Get.find<BookAppointmentLogic>()
                                .selectMentorAppointmentType!
                                .fee,
                            'payment_id': Get.find<BookAppointmentLogic>()
                                .selectedPaymentType,
                            'questions': 'Ahmad',
                            'appointment_type_string':
                                Get.find<BookAppointmentLogic>()
                                    .selectMentorAppointmentType!
                                    .appointmentType!
                                    .name,
                            'appointment_type_id':
                                Get.find<BookAppointmentLogic>()
                                    .selectMentorAppointmentType!
                                    .appointmentType!
                                    .id,
                            'date': Get.find<BookAppointmentLogic>()
                                .selectedDateForAppointment
                                .substring(0, 11),
                            'time': Get.find<BookAppointmentLogic>()
                                .selectedTimeForAppointment,
                          },
                          true,
                          flutterWaveRepo);
                    },
                    child: const Text('ok'))
              ],
            ),
          ),
        );
      },
    );
  }
}
// class FlutterWave extends StatefulWidget {
//   const FlutterWave({Key? key}) : super(key: key);
//
//   @override
//   _FlutterWaveState createState() => _FlutterWaveState();
// }
//
// class _FlutterWaveState extends State<FlutterWave> {
//   final formKey = GlobalKey<FormState>();
//   final amountController = TextEditingController();
//   final currencyController = TextEditingController();
//
//   // final narrationController = TextEditingController();
//   // final publicKeyController = TextEditingController();
//   // final encryptionKeyController = TextEditingController();
//   final emailController = TextEditingController();
//   final phoneNumberController = TextEditingController();
//   final nameController = TextEditingController();
//
//   String selectedCurrency = "";
//
//   bool isTestMode = true;
//
//   // final pbk = "FLWPUBK_TEST";
//
//   @override
//   Widget build(BuildContext context) {
//     currencyController.text = selectedCurrency;
//
//     return GetBuilder<GeneralController>(builder: (_generalController) {
//       return GetBuilder<BookAppointmentLogic>(builder: (_bookAppointmentLogic) {
//         return ModalProgressHUD(
//           inAsyncCall: _generalController.formLoaderController!,
//           progressIndicator: const CircularProgressIndicator(
//             color: customThemeColor,
//           ),
//           child: Scaffold(
//             appBar: AppBar(),
//             body: Container(
//               width: double.infinity,
//               margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
//               child: Form(
//                 key: formKey,
//                 child: ListView(
//                   children: <Widget>[
//                     Container(
//                       margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
//                       child: TextFormField(
//                         controller: amountController,
//                         textInputAction: TextInputAction.next,
//                         keyboardType: TextInputType.number,
//                         style: const TextStyle(color: Colors.black),
//                         decoration: const InputDecoration(hintText: "Amount"),
//                         //  validator: (value) =>
//                         //  value.isNotEmpty ? null : "Amount is required",
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return 'Amount Required';
//                           } else {
//                             return null;
//                           }
//                         },
//                       ),
//                     ),
//
//                     /// Currency
//                     Container(
//                       margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
//                       child: TextFormField(
//                         controller: currencyController,
//                         textInputAction: TextInputAction.next,
//                         style: const TextStyle(color: Colors.black),
//                         readOnly: true,
//                         onTap: _openBottomSheet,
//                         decoration: const InputDecoration(
//                           hintText: "Currency",
//                         ),
//                         // validator: (value) =>
//                         //     value.isNotEmpty ? null : "Currency is required",
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return 'Currency Required';
//                           } else {
//                             return null;
//                           }
//                         },
//                       ),
//                     ),
//
//                     /// name
//                     Container(
//                       margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
//                       child: TextFormField(
//                         controller: nameController,
//                         textInputAction: TextInputAction.next,
//                         keyboardType: TextInputType.name,
//                         style: const TextStyle(color: Colors.black),
//                         decoration: const InputDecoration(hintText: "Name"),
//                         //  validator: (value) =>
//                         //  value.isNotEmpty ? null : "Amount is required",
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return 'Field is Required';
//                           } else {
//                             return null;
//                           }
//                         },
//                       ),
//                     ),
//
//                     /// Email
//                     Container(
//                       margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
//                       child: TextFormField(
//                         controller: emailController,
//                         textInputAction: TextInputAction.next,
//                         style: const TextStyle(color: Colors.black),
//                         decoration: const InputDecoration(
//                           hintText: "Email",
//                         ),
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return 'Email is Required';
//                           } else if (!GetUtils.isEmail(value)) {
//                             return 'Enter Valid Email';
//                           } else {
//                             return null;
//                           }
//                         },
//                       ),
//                     ),
//
//                     /// Phone number
//                     Container(
//                       margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
//                       child: TextFormField(
//                         controller: phoneNumberController,
//                         textInputAction: TextInputAction.next,
//                         style: const TextStyle(color: Colors.black),
//                         decoration: const InputDecoration(
//                           hintText: "Phone Number",
//                         ),
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return 'Phone is Required';
//                           } else {
//                             return null;
//                           }
//                         },
//                       ),
//                     ),
//
//                     /// Switch
//                     // Container(
//                     //   width: double.infinity,
//                     //   margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
//                     //   child: Row(
//                     //     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     //     children: [
//                     //       Text("Use Debug"),
//                     //       Switch(
//                     //         onChanged: (value) => {
//                     //           setState(() {
//                     //             isTestMode = value;
//                     //           })
//                     //         },
//                     //         value: this.isTestMode,
//                     //       ),
//                     //     ],
//                     //   ),
//                     // ),
//                     Container(
//                       width: double.infinity,
//                       height: 50,
//                       margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
//                       child: RaisedButton(
//                         onPressed: _onPressed,
//                         color: Colors.blue,
//                         child: const Text(
//                           "Make Payment",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ), // This trailing comma makes auto-formatting nicer for build methods.
//           ),
//         );
//       });
//     });
//   }
//
//   _onPressed() {
//     if (formKey.currentState!.validate()) {
//       _handlePaymentInitialization();
//     }
//   }
//
//   _handlePaymentInitialization() async {
//     final style = FlutterwaveStyle(
//       appBarText: "Pay Your Consultant",
//       buttonColor: Colors.white,
//       buttonTextStyle: const TextStyle(
//         color: Colors.deepOrangeAccent,
//         fontSize: 16,
//       ),
//       appBarColor: const Color(0xff101276),
//       dialogCancelTextStyle: const TextStyle(
//         color: Colors.white,
//         fontSize: 18,
//       ),
//       dialogContinueTextStyle: const TextStyle(
//         color: Colors.red,
//         fontSize: 18,
//       ),
//       mainBackgroundColor: Colors.indigo,
//       mainTextStyle:
//           const TextStyle(color: Colors.indigo, fontSize: 19, letterSpacing: 2),
//       dialogBackgroundColor: Colors.greenAccent,
//       appBarIcon: const Icon(Icons.message, color: Colors.purple),
//       buttonText: "Click to Pay $selectedCurrency ${amountController.text}",
//       appBarTitleTextStyle: const TextStyle(
//         color: Colors.white,
//         fontSize: 18,
//       ),
//     );
//
//     final Customer customer = Customer(
//         name: nameController.text,
//         phoneNumber: phoneNumberController.text,
//         email: emailController.text);
//
//     final subAccounts = [
//       SubAccount(
//           id: "RS_1A3278129B808CB588B53A14608169AD",
//           transactionChargeType: "flat",
//           transactionPercentage: 25),
//       SubAccount(
//           id: "RS_C7C265B8E4B16C2D472475D7F9F4426A",
//           transactionChargeType: "flat",
//           transactionPercentage: 50)
//     ];
//
//     final Flutterwave flutterwave = Flutterwave(
//         context: context,
//         style: style,
//         publicKey: 'FLWPUBK_TEST-361fcefccf136098e8c7a5763ce70f74-X',
//         encryptionKey: 'FLWSECK_TESTa144fbd78848',
//         //  this.publicKeyController.text.trim().isEmpty
//         // ? this.getPublicKey()
//         // : this.publicKeyController.text.trim(),
//         currency: selectedCurrency,
//         txRef: const Uuid().v1(),
//         amount: amountController.text.toString().trim(),
//         customer: customer,
//         subAccounts: subAccounts,
//         paymentOptions: "card, payattitude",
//         customization: Customization(title: "Test Payment"),
//         redirectUrl: "https://www.google.com",
//         isTestMode: isTestMode);
//     final ChargeResponse response = await flutterwave.charge();
//     if (response != null) {
//       showLoading(response.status.toString());
//       print("${response.toJson()}");
//     } else {
//       showLoading("No Response!");
//     }
//   }
//
//   // String getPublicKey() {
//   //   if (isTestMode) return "FLWPUBK_TEST--X";
//   //   return "FLWPUBK-X";
//   // }
//
//   void _openBottomSheet() {
//     showModalBottomSheet(
//         context: this.context,
//         builder: (context) {
//           return this._getCurrency();
//         });
//   }
//
//   Widget _getCurrency() {
//     final currencies = ["NGN", "RWF", "UGX", "ZAR", "USD", "GHS"];
//     return Container(
//       height: 250,
//       margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
//       color: Colors.white,
//       child: ListView(
//         children: currencies
//             .map((currency) => ListTile(
//                   onTap: () => {this._handleCurrencyTap(currency)},
//                   title: Column(
//                     children: [
//                       Text(
//                         currency,
//                         textAlign: TextAlign.start,
//                         style: TextStyle(color: Colors.black),
//                       ),
//                       SizedBox(height: 4),
//                       Divider(height: 1)
//                     ],
//                   ),
//                 ))
//             .toList(),
//       ),
//     );
//   }
//
//   _handleCurrencyTap(String currency) {
//     setState(() {
//       selectedCurrency = currency;
//       currencyController.text = currency;
//     });
//     Navigator.pop(context);
//   }
//
//   Future<void> showLoading(String message) {
//     return showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           content: Container(
//             margin: const EdgeInsets.fromLTRB(30, 20, 30, 20),
//             width: double.infinity,
//             height: 50,
//             child: Column(
//               children: [
//                 Text(message),
//                 InkWell(
//                     onTap: () {
//                       postMethod(
//                           context,
//                           flutterWaveUrl,
//                           {
//                             'appointment_id': Get.find<BookAppointmentLogic>()
//                                 .selectedAppointmentTypeID
//                           },
//                           true,
//                           flutterWaveRepo);
//                     },
//                     child: const Text('ok'))
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
