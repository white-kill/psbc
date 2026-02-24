import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../../utils/color_util.dart';
import 'xykhh_logic.dart';
import 'xykhh_state.dart';

class XykhhPage extends BaseStateless {
  XykhhPage({Key? key}) : super(key: key,title: '信用卡还款');

  final XykhhLogic logic = Get.put(XykhhLogic());
  final XykhhState state = Get.find<XykhhLogic>().state;

  @override
  Widget initBody(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 1.sw,
          height: 50.w,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: state.titleList.map((String name) {
              int index = state.titleList.indexOf(name);
              return Obx(() => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BaseText(
                    text: name,
                    style: TextStyle(
                        color: logic.selectTitle.value == index
                            ? Colors.black
                            : Color(0xff666666),
                        fontWeight: logic.selectTitle.value == index
                            ? FontWeight.bold
                            : FontWeight.normal),
                  ),
                  SizedBox(
                    height: 4.w,
                  ),
                  Container(
                    width: 20.w,
                    height: 3.w,
                    decoration: BoxDecoration(
                        color: logic.selectTitle.value == index
                            ? BColors.mainColor
                            : Colors.white,
                        borderRadius:
                        BorderRadius.all(Radius.circular(4.w))),
                  )
                ],
              ));
            }).toList(),
          ),
        ),
        ListView(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          children: [
            Image(image: 'xykhk_1'.png3x),
            Image(image: 'xykhk_2'.png3x)
          ],
        ).expanded()
      ],
    );
  }
}
