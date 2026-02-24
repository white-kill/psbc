import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/component/text_field_widget.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../utils/color_util.dart';
import 'search_info_logic.dart';
import 'search_info_state.dart';

class SearchInfoPage extends BaseStateless {
  SearchInfoPage({Key? key}) : super(key: key);

  final SearchInfoLogic logic = Get.put(SearchInfoLogic());
  final SearchInfoState state = Get.find<SearchInfoLogic>().state;

  @override
  Widget? get titleWidget => Container(
    width: 1.sw,
    height: 32.w,
    margin: EdgeInsets.only(right: 15.w),
    decoration: BoxDecoration(
        border: Border.all(width: 0.5.w, color: Color(0xffdfdfdf)),
        borderRadius: BorderRadius.all(Radius.circular(4.w))),
    child: Row(
      children: [
        Image(
          image: 'home_search_left'.png3x,
          width: 18.w,
          height: 18.w,
        ).withPadding(left: 10.w, right: 6.w),
        Container(width: 0.5, height: 18.w, color: Color(0xffdfdfdf)),
        SizedBox(
          width: 6.w,
        ),
        TextFieldWidget(
          hintText: '输入搜索词',
          controller: state.searchController,
        ).expanded(),
        SizedBox(
          width: 8.w,
        ),
        Container(
          width: 42.w,
          height: 26.w,
          margin: EdgeInsets.only(right: 2.w),
          decoration: BoxDecoration(
            color: Color(0xffdfdfdf),
            borderRadius: BorderRadius.all(Radius.circular(4.w)),
          ),
          alignment: Alignment.center,
          child: BaseText(text: '搜索'),
        )
      ],
    ),
  );

  @override
  Color? get navColor => Color(0xFFF5F5F5);

  @override
  Widget initBody(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      children: [
        Container(
          width: 1.sw,
          height: 42.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: state.titles.map((String name) {
              int index = state.titles.indexOf(name);
              return Obx(() => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BaseText(
                        text: name,
                        style: TextStyle(
                            color: logic.selectTitle.value == index
                                ? BColors.mainColor
                                : Color(0xff666666),
                            fontSize:
                                logic.selectTitle.value == index ? 15 : 14),
                      ),
                      SizedBox(
                        height: 4.w,
                      ),
                      Container(
                        width: 16.w,
                        height: 2.w,
                        decoration: BoxDecoration(
                            color: logic.selectTitle.value == index
                                ? BColors.mainColor
                                : Color(0xFFF5F5F5),
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.w))),
                      )
                    ],
                  ).withOnTap(onTap: () {
                    logic.selectTitle.value = index;
                  }));
            }).toList(),
          ),
        ),
        Column(
          // shrinkWrap: true,
          // physics: const NeverScrollableScrollPhysics(),
          children: [
            Container(
              width: 1.sw,
              margin: EdgeInsets.only(left: 8.w,top: 8.w,right: 8.w),
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFEFECFC),
                    Colors.white,
                  ],
                ),
                borderRadius: BorderRadius.all(Radius.circular(8.w)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BaseText(text: '猜您喜欢'),
                  SizedBox(height: 22.w,),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Image(image: 'search_icon'.png3x,width: 20.w,height: 20.w,),
                          SizedBox(width: 12.w,),
                          BaseText(text: state.list1[index],style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),),
                        ],
                      ).withContainer(
                        height: 45.w,
                        onTap: () => logic.jumpPage(state.list1[index])
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Container(
                        width: 1.sw,
                        height: 0.5.w,
                        color: Color(0xffdedede),
                      );
                    },
                    itemCount: state.list1.length,
                  )
                ],
              ),
            ),

            Container(
              width: 1.sw,
              margin: EdgeInsets.only(left: 8.w,top: 8.w,right: 8.w),
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFE6EBFC),
                    Colors.white,
                  ],
                ),
                borderRadius: BorderRadius.all(Radius.circular(8.w)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BaseText(text: '功能'),
                      Row(
                        children: [
                          BaseText(text: '全部(4)',fontSize: 11,color: Color(0xff666666),),
                          Image(image: 'ic_jt_right'.png3x,width: 15.w,height: 15.w,)
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 22.w,),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image(image: 'search_icon'.png3x,width: 20.w,height: 20.w,),
                          SizedBox(width: 12.w,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BaseText(text: state.list2[index]['title'],style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),),
                              SizedBox(height: 6.w,),
                              BaseText(text: state.list2[index]['content'],fontSize: 12,color: Color(0xff999999),)
                            ],
                          )
                        ],
                      ).withContainer(
                        height: 55.w,
                          onTap: () => logic.jumpPage(state.list2[index]['title'])
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Container(
                        width: 1.sw,
                        height: 0.5.w,
                        color: Color(0xffdedede),
                      );
                    },
                    itemCount: state.list2.length,
                  )
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
