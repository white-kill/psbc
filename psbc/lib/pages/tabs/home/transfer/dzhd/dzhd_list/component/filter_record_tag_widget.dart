import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:psbc/utils/color_util.dart';
import 'package:wb_base_widget/component/grid_view_widget.dart';
import 'package:wb_base_widget/component/text_field_widget.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../dzhd_list_logic.dart';
import '../dzhd_list_state.dart';

class FilterRecordTagWidget1 extends StatefulWidget {
  const FilterRecordTagWidget1({super.key});

  @override
  State<FilterRecordTagWidget1> createState() => _FilterRecordTagWidgetState();
}

class _FilterRecordTagWidgetState extends State<FilterRecordTagWidget1> {
  List data1 = ['全部','手机银行','个人网银'];
  List data2 = ['全部','行内转账','跨行转账'];
  List data3 = ['全部','转入','转出'];

  final Dzhd_listLogic logic = Get.find<Dzhd_listLogic>();
  final Dzhd_listState state = Get.find<Dzhd_listLogic>().state;


  @override
  void initState() {
    super.initState();
    state.temType1 = state.type1;
    state.temType2 = state.type2;
    state.temType3 = state.type3;

  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 1.sw,
        height: 1.sh * 0.68,
        child: Column(
          children: [
            ListView(
              padding: EdgeInsets.only(bottom: 25.w),
              children: [
                BaseText(
                  text: '金额',
                  fontSize: 14.sp,
                ).withPadding(
                  top: 25.w,
                  left: 16.w,
                  right: 16.w,
                ),
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
                        hintText: '最小金额',
                        textAlign: TextAlign.center,
                        controller: state.amountController1,
                        hintStyle: TextStyle(
                          fontSize: 14.sp,
                          color: const Color(0xffCBCBCB),
                        ),
                      ),
                    ),
                    Container(
                      width: 8.w,
                      height: 1.w,
                      color: Color(0xffdedede),
                      margin: EdgeInsets.only(left: 21.w, right: 21.w),
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
                        hintText: '最大金额',
                        controller: state.amountController2,
                        textAlign: TextAlign.center,
                        hintStyle: TextStyle(
                          fontSize: 14.sp,
                          color: const Color(0xffCBCBCB),
                        ),
                      ),
                    )
                  ],
                ).withPadding(top: 15.w),

                BaseText(
                  text: '转账渠道',
                  fontSize: 14.sp,
                ).withPadding(top: 25.w, left: 16.w, right: 16.w, bottom: 15.w),
                VerticalGridView(
                  padding: EdgeInsets.only(left: 16.w, right: 16.w),
                  widgetBuilder: (_, index) {
                    String title = data1[index];
                    return Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: title == state.temType1
                                  ?BColors.mainColor.withOpacity(0.1)
                                  :Color(0xffF6F6FA),
                              borderRadius:
                              BorderRadius.all(Radius.circular(6.w))),
                          alignment: Alignment.center,
                          child: BaseText(
                            text: data1[index],
                            style: TextStyle(
                                color: title == state.temType1?BColors.mainColor:Color(0xff333333),
                                fontSize: 13.sp,),
                          ),
                        ),
                        state.temType1== title?Positioned(
                          bottom: 0,
                          right: 0,
                          child: Image(
                            image: 'tag_select'.png3x,
                            width: 16.w,
                            height: 16.w,
                          ),):const SizedBox.shrink()
                      ],
                    ).withOnTap(onTap: (){
                      state.temType1 = title;
                      setState(() {});
                    });
                  },
                  itemCount: data1.length,
                  crossCount: 3,
                  mainHeight: 28.w,
                  spacing: 15.w,
                ),
                BaseText(
                  text: '交易类型',
                  fontSize: 14.sp,
                ).withPadding(top: 25.w, left: 16.w, right: 16.w, bottom: 15.w),
                VerticalGridView(
                  padding: EdgeInsets.only(left: 16.w, right: 16.w),
                  widgetBuilder: (_, index) {
                    String title = data2[index];
                    return Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: title == state.temType2
                                  ?BColors.mainColor.withOpacity(0.1)
                                  :Color(0xffF6F6FA),
                              borderRadius: BorderRadius.all(Radius.circular(6.w))),
                          alignment: Alignment.center,
                          child: BaseText(
                            text: data2[index],
                            style: TextStyle(
                                color: title == state.temType2?BColors.mainColor:Color(0xff333333),
                                fontSize: 13.sp),
                          ),
                        ),

                        state.temType2.contains(data2[index])?Positioned(
                          bottom: 0,
                          right: 0,
                          child: Image(
                            image: 'tag_select'.png3x,
                            width: 16.w,
                            height: 16.w,
                          ),):const SizedBox.shrink()
                      ],
                    ).withOnTap(onTap: () {
                      state.temType2 = data2[index];
                      setState(() {});
                    });
                  },
                  itemCount: data2.length,
                  crossCount: 3,
                  mainHeight: 28.w,
                  spacing: 15.w,
                ),
                BaseText(
                  text: '转入转出',
                  fontSize: 14.sp,
                ).withPadding(top: 25.w, left: 16.w, right: 16.w, bottom: 15.w),
                VerticalGridView(
                  padding: EdgeInsets.only(left: 16.w, right: 16.w),
                  widgetBuilder: (_, index) {
                    String title = data3[index];
                    return Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: title == state.temType3
                                  ?BColors.mainColor.withOpacity(0.1)
                                  :Color(0xffF6F6FA),
                              borderRadius: BorderRadius.all(Radius.circular(6.w))),
                          alignment: Alignment.center,
                          child: BaseText(
                            text: data3[index],
                            style: TextStyle(
                                color: title == state.temType3?BColors.mainColor:Color(0xff333333),
                                fontSize: 13.sp),
                          ),
                        ),

                        state.temType3.contains(data3[index])?Positioned(
                          bottom: 0,
                          right: 0,
                          child: Image(
                            image: 'tag_select'.png3x,
                            width: 16.w,
                            height: 16.w,
                          ),):const SizedBox.shrink()

                      ],
                    ).withOnTap(onTap: () {
                      state.temType3 = data3[index];
                      setState(() {});
                    });
                  },
                  itemCount: data3.length,
                  crossCount: 3,
                  mainHeight: 28.w,
                  spacing: 15.w,
                ),
              ],
            ).expanded(),
            Container(
              width: 1.sw,
              height: 0.6.w,
              color: Color(0xffdedede),
            ),
            Container(
              height: 46.w,
              width: 1.sw,
              margin: EdgeInsets.only(
                top: 10.w,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 42.w,
                    width: 1.sw / 2 - 40.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xff999999),
                          width: 0.5.w,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(12.w))),
                    child: BaseText(
                      text: '重置',
                      fontSize: 16.sp,
                    ),
                  ).withOnTap(
                    onTap: () {
                      state.temType1 = '全部';
                      state.temType2 = '全部';
                      state.temType3 = '全部';
                      state.amountController1.text = '';
                      state.amountController2.text = '';
                      setState(() {});
                    },
                  ),
                  SizedBox(
                    width: 32.w,
                  ),
                  Container(
                    height: 42.w,
                    width: 1.sw / 2 - 40.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12.w)),
                      color: BColors.mainColor,
                    ),
                    child: BaseText(
                      text: '查询',
                      fontSize: 16.sp,
                      color: Colors.white,
                    ),
                  ).withOnTap(
                    onTap: () {
                      logic.sureFilterButton();
                    },
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
