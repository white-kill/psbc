import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/double_extension.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';
import 'package:psbc/utils/stack_position.dart';

import '../means_logic.dart';
import '../means_state.dart';

class MeansTopWidget2 extends StatefulWidget {
  const MeansTopWidget2({super.key});

  @override
  State<MeansTopWidget2> createState() => _MeansTopWidget2State();
}

class _MeansTopWidget2State extends State<MeansTopWidget2> {
  final MeansLogic logic = Get.put(MeansLogic());
  final MeansState state = Get.find<MeansLogic>().state;

  @override
  Widget build(BuildContext context) {
    StackPosition stackPosition =
    StackPosition(designWidth: 703, designHeight: 476, deviceWidth: 1.sw);
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Image(
          image: 'bg_top_fz'.png3x,
          width: 1.sw - 24.w,
        ),
        Container(
          child: Row(
            children: [
              Container(height: 45.w)
                  .expanded(onTap: () => logic.showOne.value = true),
              Container(height: 45.w)
                  .expanded(onTap: () => logic.showOne.value = false)
            ],
          ),
        ),
        Positioned(
          top: 80.w,
          right: stackPosition.getX(15),
          child: Image(
            image: 'tzwz_tag'.png,
            width: 80.w,
          ),),
        Positioned(
          top: 90.w,
          child: Image(
            image: 'ic_chat_fz'.png3x,
            width: 1.sw - 80.w,
            height: 120.w,
          ),),

        Positioned(top: 150.w,child: Column(
          children: [
            BaseText(text: '总负责(元)',fontSize: 14.sp,color: Color(0xff999999),),
            SizedBox(height: 12.w,),
            BaseText(text: 0.0.bankBalance,style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),)
          ],
        ),),
      ],
    );
  }
}
