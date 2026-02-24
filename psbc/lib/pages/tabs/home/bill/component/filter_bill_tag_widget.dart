import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:psbc/utils/color_util.dart';
import 'package:wb_base_widget/component/grid_view_widget.dart';
import 'package:wb_base_widget/component/text_field_widget.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../bill_logic.dart';
import '../bill_state.dart';

class FilterBillTagWidget extends StatefulWidget {
  const FilterBillTagWidget({super.key});

  @override
  State<FilterBillTagWidget> createState() => _FilterBillTagWidgetState();
}

class _FilterBillTagWidgetState extends State<FilterBillTagWidget> {
  List data0 = ['全部支出', '全部收入'];
  List data1 = ['人民币'];
  List data2 = ['全部收入', '退款', '他人转入', '其他收入'];
  List data3 = [
    '全部支出',
    '购物消费',
    '交通出行',
    '休闲娱乐',
    '文体教育',
    '日常生活',
    '医疗健康',
    '充值缴费',
    '转账给他人',
    '还款',
    '餐饮美食',
    '服饰美容',
    '家居家装',
    '其他支出'
  ];
  List data4 = ['转账给自己'];
  List data5 = ['全部渠道', '手机银行', '个人网银', '微信银行', '网点柜面', '电话银行', '其他'];

  final BillLogic logic = Get.find<BillLogic>();
  final BillState state = Get.find<BillLogic>().state;

  Color selectColor(String name, {String type = '1'}) {
    if (selectName(name, type: type)) return BColors.mainColor.withOpacity(0.1);
    return const Color(0xffF6F6FA);
  }

  Color selectTextColor(String name, {String type = '1'}) {
    if (selectName(name, type: type)) return BColors.mainColor;
    return const Color(0xff333333);
  }

  bool selectName(String name, {String type = '1'}) {
    return state.temCategory.contains(name);
  }

