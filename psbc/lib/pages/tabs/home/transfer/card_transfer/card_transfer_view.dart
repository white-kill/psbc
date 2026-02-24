import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:psbc/pages/tabs/home/transfer/card_transfer/component/bottom_widget.dart';
import 'package:psbc/pages/tabs/home/transfer/card_transfer/component/card_info_widget.dart';
import 'package:psbc/pages/tabs/home/transfer/card_transfer/component/card_info_display_widget.dart';
import 'package:psbc/pages/tabs/home/transfer/card_transfer/component/money_widget.dart';
import 'package:psbc/pages/tabs/home/transfer/card_transfer/component/payment_account_widget.dart';
import 'package:psbc/pages/tabs/home/transfer/card_transfer/component/remark_widget.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';

import '../../../../component/right_widget.dart';
import 'card_transfer_logic.dart';
import 'card_transfer_state.dart';

class CardTransferPage extends BaseStateless {
  CardTransferPage({Key? key}) : super(key: key,title: '银行账号转账');

  final CardTransferLogic logic = Get.put(CardTransferLogic());
  final CardTransferState state = Get.find<CardTransferLogic>().state;
  @override
  List<Widget>? get rightAction => RightWidget.widget1();

  @override
  Widget initBody(BuildContext context) {
    return GetBuilder<CardTransferLogic>(
      id: 'updateCard',
      builder: (logic) {
        // 如果有传入的收款人信息，使用只读展示样式，否则使用可编辑样式
        bool hasPrefilledData = state.cardReq.bankId.isNotEmpty;
        
        return ListView(
          padding: EdgeInsets.zero,
          children: [
            hasPrefilledData ? const CardInfoDisplayWidget() : const CardInfoWidget(),
            const MoneyWidget(),
            const PaymentAccountWidget(),
            const RemarkWidget(),
            const BottomWidget(),
          ],
        );
      },
    );
  }
}
