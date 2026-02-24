import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:psbc/config/app_config.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../../../routes/app_pages.dart';
import '../../../../../component/right_widget.dart';
import '../../../../../other/customer_service/customer_service_view.dart';
import 'year_end_logic.dart';
import 'year_end_state.dart';

class YearEndPage extends BaseStateless {
  YearEndPage({Key? key}) : super(key: key);

  final Year_endLogic logic = Get.put(Year_endLogic());
  final Year_endState state = Get.find<Year_endLogic>().state;

  @override
  bool get isChangeNav => true;

  @override
  List<Widget>? get rightAction =>  [
    SizedBox(
      width: 10.w,
    ),
    Image(
      width: 37.w,
      height: 37.w,
      image: 'home_right_khfw'.png3x,
    ).withOnTap(onTap:() => Get.to(() => CustomerServicePage())),
    SizedBox(
      width: 12.w,
    ),
    Obx(() => Image(
      width: 22.w,
      height: 22.w,
      color: logic.navActionColor.value,
      image: 'right_tag1'.png3x,).withOnTap(onTap: () => Get.offAllNamed(Routes.tabs)),),
    SizedBox(
      width: 16.w,
    ),
  ];


  @override
  Widget? get titleWidget => Obx(
        () => BaseText(
        text: '2025年度账单',
        fontSize: 18.sp,
        color: logic.navActionColor.value),
  );

  String _getGenderText(String sex) {
    // 如果sex是1/2这样的数字，进行转换
    if (sex == '1' || sex.toLowerCase() == 'male' || sex == '男') return 'year_end1';
    if (sex == '2' || sex.toLowerCase() == 'female' || sex == '女') return 'year_end';
    return 'year_end'; // 如果已经是中文直接返回
  }

  @override
  Widget? get leftItem => InkWell(
    child: Obx(() => Padding(
      padding: EdgeInsets.only(left: 10.w),
      child: Icon(
        Icons.navigate_before,
        size: 30.h,
        color: logic.navActionColor.value,
      ),
    )),
    onTap: () => Get.back(),
  );

  @override
  Function(bool change)? get onNotificationNavChange => (v) {
    logic.navActionColor.value = v
        ? const Color(0xFF333333)
        : Colors.white;
  };


  @override
  Widget initBody(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Stack(
          children: [
            Image(image: _getGenderText(AppConfig.config.abcLogic.memberInfo.sex).png3x,fit: BoxFit.fitWidth,),
          ],
        )
      ],
    );
  }
}
