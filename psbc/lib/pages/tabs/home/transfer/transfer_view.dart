import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:psbc/pages/tabs/home/transfer/card_transfer/card_transfer_view.dart';
import 'package:psbc/pages/tabs/home/transfer/component/transfer_contacts_widget.dart';
import 'package:psbc/pages/tabs/home/transfer/contacts_list/contants_list_view.dart';
import 'package:psbc/pages/tabs/home/transfer/record/record_view.dart';
import 'package:psbc/pages/tabs/home/transfer/transfer_setting/transfer_setting_view.dart';
import 'package:wb_base_widget/component/grid_view_widget.dart';
import 'package:wb_base_widget/extension/string_extension.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../component/right_widget.dart';
import 'transfer_logic.dart';
import 'transfer_state.dart';

class TransferPage extends BaseStateless {
  TransferPage({Key? key}) : super(key: key, title: '转账汇款');

  final TransferLogic logic = Get.put(TransferLogic());
  final TransferState state = Get.find<TransferLogic>().state;

  @override
  List<Widget>? get rightAction => RightWidget.widget1();

  @override
  Color? get background => Colors.white;

  @override
  Widget initBody(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Container(
          height: 113.w,
          margin: EdgeInsets.only(left: 15.w, right: 15.w, top: 15.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(14.w),
              topRight: Radius.circular(14.w),
            ),
            color: Color(0xff3D4976),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: 'card_t'.png3x,
                    width: 40.w,
                    height: 40.w,
                  ),
                  BaseText(
                    text: '银行账号转账',
                    color: Colors.white,
                  )
                ],
              ).withOnTap(onTap: (){
                Get.to(() => CardTransferPage());
              }),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: 'phone_t'.png3x,
                    width: 40.w,
                    height: 40.w,
                  ),
                  BaseText(
                    text: '手机号转账',
                    color: Colors.white,
                  )
                ],
              ).withOnTap(onTap: (){
                '该账户未开通手机号转账功能'.showToast;
              }),
            ],
          ),
        ),
        Container(
          height: 47.w,
          margin: EdgeInsets.only(
            left: 15.w,
            right: 15.w,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(14.w),
              bottomRight: Radius.circular(14.w),
            ),
            color: Color(0xffF2F5FF),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: 'zzlw'.png3x,
                    width: 18.w,
                    height: 18.w,
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  BaseText(
                    text: '往来转账记录',
                    fontSize: 13.sp,
                  )
                ],
              ).withOnTap(onTap: () => Get.to(() => RecordPage())),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: 'zzsz'.png3x,
                    width: 18.w,
                    height: 18.w,
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  BaseText(
                    text: '转账设置',
                    fontSize: 13.sp,
                  )
                ],
              ).withOnTap(onTap: () => Get.to(() => TransferSettingPage())),
            ],
          ),
        ),
        SizedBox(
          height: 15.w,
        ),
        Stack(
          children: [
            Obx(() => Image(image: logic.showAll.value
                      ? 't_tag_more'.png3x
                      : 't_tag_little'.png3x),
            ),
            Obx(() => VerticalGridView(
              padding: EdgeInsets.only(left: 16.w,right: 16.w),
              widgetBuilder: (_, index) {
                return Container(
                  width: 45.w,
                  height: 45.w,
                ).withOnTap(onTap: () => logic.jumpPage(index));
              },
              itemCount: logic.showAll.value?14:8,
              crossCount: 4,
              mainHeight: 58.w,
              spacing: 12.w,
            ))
          ],
        ),
        Container(
            width: 1.sw,
            height: 25.w,
            alignment: Alignment.center,
            child: Obx(() => logic.showAll.value
                ? Image(
                    image: 'top'.png,
                    width: 12.w,
                    height: 6.w,
                  )
                : Image(
                    image: 'bottom'.png,
                    width: 12.w,
                    height: 6.w,
                  ),),
        ).withOnTap(onTap: () {
          logic.showAll.value = !logic.showAll.value;
        }),
        TransferContactsWidget(),
      ],
    );
  }
}