  void addTag(String name) {
    if (data5.contains(name)) {
      if (name == '全部渠道') {
        if(state.temCategory.contains('全部渠道')){
          state.temCategory.remove(name);
        }else{
          state.temCategory.removeWhere((element) => data5.contains(element));
          state.temCategory.add(name);
        }
      } else {
        state.temCategory.remove('全部渠道');
        if(state.temCategory.contains(name)){
          state.temCategory.remove(name);
        }else {
          state.temCategory.add(name);
        }
      }
    }else  if (data2.contains(name) || name == '全部收入') {
      if (name == '全部收入') {
        if(state.temCategory.contains('全部收入')){
          state.temCategory.remove(name);
        }else{
          state.temCategory.removeWhere((element) => data2.contains(element));
          state.temCategory.add(name);
        }
      } else {
        state.temCategory.remove('全部收入');
        if(state.temCategory.contains(name)){
          state.temCategory.remove(name);
        }else {
          state.temCategory.add(name);
        }
      }
    } else if (data3.contains(name) || name == '全部支出') {
      if (name == '全部支出') {
        if(state.temCategory.contains('全部支出')){
          state.temCategory.remove(name);
        }else {
          state.temCategory.removeWhere((element) => data3.contains(element));
          state.temCategory.add(name);
        }
      } else {
        state.temCategory.remove('全部支出');
        if(state.temCategory.contains(name)){
          state.temCategory.remove(name);
        }else {
          state.temCategory.add(name);
        }
      }
    } else {
      if (state.temCategory.contains(name)) {
        state.temCategory.remove(name);
      } else {
        state.temCategory.add(name);
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    state.temCategory.clear();
    state.temCategory.addAll(state.category);
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
                // Container(
                //   width: 1.sw,
                //   height: 30.w,
                //   margin: EdgeInsets.only(
                //       right: 15.w, top: 12.w, bottom: 6.w, left: 15.w),
                //   decoration: BoxDecoration(
                //       color: const Color(0xffF5F5F5),
                //       borderRadius: BorderRadius.all(Radius.circular(15.w))),
                //   child: Row(
                //     children: [
                //       Image(
                //         image: 'ic_search_left'.png3x,
                //         width: 15.w,
                //         height: 15.w,
                //       ).withContainer(
                //         padding: EdgeInsets.only(left: 12.w, right: 12.w),
                //       ),
                //       TextFieldWidget(
                //         hintText: '请输入收/付款人姓名/卡号/手机号/附言搜索',
                //         style: TextStyle(
                //           color: Colors.black,
                //           fontSize: 14.sp,
                //         ),
                //         // controller: state.searchController,
                //       ).expanded()
                //     ],
                //   ),
                // ),
                BaseText(
                  text: '快捷筛选',
                  fontSize: 14.sp,
                ).withPadding(top: 25.w, left: 16.w, right: 16.w, bottom: 15.w),
                VerticalGridView(
                  padding: EdgeInsets.only(left: 16.w, right: 16.w),
                  widgetBuilder: (_, index) {
                    return Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: selectColor(data0[index]),
                              borderRadius:
                              BorderRadius.all(Radius.circular(6.w))),
                          alignment: Alignment.center,
                          child: BaseText(
                            text: data0[index],
                            style: TextStyle(
                                fontWeight: selectName(data0[index])
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: selectTextColor(data0[index]),
                                fontSize: 13.sp),
                          ),
                        ),
                        state.temCategory.contains(data0[index])
                            ? Positioned(
                          bottom: 0,
                          right: 0,
                          child: Image(
                            image: 'tag_select'.png3x,
                            width: 16.w,
                            height: 16.w,
                          ),
                        ) : const SizedBox.shrink()
                      ],
                    ).withOnTap(onTap: () {
                      addTag(data0[index]);
                    });
                  },
                  itemCount: data0.length,
                  crossCount: 3,
                  mainHeight: 28.w,
                  spacing: 15.w,
                ),

                BaseText(
                  text: '币种',
                  fontSize: 14.sp,
                ).withPadding(top: 25.w, left: 16.w, right: 16.w, bottom: 15.w),
                VerticalGridView(
                  padding: EdgeInsets.only(left: 16.w, right: 16.w),
                  widgetBuilder: (_, index) {
                    return Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: BColors.mainColor.withOpacity(0.1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6.w))),
                          alignment: Alignment.center,
                          child: BaseText(
                            text: data1[index],
                            style: TextStyle(
                                color: BColors.mainColor, fontSize: 13.sp),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Image(
                            image: 'tag_select'.png3x,
                            width: 16.w,
                            height: 16.w,
                          ),
                        )
                      ],
                    );
                  },
                  itemCount: data1.length,
                  crossCount: 3,
                  mainHeight: 28.w,
                  spacing: 15.w,
                ),
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
                      height: 34.w,
                      padding: EdgeInsets.only(left: 6.w),
                      decoration: BoxDecoration(
                        color: const Color(0xffF6F6FA),
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
                      height: 34.w,
                      padding: EdgeInsets.only(left: 6.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(4.w)),
                        color: const Color(0xffF6F6FA),
                        // border: Border.all(
                        //   color: const Color(0xffCBCBCB),
                        //   width: 1.w,
                        // ),
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
                  text: '收入',
                  fontSize: 14.sp,
                ).withPadding(top: 25.w, left: 16.w, right: 16.w, bottom: 15.w),
                VerticalGridView(
                  padding: EdgeInsets.only(left: 16.w, right: 16.w),
                  widgetBuilder: (_, index) {
                    return Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: selectColor(data2[index]),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6.w))),
                          alignment: Alignment.center,
                          child: BaseText(
                            text: data2[index],
                            style: TextStyle(
                                fontWeight: selectName(data2[index])
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: selectTextColor(data2[index]),
                                fontSize: 13.sp),
                          ),
                        ),
                        state.temCategory.contains(data2[index])
                            ? Positioned(
                                bottom: 0,
                                right: 0,
                                child: Image(
                                  image: 'tag_select'.png3x,
                                  width: 16.w,
                                  height: 16.w,
                                ),
                              )
                            : const SizedBox.shrink()
                      ],
                    ).withOnTap(onTap: () {
                      addTag(data2[index]);
                    });
                  },
                  itemCount: data2.length,
                  crossCount: 3,
                  mainHeight: 28.w,
                  spacing: 15.w,
                ),
                BaseText(
                  text: '支出',
                  fontSize: 14.sp,
                ).withPadding(top: 25.w, left: 16.w, right: 16.w, bottom: 15.w),
                VerticalGridView(
                  padding: EdgeInsets.only(left: 16.w, right: 16.w),
                  widgetBuilder: (_, index) {
                    return Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: selectColor(data3[index]),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6.w))),
                          alignment: Alignment.center,
                          child: BaseText(
                            text: data3[index],
                            style: TextStyle(
                                fontWeight: selectName(data3[index])
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: selectTextColor(data3[index]),
                                fontSize: 13.sp),
                          ),
                        ),
                        state.temCategory.contains(data3[index])
                            ? Positioned(
                                bottom: 0,
                                right: 0,
                                child: Image(
                                  image: 'tag_select'.png3x,
                                  width: 16.w,
                                  height: 16.w,
                                ),
                              )
                            : const SizedBox.shrink()
                      ],
                    ).withOnTap(onTap: () {
                      addTag(data3[index]);
                    });
                  },
                  itemCount: data3.length,
                  crossCount: 3,
                  mainHeight: 28.w,
                  spacing: 15.w,
                ),
                BaseText(
                  text: '本人资金来往',
                  fontSize: 14.sp,
                ).withPadding(top: 25.w, left: 16.w, right: 16.w, bottom: 15.w),
                VerticalGridView(
                  padding: EdgeInsets.only(left: 16.w, right: 16.w),
                  widgetBuilder: (_, index) {
                    return Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: selectColor(data4[index]),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6.w))),
                          alignment: Alignment.center,
                          child: BaseText(
                            text: data4[index],
                            style: TextStyle(
                                fontWeight: selectName(data4[index])
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: selectTextColor(data4[index]),
                                fontSize: 13.sp),
                          ),
                        ),
                        state.temCategory.contains(data4[index])
                            ? Positioned(
                                bottom: 0,
                                right: 0,
                                child: Image(
                                  image: 'tag_select'.png3x,
                                  width: 16.w,
                                  height: 16.w,
                                ),
                              )
                            : const SizedBox.shrink()
                      ],
                    ).withOnTap(onTap: () {
                      addTag(data4[index]);
                    });
                  },
                  itemCount: data4.length,
                  crossCount: 3,
                  mainHeight: 28.w,
                  spacing: 15.w,
                ),
                BaseText(
                  text: '交易渠道',
                  fontSize: 14.sp,
                ).withPadding(top: 25.w, left: 16.w, right: 16.w, bottom: 15.w),
                VerticalGridView(
                  padding: EdgeInsets.only(left: 16.w, right: 16.w),
                  widgetBuilder: (_, index) {
                    return Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: selectColor(data5[index]),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6.w))),
                          alignment: Alignment.center,
                          child: BaseText(
                            text: data5[index],
                            style: TextStyle(
                                fontWeight: selectName(data5[index])
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: selectTextColor(data5[index]),
                                fontSize: 13.sp),
                          ),
                        ),
                        state.temCategory.contains(data5[index])
                            ? Positioned(
                                bottom: 0,
                                right: 0,
                                child: Image(
                                  image: 'tag_select'.png3x,
                                  width: 16.w,
                                  height: 16.w,
                                ),
                              )
                            : const SizedBox.shrink()
                      ],
                    ).withOnTap(onTap: () {
                      addTag(data5[index]);
                    });
                  },
                  itemCount: data5.length,
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
                      state.temCategory.clear();
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
            SizedBox(
              height: 8.w + ScreenUtil().bottomBarHeight,
            ),
          ],
        ));
  }
}
