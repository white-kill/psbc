import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/component/text_field_widget.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/wb_base_widget.dart';

import '../../../../../../../utils/abc_button.dart';
import '../../../../../../../utils/color_util.dart';
import '../../../../../../component/right_widget.dart';
import 'dzhd_verification_logic.dart';
import 'dzhd_verification_state.dart';

class DzhdVerificationPage extends BaseStateless {
  DzhdVerificationPage({Key? key}) : super(key: key, title: '电子回单验证');

  final Dzhd_verificationLogic logic = Get.put(Dzhd_verificationLogic());
  final Dzhd_verificationState state = Get.find<Dzhd_verificationLogic>().state;

  @override
  List<Widget>? get rightAction => RightWidget.widget1();

  @override
  Color? get background => Colors.white;

  @override
  Widget initBody(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(top: 12.w),
      children: [
        Row(
          children: [
            Container(
              width: 110.w,
              height: 45.w,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 15.w),
              child: BaseText(text: '回单号'),
            ),
            TextFieldWidget(
              hintText: '请输入回单号',
              onChanged: (v) {
                state.text1 = v;
                if (state.text1 != '' && state.text2 != '') {
                  logic.show.value = true;
                } else {
                  logic.show.value = false;
                }
              },
            ).expanded(),
            SizedBox(
              width: 15.w,
            )
          ],
        ).withContainer(width: 1.sw),
        Container(
          width: 1.sw,
          height: 0.5.w,
          padding: EdgeInsets.only(left: 15.w),
          color: Color(0xffdedede),
        ),
        Row(
          children: [
            Container(
              width: 110.w,
              height: 45.w,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 15.w),
              child: BaseText(text: '收款人姓名'),
            ),
            TextFieldWidget(
              hintText: '请输入收款人姓名',
              onChanged: (v) {
                state.text2 = v;
                if (state.text1 != '' && state.text2 != '') {
                  logic.show.value = true;
                } else {
                  logic.show.value = false;
                }
              },
            ).expanded(),
            SizedBox(
              width: 15.w,
            )
          ],
        ).withContainer(width: 1.sw),
        Container(
          width: 1.sw,
          height: 0.5.w,
          color: Color(0xffdedede),
        ),
        Obx(() =>AbcButton(
          onTap: () {
            if(logic.show.value == false) {
              '请输入信息'.showToast;
              return;
            }
            logic.checkReceipt();
          },
          title: '立即进入',
          width: 268.w,
          height: 45.w,
          radius: 8.w,
          margin: EdgeInsets.only(left: 25.w, right: 25.w, top: 60.w),
          bgColor: logic.show.value ? BColors.mainColor : Color(0xffB6D4C5),
        )),
        BaseText(
          text: '温馨提示:\n'
              '1.请您输入正确的回单号和收款人姓名。\n'
              '2.本功能目前支持我行手机银行、个人网银转账交易电子回单验证。',
          maxLines: 20,
          color: Color(0xff666666),
        ).withPadding(left: 25.w, right: 25.w, top: 45.w)
      ],
    );
  }
}
