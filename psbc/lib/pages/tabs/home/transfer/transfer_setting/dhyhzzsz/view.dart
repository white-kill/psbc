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

class DhyhzzszPage extends BaseStateless {
  DhyhzzszPage({Key? key}) : super(key: key, title: '电话银行转账设置');

  final DhyhzzszLogic logic = Get.put(DhyhzzszLogic());
  final DhyhzzszState state = Get.find<DhyhzzszLogic>().state;

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
                  image: 'dhyhzzsz_1'.png3x,
                  fit: BoxFit.fitWidth,
                  width: 1.sw,
                ),
                Positioned(
                    top: stackPosition.getY(40),
                    right: stackPosition.getX(690),
                    child: Row(
                      children: [
                        BaseText(
                          text: model.bankCard.substring(0, 4),
                          style: TextStyle(
                              fontSize: 15.w,
                              color: Color(0xff777777),
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    )),
                Positioned(
                    top: stackPosition.getY(40),
                    left: stackPosition.getX(490),
                    child: Row(
                      children: [
                        BaseText(
                          text: model.bankCard.substring(model.bankCard.length - 4),
                          style: TextStyle(
                              fontSize: 15.w,
                              color: Color(0xff777777),
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
