import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:psbc/utils/color_util.dart';
import 'package:wb_base_widget/component/text_field_widget.dart';
import 'package:wb_base_widget/extension/double_extension.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../print_logic.dart';
import '../print_state.dart';

class MoreWidget extends StatefulWidget {
  const MoreWidget({super.key});

  @override
  State<MoreWidget> createState() => _MoreWidgetState();
}

class _MoreWidgetState extends State<MoreWidget> {
  List timeTag = [
    '0-5,000',
    '5,000-10,000',
    '10,000以上',
  ];
  TextEditingController amountController1 = TextEditingController();
  TextEditingController amountController2 = TextEditingController();

  final PrintLogic logic = Get.find<PrintLogic>();
  final PrintState state = Get.find<PrintLogic>().state;

  bool showMore = false;
  String selectTag = '';
  bool show1 = false;


  void selectPrice(String tag){

    if(tag == '0-5,000'){
      amountController1.text = 0.00.toString();
      amountController2.text = 5000.00.toString();
      state.reqPrint.minAmount = '0';
      state.reqPrint.maxAmount = '5000';
    }
    if(tag == '5,000-10,000'){
      amountController1.text = 5000.00.toString();
      amountController2.text = 10000.00.toString();
      state.reqPrint.minAmount = '5000';
      state.reqPrint.maxAmount = '10000';
    }
    if(tag == '10,000以上'){
      amountController1.text = 10000.00.toString();
      amountController2.text = '';
      state.reqPrint.minAmount = '10000';
      state.reqPrint.maxAmount = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 1.sw,
          height: 38.w,
          padding: EdgeInsets.only(right: 8.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              BaseText(text: '更多筛选'),
              Image(
                image: 'ic_jt_bottom'.png3x,
                width: 22.w,
                height: 22.w,
              )
            ],
          ).withOnTap(onTap: (){
            showMore = !showMore;
            setState(() {});
          }),
        ),
        showMore? Container(
          width: 1.sw,
          color: Colors.white,
          padding: EdgeInsets.only(left: 15.w, right: 12.w, top: 20.w),
          margin: EdgeInsets.only(bottom: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween
               ,
               children: [
               BaseText(
                 text: '显示收入及支出汇总金额',
                 style: TextStyle(
                   color: Color(0xff2E2E30),
                   fontSize: 15,
                 ),
               ),
               CupertinoSwitch(
                   value: show1,
                   // activeTrackColor: Color.fromARGB(255, 3, 134, 91),
                   activeColor: Color.fromARGB(255, 3, 134, 91),
                   onChanged: (bool value) {
                     show1 = value;
                     if(value){
                       state.showTypeList.remove('2');
                       state.showTypeList.add('2');
                     }else {
                       state.showTypeList.remove('2');
                     }
                     setState(() {});
                   }).sw()
             ],),
              SizedBox(height: 12.w),

              BaseText(text: '金额区间'),
              SizedBox(height: 12.w),

              Row(
                children: timeTag.map((e) {
                  int index = timeTag.indexOf(e);
                  return Container(
                    width: 105.w,
                    height: 35.w,
                    margin: EdgeInsets.only(
                        left: index == 0 ? 0 : 7.w,
                        right: index == 0 ? 2 : 7.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5.w)),
                        color: selectTag == e?BColors.mainColor.withOpacity(0.2):Color(0xffF6F6FA)),
                    alignment: Alignment.center,
                    child: BaseText(text: e,color: selectTag == e?BColors.mainColor:Color(0xff333333),),
                  ).withOnTap(onTap: (){
                    selectTag = e;
                    selectPrice(e);
                    setState(() {});
                  });
                }).toList(),
              ),
              SizedBox(height: 12.w),

              BaseText(text: '自定义区间'),
              SizedBox(height: 12.w),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 150.w,
                    height: 36.w,
                    padding: EdgeInsets.only(left: 6.w),
                    decoration: BoxDecoration(
                      color: const Color(0xffF3F7F8),
                      borderRadius: BorderRadius.all(Radius.circular(4.w)),
                    ),
                    child: TextFieldWidget(
                      hintText: '请输入最低金额',
                      textAlign: TextAlign.center,
                      controller: amountController1,
                      keyboardType: TextInputType.datetime,
                      onChanged: (v){
                        selectTag  = '';
                        state.reqPrint.minAmount = v;
                        setState(() {});
                      },
                      hintStyle: TextStyle(
                        fontSize: 15,
                        color: const Color(0xffCBCBCB),
                      ),
                    ),
                  ),
                  Container(
                    width: 8.w,
                    height: 1.w,
                    color: Color(0xffdedede),
                    margin: EdgeInsets.only(left: 16.w, right: 16.w),
                  ),
                  Container(
                    width: 150.w,
                    height: 36.w,
                    padding: EdgeInsets.only(left: 6.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4.w)),
                      color: const Color(0xffF3F7F8),
                    ),
                    child: TextFieldWidget(
                      hintText: '请输入最高金额',
                      controller: amountController2,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.datetime,
                      onChanged: (v){
                        selectTag  = '';
                        state.reqPrint.maxAmount = v;
                        setState(() {});
                      },
                      hintStyle: TextStyle(
                        fontSize: 15,
                        color: const Color(0xffCBCBCB),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20.w),
            ],
          ),
        ):const SizedBox.shrink(),
      ],
    );
  }
}
