import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:psbc/config/app_config.dart';
import 'package:psbc/pages/tabs/home/transfer/bank_list/bank_list_view.dart';
import 'package:psbc/pages/tabs/home/transfer/card_transfer/component/money_widget.dart';
import 'package:psbc/pages/tabs/home/transfer/thzayc/scan_page/scan_page_view.dart';
import 'package:wb_base_widget/component/text_field_widget.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../../utils/abc_button.dart';
import '../../../../../utils/color_util.dart';
import 'thzayc_logic.dart';
import 'thzayc_state.dart';

class ThzaycPage extends BaseStateless {
  ThzaycPage({Key? key}) : super(key: key, title: '他行转邮储');

  final ThzaycLogic logic = Get.put(ThzaycLogic());
  final ThzaycState state = Get.find<ThzaycLogic>().state;

  @override
  Widget initBody(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 1.sw,
          height: 50.w,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: state.titleList.map((String name) {
              int index = state.titleList.indexOf(name);
              return Obx(() => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BaseText(
                        text: name,
                        style: TextStyle(
                            color: logic.selectTitle.value == index
                                ? Colors.black
                                : Color(0xff666666),
                            fontWeight: logic.selectTitle.value == index
                                ? FontWeight.bold
                                : FontWeight.normal),
                      ),
                      SizedBox(
                        height: 4.w,
                      ),
                      Container(
                        width: 16.w,
                        height: 3.w,
                        decoration: BoxDecoration(
                            color: logic.selectTitle.value == index
                                ? BColors.mainColor
                                : Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.w))),
                      )
                    ],
                  ).withOnTap(onTap: () {
                    logic.selectTitle.value = index;
                    logic.update(['updateUI']);
                  }));
            }).toList(),
          ),
        ),
        GetBuilder(
          builder: (ThzaycLogic c) {
            return _tabViewWidget();
          },
          id: 'updateUI',
        )
      ],
    );
  }

  Widget _tabViewWidget() {
    if (logic.selectTitle.value == 0) {
      return ListView(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        children: [
          _itemWidget(
              title: '我行收款账户',
              showRight: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BaseText(text: AppConfig.config.abcLogic.card()),
                  SizedBox(
                    height: 4.w,
                  ),
                  Row(
                    children: [
                      BaseText(
                        text: '可用余额',
                        fontSize: 13,
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      BaseText(
                        text: '¥' + AppConfig.config.abcLogic.balance(),
                        color: Color(0xff9F7E50),
                        fontSize: 13,
                      ),
                    ],
                  )
                ],
              )),

          SizedBox(height: 12.w,),

          _itemWidget(
              title: '付款户名',
              sp: 47.w,
              child: BaseText(text: AppConfig.config.abcLogic.memberInfo.realName).withContainer(
                  width: 200.w,
                  height: 28.w,
                  alignment: Alignment.centerLeft,
              )),
          Container(height: 0.6.w,width: 1.sw,color: Color(0xFFF5F5F5),),
          Container(
            width: 1.sw,
            padding: EdgeInsets.all(15.w),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    BaseText(
                      text: '付款账号',
                      fontSize: 15,
                      color: Color(0xff2E2E30),
                    ),
                    SizedBox(width: 47.w),
                    Container(
                      width: 200.w,
                      height: 28.w,
                      alignment: Alignment.centerLeft,
                      child: TextFieldWidget(
                        hintText: '请输入付款账号',
                      ),
                    ),
                  ],
                ),
                Image(
                  image: 'ic_scan'.png3x,
                  width: 24.w,
                  height: 24.w,
                ).withOnTap(onTap: () async {
                  final result = await Get.to(() => ScanPage());
                  if (result != null) {
                    // TODO: 处理扫码结果，填充到输入框
                    print('扫码结果: $result');
                  }
                }),
              ],
            ),
          ),
          Container(height: 0.6.w,width: 1.sw,color: Color(0xFFF5F5F5),),
          _itemWidget(
              title: '付款银行',
              sp: 47.w,
              showRight: true,
              child: Container(
                width: 200.w,
                height: 28.w,
                alignment: Alignment.centerLeft,
                child: TextFieldWidget(
                  hintText: '请选择付款银行',
                  enabled: false,
                ),
              ).withOnTap(onTap: (){
                Get.to(() => BankListPage());
              })),
          Container(height: 0.6.w,width: 1.sw,color: Color(0xFFF5F5F5),),
          _itemWidget(
              title: '付款行预留手机号',
              sp: 25.w,
              child: BaseText(text: AppConfig.config.abcLogic.memberInfo.phone).withContainer(
                  width: 150.w,
                  height: 28.w,
                alignment: Alignment.centerLeft,
              )),
          const MoneyWidget(),

          Container(
            padding: EdgeInsets.only(left:12.w,top: 12.w,bottom: 12.w,right: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BaseText(text: '填写推荐柜员',fontSize: 12,color: Color(0xff333333),),
                Image(
                  image: 'ic_jt_bottom'.png3x,
                  width: 18.w,
                  height: 18.w,
                  color: Color(0xff333333),
                )
              ],
            ),
          ),
          
          BaseText(text: '\n温馨提示:'
              '\n1.他行卡限额提示信息来自银联通道登记的限额信息:具体以他行实际控制为准，仅供参考。'
              '\n2.如因他行或银联网络拥堵等情况导致资金不能即时转入，'
              '请先查看账户余额或通过“我的账户-明细查询”确认该笔交易是否成功，避免重复转入。'
              '一般情况下最迟在操作后的下一工作日到账。3.他行卡请使用借记卡，',maxLines: 100,
          color: Color(0xff666666),
          ).withContainer(
            color: Colors.white,
            padding: EdgeInsets.only(left: 12.w,right: 12.w,bottom: 12.w),
          ),

          AbcButton(
            title: '确定',
            onTap: () {},
            width: 343.w,
            height: 44.w,
            bgColor: Color(0xffD1E3DA),
            radius: 12.w,
          ).withContainer(
            color: Colors.white,
            padding: EdgeInsets.only(left: 10.w,right: 10.w,top: 20.w,bottom: 30.w,)
          ),
        ],
      ).expanded();
    }
    return Image(
      image: 'thzr1'.png3x,
      fit: BoxFit.fitWidth,
    );
  }

  Widget _itemWidget(
      {String title = '', Widget? child, bool showRight = false,double sp = 15,}
      ){
    return Container(
      width: 1.sw,
      padding: EdgeInsets.all(15.w),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              BaseText(
                text: title,
                fontSize: 15,
                color: Color(0xff2E2E30),
              ),
              SizedBox(
                width: sp.w,
              ),
              child ?? SizedBox.shrink()
            ],
          ),
          showRight
              ? Image(
                  image: 'ic_jt_right'.png3x,
                  width: 22.w,
                  height: 22.w,
                )
              : SizedBox.shrink()
        ],
      ),
    );
  }
}
