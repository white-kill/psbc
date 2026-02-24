import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/component/text_field_widget.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../../config/app_config.dart';
import 'hdzq_logic.dart';
import 'hdzq_state.dart';

class LifeHdzqPage extends BaseStateless {
  LifeHdzqPage({Key? key}) : super(key: key,title: '活动专区');

  final HdzqLogic logic = Get.put(HdzqLogic());
  final HdzqState state = Get.find<HdzqLogic>().state;

  @override
  Widget initBody(BuildContext context) {
    return Column(

      children: [

        Container(
          color: Colors.white,
          height: 45.w,
          child:Row(
            children: [
              SizedBox(width: 16.w),
              Row(
                children: [
                  Image(
                    image: 'nav_left_loc'.png3x,
                    width: 24.w,
                    height: 24.w,
                    color: Colors.black,
                  ),
                  BaseText(
                    text:  AppConfig.config.abcLogic.memberInfo.city,
                    color: Colors.black,
                    fontSize: 14.sp,
                  ),
                ],
              ),
              SizedBox(width: 12.w),
              Container(
                width: 1.sw - 100.w,
                height: 32.w,
                margin: EdgeInsets.only(right: 15.w),
                decoration: BoxDecoration(
                    color: Color(0xffdfdfdf).withOpacity(0.4),
                    borderRadius: BorderRadius.all(Radius.circular(20.w))),
                child: Row(
                  children: [
                    Image(
                      image: 'home_search_left'.png3x,
                      width: 18.w,
                      height: 18.w,
                    ).withPadding(left: 10.w, right: 6.w),
                    Container(width: 0.5, height: 18.w, color: Color(0xffdfdfdf)),
                    SizedBox(
                      width: 6.w,
                    ),
                    TextFieldWidget(
                      hintText: '输入搜索词',

                    ).expanded(),
                    SizedBox(
                      width: 8.w,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        SizedBox(width: 12.w),
        ListView(
          padding: EdgeInsets.zero,
          children: [
            Image(
              image: 'hdzq'.png3x,
              fit: BoxFit.fitWidth,
              width: 1.sw,
            )
          ],
        ).expanded()

      ],
    );
  }
}
