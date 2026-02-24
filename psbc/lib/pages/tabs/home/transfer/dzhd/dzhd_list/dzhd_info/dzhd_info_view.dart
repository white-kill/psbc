import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:psbc/config/app_config.dart';
import 'package:wb_base_widget/extension/double_extension.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../../../component/right_widget.dart';
import 'dzhd_info_logic.dart';
import 'dzhd_info_state.dart';

class DzhdInfoPage extends BaseStateless {
  DzhdInfoPage({Key? key}) : super(key: key,title: '电子回单');

  final Dzhd_infoLogic logic = Get.put(Dzhd_infoLogic());
  final Dzhd_infoState state = Get.find<Dzhd_infoLogic>().state;

  @override
  List<Widget>? get rightAction => RightWidget.widget1();

  @override
  Color? get background => Colors.white;

  @override
  Widget initBody(BuildContext context) {
    return Column(
      children: [
        ListView(
          padding: EdgeInsets.only(bottom: 45.w),
          children: [
            RepaintBoundary(
              key: logic.globalKey,
              child: Container(
                margin: EdgeInsets.only(left: 26.w, right: 26.w,top: 15.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 15,
                      spreadRadius: 1,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 16.w,
                        ),
                        Row(
                          children: [
                            Image(
                              image: 'a_check'.png3x,
                              width: 18.w,
                              height: 18.w,
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            BaseText(text: '交易已受理，请查询余额和交易明细'),
                          ],
                        ),
                        SizedBox(
                          height: 18.w,
                        ),
                        BaseText(
                          text: '${AppConfig.config.abcLogic.memberInfo.realName}向您转账',
                          color: Color(0xff333333),
                        ),
                        SizedBox(
                          height: 6.w,
                        ),
                        BaseText(
                          text: '￥${state.detail.amount.bankBalance}',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 16.w,
                        ),
                        Column(
                          spacing: 12.w,
                          children: state.titles.map((e) {
                            return Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  BaseText(
                                    text: e,
                                    style: TextStyle(
                                        fontSize: 12.w,
                                        color: Color(0xff666666),
                                        fontWeight: FontWeight.w500),
                                  ),
                                  e == '回单号'?
                                  SelectionArea(child: BaseText(
                                      text: logic.valueStr(e),
                                      style: TextStyle(
                                          fontSize: 12.w,
                                          color: Color(0xff333333),
                                          fontWeight: FontWeight.w500))):BaseText(
                                      text: logic.valueStr(e),
                                      style: TextStyle(
                                          fontSize: 12.w,
                                          color: Color(0xff333333),
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                        SizedBox(
                          height: 8.w,
                        ),
                      ],
                    ).withContainer(
                        padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.w),
                        decoration: BoxDecoration(
                            image: DecorationImage(image: 'hd_bg1'.png,fit: BoxFit.fitWidth)
                        )
                    ),
                    Container(
                        padding: EdgeInsets.only(left: 16.w, right: 16.w,bottom: 16.w),
                        height: 160.w,
                        alignment: Alignment.bottomCenter,
                        decoration: BoxDecoration(
                            image: DecorationImage(image: 'hd_bg2'.png,fit: BoxFit.fitWidth)
                        ),
                      child: GetBuilder(
                        builder: (Dzhd_infoLogic c) {
                          return logic.qrImage == null
                              ? SizedBox(
                            width: 75.w,
                            height: 75.w,
                          )
                              : PrettyQrView(
                            qrImage: logic.qrImage!,
                          ).withContainer(
                              width: 75.w, height: 75.w);
                        },
                        id: 'code',
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ).expanded(),
        Image(image: 'hd_b1'.png3x),
        Stack(
          children: [
            Image(image: 'hd_b2'.png3x),
            Row(
              children: [
                Container(
                  height: 64.w,
                ).expanded(onTap: (){
                  logic.saveFullPageAsImage();
                }),
                Container(
                  height: 64.w,
                ).expanded(onTap: (){

                })
              ],
            )
          ],
        )
      ],
    );
  }
}
