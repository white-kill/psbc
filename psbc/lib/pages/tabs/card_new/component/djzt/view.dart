import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:psbc/config/app_config.dart';
import 'package:psbc/config/abc_config/psbc_logic.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import 'logic.dart';
import 'state.dart';

class DjztPage extends BaseStateless {
  DjztPage({Key? key}) : super(title: '活动礼遇');

  final DjztLogic logic = Get.put(DjztLogic());
  final DjztState state = Get.find<DjztLogic>().state;

  @override
  bool get isChangeNav => false;

  @override
  Widget? get titleWidget => Container(
        width: 1.sw,
        height: 32.w,
        child: Row(
          children: [
            GetBuilder(
              builder: (PsbcLogic c) {
                return Row(
                  children: [
                    Image(
                      image: 'nav_left_loc'.png3x,
                      width: 24.w,
                      height: 24.w,
                      color: Colors.black,
                    ),
                    BaseText(
                      text: AppConfig.config.abcLogic.memberInfo.city,
                      color: Colors.black,
                      fontSize: 14.sp,
                    ),
                  ],
                );
              },
              id: 'updateUI',
            ),
            SizedBox(
              width: 8.w,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BaseText(
                    text: '活动礼遇',
                    style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w600
                    ),)
                ],
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
          ],
        ),
      );

  @override
  List<Widget>? get rightAction => [
        SizedBox(
          width: 90.w,
        ),
      ];

  @override
  Color? get background => Colors.white;

  @override
  Widget initBody(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Image(
          image: 'card_page_5_1'.png3x,
          width: 1.sw,
          fit: BoxFit.fitWidth,
        ),
      ],
    );
  }
}
