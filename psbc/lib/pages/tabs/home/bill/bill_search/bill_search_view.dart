import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/component/text_field_widget.dart';
import 'package:wb_base_widget/extension/double_extension.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../../config/model/bill_serach_model.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../utils/widget_util.dart';
import '../../../../component/sheet_widget/sheet_bottom.dart';
import '../bill_detail/bill_detail_view.dart';
import 'bill_search_logic.dart';
import 'bill_search_state.dart';
import 'filter_search_time_widget.dart';

class BillSearchPage extends BaseStateless {
  BillSearchPage({Key? key}) : super(key: key);

  final BillSearchLogic logic = Get.put(BillSearchLogic());
  final BillSearchState state = Get.find<BillSearchLogic>().state;

  @override
  Color? get background => Colors.white;

  @override
  bool get enablePullDown => false;

  @override
  Widget? get titleWidget => Container(
    width: 1.sw,
    height: 30.w,
    margin: EdgeInsets.only(right: 15.w),
    decoration: BoxDecoration(
        color: const Color(0xffF5F5F5),
        borderRadius: BorderRadius.all(Radius.circular(15.w))),
    child: Row(
      children: [
        Image(
          image: 'ic_search_left'.png3x,
          width: 15.w,
          height: 15.w,
        ).withContainer(
          padding: EdgeInsets.only(left: 12.w, right: 12.w),
        ),
        TextFieldWidget(
          hintText: '请输入收/付款人姓名/卡号/手机号/附言搜索',
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),
          enabled: false,
          hintStyle:  TextStyle(
            fontSize: 12,
          ),
          controller: state.textController,
        ).expanded(onTap: (){
          Get.offAndToNamed(Routes.searchHistoryPage);
        })
      ],
    ),
  );

  @override
  Widget initBody(BuildContext context) {
    return GetBuilder(builder: (BillSearchLogic c){
      return Column(
        children: [
          Container(
            width: 1.sw,
            height: 40.w,
            padding: EdgeInsets.only(left: 12.w,right: 12.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                GetBuilder(builder: (BillSearchLogic c){
                  String title = '';
                  if(c.state.isMonth){
                    title = c.state.mothTime.replaceAll('-', '.');
                  }else {
                    if(c.state.timeTitle == ''){
                      title = '${c.state.beginTime.replaceAll('-', '.')} - ${c.state.endTime.replaceAll('-', '.')}';
                    }else{
                      title = c.state.timeTitle;
                    }
                  }
                  return _tagWidget(title,onTap: (){
                    SheetBottom.show(
                      title: '时间选择',
                      rightWidget: Image(
                        image: 'close'.png3x,
                        width: 16.w,
                        height: 16.w,
                      ).withOnTap(onTap: () => Get.back()),
                      child: const FilterSearchTimeWidget(),
                    );
                  });
                },id: 'updateTime',),
                BaseText(text: '共${state.serachModel.total}笔交易'),],
            ),
          ),
          Container(
            width: 1.sw,
            height: 36.w,
            padding: EdgeInsets.only(left: 12.w,right: 12.w),
            color: const Color(0xFFF5F5F5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BaseText(
                  text: '收入¥${12121.0.bankBalance}',
                  color: Color(0xff666666),
                ),
                BaseText(
                  text: '支出¥${12121.0.bankBalance}',
                  color: Color(0xff666666),
                ),
              ],
            ),
          ),
          Expanded(
              child: refreshWidget(
                  controller: state.refreshController,
                  child: ListView.separated(
                      controller: state.scController,
                      itemBuilder: (context, index) {
                        BillSerachList model = state.list[index];
                        return Container(
                          width: 1.sw,
                          height: 65.w,
                          padding: EdgeInsets.only(left: 12.w,top: 12.w,right: 12.w),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              netImage(
                                url: model.icon,
                                width: 20.w,
                                height: 20.w,
                              ).withPadding(
                                  top: 2.w,right: 8.w
                              ),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      BaseText(
                                        text: model.excerpt,
                                      ).withContainer(
                                        width: 220.w
                                      ),
                                      BaseText(
                                          text: '${logic.type(model.type)}¥${model.amount.bankBalance.replaceAll('-', '')}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 13)),
                                    ],
                                  ),
                                  SizedBox(height: 8.w,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      BaseText(
                                        text: model.bankCard,
                                        fontSize: 11,color: Color(0xff999999),
                                      ),
                                      BaseText(
                                        text: model.transactionTime,
                                        fontSize: 11,color: Color(0xff999999),),
                                    ],
                                  ),
                                ],
                              ).expanded()
                            ],
                          ),
                        ).withOnTap(onTap: () {
                          Get.to(() => BillDetailPage(),
                              arguments: {'model': model.billDetail});
                        });;
                      },
                      separatorBuilder: (context, index) {
                        return Container(
                          width: 1.sw,
                          height: 0.5.w,
                          color: const Color(0xffdedede),
                        );
                      },
                      itemCount: state.list.length)
              ))
        ],
      );
    },id: 'updateUI',);
  }

  Widget _tagWidget(String content, {Function? onTap}) {
    return Row(
      children: [
        Row(
          children: [
            BaseText(
              text: content,
              fontSize: 12,
              color: Color(0xff333333),
            ),
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
    ).withOnTap(onTap: onTap);
  }
}
