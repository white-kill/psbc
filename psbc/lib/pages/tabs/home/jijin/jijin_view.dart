import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/component/text_field_widget.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';
import 'package:psbc/pages/other/customer_service/customer_service_view.dart';
import 'package:psbc/utils/common_right_button.dart';

import '../../../component/placeholder_search_widget.dart';
import '../../../../../config/app_config.dart';
import 'jijin_logic.dart';
import 'jijin_state.dart';

class JijinPage extends BaseStateless {
  JijinPage({Key? key}) : super(key: key);

  final JijinLogic logic = Get.put(JijinLogic());
  final JijinState state = Get.find<JijinLogic>().state;


  @override
  Widget? get titleWidget => PlaceholderSearchWidget(
    hideLeftIcon: true,
        width: 225.w,
        contentList: const ['大家都在搜'],
        border: Border.all(color: Colors.grey.withOpacity(0.4), width: 0.5),
        textColor: Colors.black,
      );

  List<Widget>? get rightAction => CommonRightButton.build([
        RightButtonConfig(type: RightButtonType.customerService),
        RightButtonConfig(type: RightButtonType.share),
      ]);

  @override
  Widget initBody(BuildContext context) {
    return ListView(
      children: [
        Image(
          image: 'home_jijin'.png3x,
          width: 1.sw,
          fit: BoxFit.fitWidth,
        ),
      ],
    );
  }
}
