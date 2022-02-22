import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:resize/resize.dart';

import '../logic.dart';

class Medical extends StatefulWidget {
  const Medical({Key? key}) : super(key: key);

  @override
  _MedicalState createState() => _MedicalState();
}

class _MedicalState extends State<Medical> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllConsultantsLogic>(builder: (_allConsultantsLogic) {
      return Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0, 20.h, 0, 0),
        child: Wrap(
            spacing: 12.w,
            runSpacing: 18.h,
            alignment: WrapAlignment.center,
            children: List.generate(
              _allConsultantsLogic.consultantsRating.length,
              (index) => Padding(
                padding: EdgeInsets.only(top: 0.h),
                child: Container(
                  height: 220.h,
                  width: 164.w,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8.r)),
                      boxShadow: const [
                        BoxShadow(
                            color: Color(0xffF5F5F5),
                            blurRadius: 10.0,
                            spreadRadius: 5.0,
                            offset: Offset(5, -3))
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.w, 16.h, 16.w, 14.h),
                        child: Container(
                          height: 114.h,
                          width: 132.w,
                          child: Image.asset(
                              '${_allConsultantsLogic.consultantsRating[index].image}'),
                        ),
                      ),
                      Text(
                        '${_allConsultantsLogic.consultantsRating[index].title}',
                        style:
                            _allConsultantsLogic.state.consultantNameTextStyle,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        '${_allConsultantsLogic.consultantsRating[index].subTitle}',
                        style: _allConsultantsLogic
                            .state.consultantCategoryTextStyle,
                      ),
                      SizedBox(height: 6.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.star,
                            color: Color(0xffFD6620),
                            size: 16,
                          ),
                          Icon(
                            Icons.star,
                            color: Color(0xffFD6620),
                            size: 16,
                          ),
                          Icon(
                            Icons.star,
                            color: Color(0xffFD6620),
                            size: 16,
                          ),
                          Icon(
                            Icons.star,
                            color: Color(0xffFD6620),
                            size: 16,
                          ),
                          Icon(
                            Icons.star,
                            color: Color(0xffFD6620),
                            size: 16,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )),
      );
    });
  }
}
