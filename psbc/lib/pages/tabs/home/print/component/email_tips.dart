import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../../utils/abc_button.dart';
import '../../../../component/sheet_widget/sheet_bottom.dart';
import '../req_print.dart';
import 'input_pas.dart';

class EmailTips extends StatefulWidget {
  final ReqPrint reqPrint;

  const EmailTips({super.key, required this.reqPrint});

  @override
  State<EmailTips> createState() => _EmailTipsState();
}

class _EmailTipsState extends State<EmailTips> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 220.w,
      child: Column(
        children: [
          BaseText(
            text: '请仔细核对您输入的邮箱确保无误，后续交易流水文件将发送至您指定的邮箱',
            maxLines: 3,
            color: Color(0xff666666),
          ).withPadding(
            left: 12.w,
            right: 12.w,
            top: 15.w,
          ),
          SizedBox(height: 24.w,),
          BaseText(
            text: '接收邮箱',
            maxLines: 3,
            color: Color(0xff666666),
          ).withContainer(
            width: 1.sw,
            padding: EdgeInsets.only(left: 12.w)
          ),
          SizedBox(height: 12.w,),
          BaseText(text: widget.reqPrint.email),
          SizedBox(height: 12.w,),
          Container(
            width: 1.sw,
            margin: EdgeInsets.only(left: 12.w, right: 12.w),
            height: 0.5.w,
            color: Color(0xffdedede),
          ),
          SizedBox(height: 24.w,),
          AbcButton(title: '确认无误', width: 345.w, height: 45.w, radius: 4.w,onTap: (){
            Get.back();
            SheetBottom.show(
              title: '交易密码认证',
              rightWidget: Image(
                image: 'close'.png3x,
                width: 16.w,
                height: 16.w,
              ).withOnTap(onTap: () => Get.back()),
              child: InputPas(
                reqPrint: widget.reqPrint,
              ),
            );
          },),
        ],
      ),
    );
  }
}
