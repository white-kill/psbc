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

class SkrmcPage extends BaseStateless {
  SkrmcPage({Key? key}) : super(key: key, title: '收款人名册');

  final SkrmcLogic logic = Get.put(SkrmcLogic());
  final SkrmcState state = Get.find<SkrmcLogic>().state;

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
        Stack(
          children: [
            Image(
              image: 'skrmc_1'.png3x,
              fit: BoxFit.fitWidth,
              width: 1.sw,
            ),
            GetBuilder(
              builder: (PsbcLogic c) {
                MemberInfoBankList model = c.memberInfo.bankList.isNotNullOrEmpty ? c.memberInfo.bankList[0] : MemberInfoBankList() ;
                return Positioned(
                  top: stackPosition.getY(927),
                  left: stackPosition.getX(600),
                  child: BaseText(
                      text: model.bankCard.substring(model.bankCard.length - 4),
                      color: Color(0xff777777),
                      fontSize: 13.w,
                    ),
                );
              },
              id: 'updateCard',
            ),
          ],
        )
      ],
    );
  }
}
