import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:psbc/utils/color_util.dart';
import 'package:wb_base_widget/component/grid_view_widget.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../../utils/abc_button.dart';
import 'bill_detail_logic.dart';
import 'bill_detail_state.dart';

class BillDetailCat extends StatefulWidget {
  const BillDetailCat({super.key});

  @override
  State<BillDetailCat> createState() => _BillDetailCatState();
}

class _BillDetailCatState extends State<BillDetailCat> {
  List titleName1 = [
    '购物消费',
    '交通出行',
    '休闲娱乐',
    '文体教育',
    '日常生活',
    '医疗健康',
    '充值缴费',
    '公益',
    '保险',
    '转账给他人',
    '还款',
    '其他支出',
    '餐饮美食',
    '服饰美容',
    '数码家电',
    '家居家装',
    '酒店旅游',
    '住房租房',
    '爱车养车',
    '先进支出',
    '红包',
    '手续费',
    '贵金属',
    '社保公积金'
  ];

  List titleName1_1 = [
    '薪酬',
    '借款',
    '退款',
    '利息收入',
    '投资收益',
    '报销补贴',
    '社保公积金',
    '他人转入',
    '现金收入',
    '其他收入',
    '贵金属',
    '公益',
    '手续费',
    '住房租房',
  ];

  List titleName2 = [
    '转给自己',
    '基金',
    '债券',
    '股票',
    '理财产品',
    '定期',
    '外汇',
    '贵金属',
    '其他投资',
    '数字人民币'
  ];

  final BillDetailLogic logic = Get.put(BillDetailLogic());
  final BillDetailState state = Get.find<BillDetailLogic>().state;

  String selectName = '';
  String selectImg = '';

  @override
  void initState() {
    super.initState();
    selectName = logic.categoryText.value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.sh * 0.65,
      width: 1.sw,
      color: Colors.white,
      child: Column(
        children: [
          ListView(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            children: [
              BaseText(
                  text:state.billDetail.type == '1'?'收入':"支出",
                  fontSize: 16.sp,
                  style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w600))
                  .withPadding(
                top: 12.w,
                left: 12.w,
                bottom: 15.w,
              ),
              state.billDetail.type == '1'? VerticalGridView(
                padding: EdgeInsets.only(left: 12.w, right: 12.w),
                spacing: 20.w,
                widgetBuilder: (context, index) {
                  return Column(
                    children: [
                      //c_0@3x
                      Image(
                        image: selectName != titleName1_1[index]
                            ? 'a_${index}_$index'.png3x
                            : 'a_$index'.png3x,
                        width: 32.w,
                        height: 32.w,
                      ),
                      SizedBox(
                        height: 4.w,
                      ),
                      BaseText(
                        text: titleName1_1[index],
                        style: TextStyle(
                          fontSize: 12.sp,
                          // fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ).withOnTap(onTap: () {
                    logic.temCategoryText = titleName1_1[index];
                    selectImg = 'a_${index}_$index';
                    selectName = titleName1_1[index];
                    setState(() {});
                  });
                },
                itemCount: titleName1_1.length,
                mainHeight: 55,
              ): VerticalGridView(
                padding: EdgeInsets.only(left: 12.w, right: 12.w),
                spacing: 20.w,
                widgetBuilder: (context, index) {
                  return Column(
                    children: [
                      //c_0@3x
                      Image(
                        image: selectName != titleName1[index]
                            ? 'a_${index}_$index'.png3x
                            : 'a_$index'.png3x,
                        width: 32.w,
                        height: 32.w,
                      ),
                      SizedBox(
                        height: 4.w,
                      ),
                      BaseText(
                        text: titleName1[index],
                        style: TextStyle(
                          fontSize: 12.sp,
                          // fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ).withOnTap(onTap: () {
                    logic.temCategoryText = titleName1[index];
                    selectImg = 'a_${index}_$index';
                    selectName = titleName1[index];
                    setState(() {});
                  });
                },
                itemCount: titleName1.length,
                mainHeight: 55,
              ),
              BaseText(
                  text: "本人资金来往",
                  style:
                  TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w600))
                  .withPadding(
                top: 30.w,
                left: 12.w,
                bottom: 15.w,
              ),
              VerticalGridView(
                padding: EdgeInsets.only(left: 12.w, right: 12.w),
                spacing: 20.w,
                widgetBuilder: (context, index) {
                  return Column(
                    children: [
                      Image(
                        image: titleName2[index] != selectName
                            ? 'b_${index}_$index'.png3x
                            : 'b_$index'.png3x,
                        width: 32.w,
                        height: 32.w,
                      ),
                      SizedBox(
                        height: 8.w,
                      ),
                      BaseText(
                        text: titleName2[index],
                        style: TextStyle(
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ).withOnTap(onTap: () {
                    logic.temCategoryText = titleName2[index];
                    selectImg = 'b_${index}_$index';
                    selectName = titleName2[index];
                    setState(() {});
                  });
                },
                itemCount: titleName2.length,
                mainHeight: 58,
              ),
            ],
          ).expanded(),

          AbcButton(
            title: '确定',
            height: 42.w,
            radius: 6.w,
            bgColor: BColors.mainColor,
            onTap: () {
              logic.categoryText.value = logic.temCategoryText;
              logic.categoryImg.value = selectImg;
              Get.back();
            },
            margin: EdgeInsets.only(left: 12.w, right: 12.w),
          ).withPadding(
            top: 10.w,
            bottom: 12.w
          ),
        ],
      ),
    );
  }
}
