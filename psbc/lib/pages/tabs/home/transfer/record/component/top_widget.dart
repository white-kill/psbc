import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:psbc/config/app_config.dart';
import 'package:psbc/pages/component/sheet_widget/sheet_bottom.dart';
import 'package:wb_base_widget/component/text_field_widget.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../../component/alter_card_bottom.dart';
import '../record_logic.dart';
import '../record_state.dart';
import 'filter_record_tag_widget.dart';
import 'filter_record_time_widget.dart';

class TopWidget extends StatefulWidget {
  const TopWidget({super.key});

  @override
  State<TopWidget> createState() => _TopWidgetState();
}

class _TopWidgetState extends State<TopWidget> {

  final RecordLogic logic = Get.find<RecordLogic>();
  final RecordState state = Get.find<RecordLogic>().state;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      color: Colors.white,
      padding: EdgeInsets.only(left: 15.w, right: 15.w),
      child: Column(
        children: [

          Container(
            width: 1.sw,
            height: 30.w,
            margin: EdgeInsets.only(right: 15.w,top: 12.w,bottom: 12.w),
            decoration: BoxDecoration(
                color: const Color(0xffF5F5F5),
                borderRadius: BorderRadius.all(Radius.circular(15.w))),
            child: Row(
              children: [
                Image(
                  image: 'ic_search_left'.png3x,
                  width: 15.w,
                  height: 15.w,
                ).withPadding(left: 12.w, right: 12.w),
                TextFieldWidget(
                  hintText:'请输入收/付款人姓名/卡号/手机号/附言搜索',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.sp,
                  ),
                  onSubmitted: (v){
                    logic.search(v);
                  },
                  controller: state.searchController,
                ).expanded()
              ],
            ),
          ),
          SizedBox(
            height: 12.w,
          ),
          GetBuilder(
            builder: (RecordLogic c) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Row(
                    children: [
                      GetBuilder(builder: (RecordLogic c){
                        String title = '';
                        if(c.state.isYear){
                          title = '2020-${state.yearTime}';
                        }else {
                          if(c.state.timeTitle == ''){
                            title = '${c.state.beginTime.replaceAll('-', '.')} - ${c.state.endTime.replaceAll('-', '.')}';
                          }else{
                            title = c.state.timeTitle;
                          }
                        }
                        return _tagWidget(title,).withOnTap(onTap: (){
                          SheetBottom.show(
                            title: '选择时间',
                            leftWidget: Image(
                              image: 'ic_jt_left'.png3x,
                              width: 25.w,
                              height: 25.w,
                            ),
                            child: const FilterRecordTimeWidget(),
                          );
                        });
                      },id: 'updateTime',),
                      SizedBox(
                        width: 15.w,
                      ),
                      _tagWidget('绿卡通${AppConfig.config.abcLogic.cardFour()}').withOnTap(onTap: () {
                        SheetBottom.show(
                          title: '请选择',
                          rightWidget: Image(
                            image: 'close'.png3x,
                            width: 18.w,
                            height: 18.w,
                          ),
                          child: const AlterCardBottom(),
                        );
                      }),
                    ],
                  ),
                  _tagWidget('筛选',)
                      .withOnTap(onTap: () {
                    SheetBottom.show(
                      title: '筛选',
                      leftWidget: Image(
                        image: 'ic_jt_left'.png3x,
                        width: 25.w,
                        height: 25.w,
                      ),
                      child: const FilterRecordTagWidget(),
                    );
                  }),
                ],
              );
            },
            id: 'upDateTopWidget',
          ),
          SizedBox(
            height: 12.w,
          ),
        ],
      ),
    );
  }

  Widget _tagWidget(String content, {Color? color, Widget? child}) {
    return Row(
      children: [
        Row(
          children: [
            BaseText(
              text: content,
              fontSize: 13.sp,
              color: color ?? Color(0xff333333),
            ),
            child ?? SizedBox.shrink(),
          ],
        ),
        SizedBox(
          width: 4.w,
        ),
        Image(
          image: 'arr_dow'.png3x,
          width: 6.w,
          height: 6.w,
          color: Colors.black,
        ),
      ],
    );
  }

}
