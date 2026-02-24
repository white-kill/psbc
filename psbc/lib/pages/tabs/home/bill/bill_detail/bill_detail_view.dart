import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:psbc/utils/color_util.dart';
import 'package:psbc/utils/widget_util.dart';
import 'package:wb_base_widget/component/text_field_widget.dart';
import 'package:wb_base_widget/extension/double_extension.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../../config/model/notice_data_model.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../component/right_widget.dart';
import '../../../../component/sheet_widget/sheet_bottom.dart';
import '../../transfer/card_transfer/card_transfer_view.dart';
import '../../transfer/transfer_notice/transfer_notice_view.dart';
import 'bill_detail_cat.dart';
import 'bill_detail_logic.dart';
import 'bill_detail_state.dart';

class BillDetailPage extends BaseStateless {
  BillDetailPage({super.key}) : super(title: '交易详情');

  final BillDetailLogic logic = Get.put(BillDetailLogic());
  final BillDetailState state = Get.find<BillDetailLogic>().state;

  @override
  List<Widget>? get rightAction => RightWidget.widget1();

  @override
  Widget initBody(BuildContext context) {
    return Column(
      children: [
        ListView(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          children: [
            SizedBox(height: 12.w,),
            Container(
              width: 1.sw,
              padding: EdgeInsets.only(left:15.w,top: 12.w,right: 15.w,bottom: 12.w),
              decoration: BoxDecoration(
                image:DecorationImage(
                  image: 'mx_bg'.png,
                  fit: BoxFit.cover
                ) ,
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.w))
              ),
              child: Column(
                children: [
                  SizedBox(height: 28.w),
                  BaseText(
                    text: state.billDetail.oppositeName,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff333333)),
                  ),
                  SizedBox(height: 30.w),
                  BaseText(
                    text:
                        '${logic.type()}￥${state.billDetail.amount.bankBalance}',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff333333)),
                  ),
                  SizedBox(height: 26.w),
                  BaseText(
                    text: '余额￥${state.billDetail.accountBalance.bankBalance}',
                    style: TextStyle(fontSize: 13, color: Color(0xff8D8D8D)),
                  ),
                  SizedBox(height: 15.w),
                  ..._titleWidgets(),
                  SizedBox(height: 12.w),
                ],
              ),
            ),
            SizedBox(height: 12.w,),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10.w))
              ),
              margin: EdgeInsets.only(left: 12.w, bottom: 12.w, right: 12.w),
              child: ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    String title = state.titles1[index];
                    if (title == '附注') {
                      return Container(
                        width: 1.sw,
                        height: 117.w,
                        padding: EdgeInsets.only(
                          left: 15.w,
                          right: 15.w,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 28.w,
                            ),
                            BaseText(
                              text: title,
                              color: Color(0xff212121),
                              fontSize: 15,
                            ),
                            TextFieldWidget(
                              hintText: '记录点什么...',
                              hintStyle: TextStyle(
                                  fontSize: 15.sp, color: Color(0xffC7C7C7)),
                            )
                          ],
                        ),
                      );
                    }
                    return Container(
                      width: 1.sw,
                      height: 52.w,
                      padding: EdgeInsets.only(
                        left: 15.w,
                        right: 15.w,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BaseText(
                            text: title,
                            color: Color(0xff212121),
                            fontSize: 15,
                          ),
                          _rightWidget(title)
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Container(
                      width: 1.sw,
                      height: 0.5,
                      margin: EdgeInsets.only(
                        left: 15.w,
                        right: 15.w,
                      ),
                      color: const Color(0xffECECEC),
                    );
                  },
                  itemCount: state.titles1.length),
            )
          ],
        ).expanded(),
        state.billDetail.billType == '1'? Container(
          width: 1.sw,
          height: 52.w +  ScreenUtil().bottomBarHeight,
          color: Colors.white,
          padding: EdgeInsets.only(bottom:  ScreenUtil().bottomBarHeight,left: 12.w,right: 12.w),
          child: Row(
            spacing: 35.w,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: state.titles3.map((e) {
              return BaseText(
                text: e,
                color: BColors.mainColor,
                fontSize: 15,
              ).withOnTap(onTap: (){
                if(e == '通知收款人'){
                  NoticeDataModel data = NoticeDataModel();
                  data.amount = state.billDetail.amount;
                  data.oppositeAccount = state.billDetail.oppositeAccount;
                  data.oppositeBank = state.billDetail.oppositeBankName;
                  data.oppositeName = state.billDetail.oppositeName;
                  data.postscript = state.billDetail.merchantBranch;
                  data.transactionTime = state.billDetail.transactionTime;
                  data.bank = state.billDetail.bankName;
                  data.account = state.billDetail.account;
                  Get.to(() => TransferNoticePage(),
                      arguments: {'model': data});
                }
                if(e == '查看往来记录'){
                  Get.offAndToNamed(Routes.queryRecordPage,arguments: {
                    'oppositeAccount':state.billDetail.oppositeAccount
                  });
                }
                if(e == '给Ta转账'){
                  Get.to(() => CardTransferPage(),arguments:{
                    'icon': state.billDetail.icon,
                    'bankName': state.billDetail.oppositeBankName,
                    'id': state.billDetail.oppositeBankId,
                    'name': state.billDetail.oppositeName,
                    'bankCard': state.billDetail.oppositeAccount,
                  });
                }
              });
            }).toList(),
          ),
        ):const SizedBox.shrink()
      ],
    );
  }

  Widget _rightWidget(String name) {
    if (name == '交易类型') {
      return Row(
        children: [
          Obx(() => logic.categoryImg.value.contains('http')
              ? netImage(
                  url: logic.categoryImg.value,
                  width: 25.w,
                  height: 25.w,
                )
              : Image(
                  image: logic.categoryImg.value.png3x,
                  width: 25.w,
                  height: 25.w,
                )),
          SizedBox(
            width: 6.w,
          ),
          Obx(() => BaseText(
                text: logic.categoryText.value,
                fontSize: 13.5.sp,
                color: Color(0xff333333),
              )),
          Image(
            image: 'ic_jt_right'.png3x,
            width: 22.w,
            height: 22.w,
          ),
        ],
      ).withOnTap(onTap: () {
        SheetBottom.show(
          showTopText: true,
          title: '选择分类',
          child: const BillDetailCat(),
        );
      });
    }
    if (name == '所属账本') {
      return Row(
        children: [
          BaseText(
            text: '请选择',
            color: Color(0xff8D8D8D),
          ),
          Image(
            image: 'ic_jt_right'.png3x,
            width: 22.w,
            height: 22.w,
          ),
        ],
      );
    }
    if (name == '不计入本月收支') {
      return Obx(() =>  CupertinoSwitch(
          value: logic.noShow.value,
          // activeTrackColor: Color.fromARGB(255, 3, 134, 91),
          activeColor: Color.fromARGB(255, 3, 134, 91),
          onChanged: (bool value) {
            logic.noShow.value = value;
          })
          .sw());
    }
    return const SizedBox.shrink();
  }

  List<Widget> _titleWidgets() {
    return logic.fTitles.map((e) {
      if (logic.valueStr(e).trim() == "") {
        return const SizedBox();
      }
      return Container(
        padding: EdgeInsets.only(left: 15.w, right: 15.w),
        margin: EdgeInsets.only(top: 10.w, bottom: 10.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BaseText(
              text: e,
              color: Color(0xff8D8D8D),
              fontSize: 14,
            ),
            BaseText(
              text: logic.valueStr(e),
              color: Color(0xff212121),
              fontSize: 14,
              maxLines: 2,
              textAlign: TextAlign.end,
            ).withContainer(
              alignment: Alignment.centerRight,
              width: 240.w
            )
          ],
        ),
      );
    }).toList();
  }
}
