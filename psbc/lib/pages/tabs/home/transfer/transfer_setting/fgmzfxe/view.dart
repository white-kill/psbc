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

class FgmzfxePage extends BaseStateless {
  FgmzfxePage({Key? key}) : super(key: key, title: '非柜面支付限额');

  final FgmzfxeLogic logic = Get.put(FgmzfxeLogic());
  final FgmzfxeState state = Get.find<FgmzfxeLogic>().state;

  @override
  List<Widget>? get rightAction => RightWidget.widget1();

  @override
  @override
  Widget initBody(BuildContext context) {
    StackPosition stackPosition = StackPosition(
      designWidth: 1080,
      designHeight: 2899,
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
                  image: 'fgmzfxe_1'.png3x,
                  fit: BoxFit.fitWidth,
                  width: 1.sw,
                ),
                Positioned(
                    top: stackPosition.getY(230),
                    left: stackPosition.getX(130),
                    child: Row(
                      children: [
                        BaseText(
                          text: c.memberInfo.realName,
                          style: TextStyle(
                              fontSize: 15.w,
                              color: Color(0xff333333),
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    )),

                Positioned(
                    top: stackPosition.getY(235),
                    right: stackPosition.getX(380),
                    child: Row(
                      children: [
                        BaseText(
                          text: model.bankCard.substring(0, 4),
                          style: TextStyle(
                              fontSize: 15.w,
                              color: Color(0xff333333),
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    )),
                Positioned(
                    top: stackPosition.getY(235),
                    left: stackPosition.getX(860),
                    child: Row(
                      children: [
                        BaseText(
                          text: model.bankCard.substring(model.bankCard.length - 4),
                          style: TextStyle(
                              fontSize: 15.w,
                              color: Color(0xff333333),
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
