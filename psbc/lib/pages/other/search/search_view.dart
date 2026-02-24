import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:psbc/pages/other/search/search_info/search_info_view.dart';
import 'package:wb_base_widget/component/text_field_widget.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/wb_base_widget.dart';

import '../change_nav/change_nav_view.dart';
import 'search_logic.dart';
import 'search_state.dart';

class SearchPage extends BaseStateless {
  SearchPage({Key? key}) : super(key: key);

  final SearchLogic logic = Get.put(SearchLogic());
  final SearchState state = Get.find<SearchLogic>().state;

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
              onSubmitted: (v){
                if(v == ''){
                  '请输入搜索内容'.showToast;
                  return;
                }
                Get.to(() => SearchInfoPage(),arguments: {
                  'title':v
                });
              },
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
            ).withOnTap(onTap: (){
              if(state.searchController.text == ''){
                '请输入搜索内容'.showToast;
                return;
              }
              Get.to(() => SearchInfoPage(),arguments: {
                'title':state.searchController.text
              });
            })
          ],
        ),
      );

  Widget initBody(BuildContext context) {
    return ListView(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BaseText(
              text: '历史记录',
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 12.w,),
            Wrap(
              direction: Axis.horizontal,
              spacing: 12.w,
              runSpacing: 12.w,
              children: state.nameList.map((e) {
                return Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 6.w, horizontal: 10.w),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(15.w),
                  ),
                  child: Text(
                    e,
                    style: TextStyle(
                      fontSize: 12.sp,
                    ),
                  ).withOnTap(onTap: () {
                    Get.to(() => SearchInfoPage(),arguments: {
                      'title':e
                    });
                  }),
                );
              }).toList(),
            ).withPadding(left: 8.w),
          ],
        ).withContainer(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8.w))),
            padding: EdgeInsets.only(
              bottom: 18.w,
              left: 12.w,right: 12.w,
              top: 20.w,
            )),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BaseText(
              text: '搜索发现',
              style: TextStyle(
                  fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 12.w,),
            Wrap(
              direction: Axis.horizontal,
              spacing: 12.w,
              runSpacing: 12.w,
              children: state.discoverList.map((e) {
                return Container(
                  padding:
                  EdgeInsets.symmetric(vertical: 6.w, horizontal: 10.w),
                  decoration: BoxDecoration(
                    color: Color(0xffFCF1E6),
                    borderRadius: BorderRadius.circular(15.w),
                  ),
                  child: Text(
                    e,
                    style: TextStyle(
                      fontSize: 12.sp,
                    ),
                  ).withOnTap(onTap: () {
                    if(e == '邮享贷'){
                      Get.to(() => ChangeNavPage(),arguments: {
                        'image':'youxiang',
                        'title':'邮享贷'
                      });
                    }
                    if(e == '数字人民币'){
                      Get.to(() => ChangeNavPage(),arguments: {
                        'image':'szrmb',
                        'title':'数字人民币'
                      });
                    }
                  }),
                );
              }).toList(),
            ).withPadding(left: 8.w),
          ],
        ).withContainer(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8.w))),
            padding: EdgeInsets.only(
              bottom: 15.w,
              left: 12.w,right: 12.w,
            )),
        Image(image: 'search_hot'.png3x),
      ],
    );
  }
}
