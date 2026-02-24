import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';
import 'package:psbc/utils/stack_position.dart';

import '../../../../../component/right_widget.dart';
import '../../../../../../config/abc_config/psbc_logic.dart';
import '../../../../../../config/model/member_info_model.dart';
import 'logic.dart';
import 'state.dart';

class BdsjskPage extends BaseStateless {
  BdsjskPage({Key? key}) : super(key: key, title: '绑定手机号收款');

  final BdsjskLogic logic = Get.put(BdsjskLogic());
  final BdsjskState state = Get.find<BdsjskLogic>().state;

  @override
  List<Widget>? get rightAction => RightWidget.widget1();

  @override
  @override
  Widget initBody(BuildContext context) {
    StackPosition stackPosition = StackPosition(
      designWidth: 1080,
      designHeight: 2155,
      deviceWidth: 1.sw,
    );
    return ListView(
      children: [
        GetBuilder(
          builder: (PsbcLogic c) {
            MemberInfoBankList model = c.memberInfo.bankList.isNotNullOrEmpty
                ? c.memberInfo.bankList[0]
                : MemberInfoBankList();
            return Stack(
              children: [
                Image(
                  image: 'bdsjsk_1'.png3x,
                  fit: BoxFit.fitWidth,
                  width: 1.sw,
                ),
                Positioned(
                    top: stackPosition.getY(54),
                    right: stackPosition.getX(670),
                    child: Row(
                      children: [
                        BaseText(
                          text: c.memberInfo.phone.substring(0, 3),
                          style: TextStyle(
                              fontSize: 17.w,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    )),
                Positioned(
                    top: stackPosition.getY(54),
                    left: stackPosition.getX(520),
                    child: Row(
                      children: [
                        BaseText(
                          text: c.memberInfo.phone
                              .substring(c.memberInfo.phone.length - 4),
                          style: TextStyle(
                              fontSize: 17.w,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    )),
                Positioned(
                    top: stackPosition.getY(455),
                    right: stackPosition.getX(750),
                    child: Row(
                      children: [
                        BaseText(
                          text: model.bankCard.substring(0, 4),
                          style: TextStyle(
                              fontSize: 17.w,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        BaseText(
                          text: model.bankCard.substring(4, 6),
                          style: TextStyle(
                              fontSize: 17.w,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    )),
                Positioned(
                    top: stackPosition.getY(455),
                    left: stackPosition.getX(610),
                    child: Row(
                      children: [
                        BaseText(
                          text: model.bankCard
                              .substring(model.bankCard.length - 1),
                          style: TextStyle(
                              fontSize: 17.w,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        BaseText(
                          text: model.bankCard
                              .substring(model.bankCard.length - 3),
                          style: TextStyle(
                              fontSize: 17.w,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    )),
              ],
            );
          },
          id: 'updateCard',
        ),
      ],
    );
  }
}
