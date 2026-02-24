import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../component/right_widget.dart';

class TransferStatusPage extends BaseStateless {
  TransferStatusPage({Key? key}) : super(key: key, title: '转账进度查询');

  final String postscriptno = Get.arguments['postscriptno'] ?? '';

  @override
  List<Widget>? get rightAction => RightWidget.widget1();

  @override
  Widget initBody(BuildContext context) {
    return Stack(
      children: [
        // 背景图片
        Image(
          image: 'trans_status'.png3x,
          width: 1.sw,
          height: 1.sh,
          fit: BoxFit.cover,
        ),
        // 文字内容
        Positioned(
          left: 48.w,
          right: 30.w,
          top: 260.w,
          child: Container(
            width: 1.sw - 48.w,
            child: BaseText(
              maxLines: 2,
              text: '报文号：$postscriptno可凭报文号前往对方银行查询',
              fontSize: 13.sp,
              color: Color(0xFF797A7F),
            ),
          ),
        ),
      ],
    );
  }
}
