import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:psbc/pages/tabs/home/print/component/show_alter_item.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../../utils/color_util.dart';
import '../../../../component/sheet_widget/sheet_bottom.dart';
import '../print_logic.dart';
import '../print_state.dart';

class TypeWidget extends StatefulWidget {
  const TypeWidget({super.key});

  @override
  State<TypeWidget> createState() => _TypeWidgetState();
}

class _TypeWidgetState extends State<TypeWidget> {
  List timeTag = ['全部','工资','还款'];
  String selectTag = '全部';
  final PrintLogic logic = Get.find<PrintLogic>();
  final PrintState state = Get.find<PrintLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 200.w,
      color: Colors.white,
      padding: EdgeInsets.only(left: 15.w, right: 12.w, top: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BaseText(
            text: '查询类型',
            style: TextStyle(
              color: Color(0xff2E2E30),
              fontSize: 15,
            ),
          ),
          SizedBox(
            height: 20.w,
          ),
          Row(
            children: timeTag.map((e) {
              int index = timeTag.indexOf(e);
              bool isSel = selectTag == e;
              return Container(
                width: 105.w,
                height: 35.w,
                margin: EdgeInsets.only(
                    left: index == 0 ? 0 : 7.w, right: index == 0 ? 2 : 7.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.w)),
                  color: isSel
                      ? BColors.mainColor.withOpacity(0.1)
                      : const Color(0xffF6F6FA),
                ),
                alignment: Alignment.center,
                child: BaseText(
                  text: e,
                  color: isSel ? BColors.mainColor : const Color(0xff333333),
                ),
              ).withOnTap(onTap: () {
                selectTag = e;
                state.reqPrint.categoryType = e == '全部'?'':e;
                setState(() {});
              });
            }).toList(),
          ),
          SizedBox(
            height: 5.w,
          ),
          _itemWidget(title: '交易币种', content: '人民币').withOnTap(onTap: () {
            SheetBottom.show(
              title: '请选择',
              rightWidget: Image(
                image: 'close'.png3x,
                width: 16.w,
                height: 16.w,
              ).withOnTap(onTap: () => Get.back()),
              child: ShowAlterItem(
                titleList: const ['人民币'],
                selectTitle: '人民币',
                callBack: (e) {

                },
              ),
            );
          }),
          Container(width: 360.w, height: 0.8.w, color: Color(0xffF4F4F6)),
          _itemWidget(
            title: '交易类型',
            content: state.reqPrint.transactionType == ''?'全部':state.reqPrint.transactionType,
          ).withOnTap(onTap: () {
            SheetBottom.show(
              title: '请选择',
              rightWidget: Image(
                image: 'close'.png3x,
                width: 16.w,
                height: 16.w,
              ).withOnTap(onTap: () => Get.back()),
              child:  ShowAlterItem(
                titleList: const[
                  '全部',
                  '收入',
                  '支出',
                ],
                selectTitle: state.reqPrint.transactionType == ''?'全部':state.reqPrint.transactionType,
                callBack: (e) {
                  if(e == '全部'){
                    state.reqPrint.transactionType = '';
                  }else {
                    state.reqPrint.transactionType = e;
                  }
                  setState(() {});
                },
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _itemWidget({String title = '', String content = '', Widget? child}) {
    return Container(
      height: 45.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              BaseText(text: title, color: Color(0xff333333), fontSize: 15),
              SizedBox(
                width: 27.w,
              ),
              child ??
                  BaseText(
                    text: content,
                    color: Color(0xff2E2E30),
                    fontSize: 15,
                  ),
            ],
          ),
          child == null
              ? Image(
                  image: 'ic_jt_right'.png3x,
                  width: 25.w,
                  height: 25.w,
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
