import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:psbc/pages/tabs/home/bill/year_bill/year_bill_info/year_bill_info_view.dart';
import 'package:psbc/pages/tabs/home/bill/year_bill/year_pdf.dart';
import 'package:psbc/utils/abc_button.dart';
import 'package:wb_base_widget/component/alter_widget.dart';
import 'package:wb_base_widget/extension/string_extension.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../../routes/app_pages.dart';
import '../../../../../utils/color_util.dart';
import '../../../../component/right_widget.dart';
import 'year_bill_logic.dart';
import 'year_bill_state.dart';

class YearBillPage extends BaseStateless {
  YearBillPage({Key? key}) : super(key: key, title: '年度回顾');

  final Year_billLogic logic = Get.put(Year_billLogic());
  final Year_billState state = Get.find<Year_billLogic>().state;

  @override
  bool get isChangeNav => true;

  @override
  Color? get backColor => Colors.white;

  @override
  List<Widget>? get rightAction => RightWidget.widget1(color: Colors.white);

  @override
  Widget initBody(BuildContext context) {
    return Stack(
      children: [
        Image(
          image: 'year_start'.png3x,
          height: 1.sh,
          fit: BoxFit.fitHeight,
        ),
        Positioned(
            bottom:  45.w,
            child: Container(
              width: 1.sw,
              height: 100.w,
            ).withOnTap(onTap: () {
              AlterWidget.alterWidget(
                  clickMaskDismiss: true,
                  builder: (context) {
                    return Stack(
                      children: [
                        Image(
                          image: 'year_bill_ty'.png3x,
                          width: 302.w,
                        ),
                        Positioned(
                            bottom: 78.w,
                            left: 18.5.w,
                            child: Row(
                              children: [
                                Obx(
                                  () => Image(
                                    image: logic.agree.value
                                        ? 'p_se'.png3x
                                        : 'p_un'.png3x,
                                    width: 18.w,
                                  ).withOnTap(
                                      onTap: () => logic.agree.value =
                                          !logic.agree.value),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                BaseText(
                                  text: '我已同意并知晓',
                                  style: TextStyle(
                                      fontSize: 12, color: Color(0xff66666F)),
                                )
                              ],
                            )),
                        Positioned(
                            bottom: 16.w,
                            left: 18.5.w,
                            child: Obx(() => AbcButton(
                                  onTap: () async{
                                    if (logic.agree.value == false) {
                                      '请同意并阅读协议'.showToast;
                                      return;
                                    }
                                    await SmartDialog.dismiss();
                                    Get.offAndToNamed(Routes.yearBillInfoPage);
                                  },
                                  title: '立即进入',
                                  width: 268.w,
                                  height: 45.w,
                                  radius: 30.w,
                                  bgColor: logic.agree.value
                                      ? BColors.mainColor
                                      : Color(0xffB6D4C5),
                                ))),
                        Positioned(
                            bottom: 105.w,
                            left: 18.5.w,
                            child: Container(
                              width: 240.w,
                              height: 32.w,
                            ).withOnTap(onTap: () {
                              Get.to(() => const YearPdfWidget());
                            })),
                      ],
                    );
                  });
            }))
      ],
    );
  }
}
