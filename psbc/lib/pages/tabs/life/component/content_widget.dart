import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';

import '../../../other/fixed_nav/fixed_nav_view.dart';
import 'life_indicator.dart';

class ContentWidget extends StatefulWidget {
  const ContentWidget({super.key});

  @override
  State<ContentWidget> createState() => _ContentWidgetState();
}

class _ContentWidgetState extends State<ContentWidget> with SingleTickerProviderStateMixin{

  late TabController tabController;
  List<String> titleName = [
    '精选',
    '本地',
    '热门活动',
    '发现',
  ];

  @override
  void initState() {
    super.initState();
    tabController =
        TabController(length: titleName.length, vsync: this);

    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        _onTabChanged(tabController.index);
      }
    });
  }

  void _onTabChanged(int idx) {
    index = idx;
    setState(() {});
  }

  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller:tabController,
          labelColor: Colors.black,
          tabAlignment: TabAlignment.center,
          labelPadding: EdgeInsets.only(left: 20.w,right: 20.w),
          unselectedLabelColor: const Color(0xff999999),
          labelStyle: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
          unselectedLabelStyle: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
          indicator: PreloadedImageTabIndicator(
            image: 'life_indicator'.png3x,
          ),
          tabs: titleName.map((String name) {
            return  Tab(text: name);
          }).toList(),
        ),
        SizedBox(height: 4.w,),
        ..._contentWidget(),
      ],
    );
  }

  List<Widget> _contentWidget(){
    if(index == 0){
      return [
        Stack(
          children: [
            Image(image: 'lift_content$index'.png3x),
            Positioned(child: Container(
              width: 1.sw,
              height: 220.w,
            ).withOnTap(onTap: (){
              Get.to(() => FixedNavPage(),arguments: {
                'image':'life_czth',
                'navColor':const Color(0xffEBF3EF),
                'background':Colors.white,
                'title':'页面跳转提示'
              });
            })),

            Positioned(top: 260.w,child:Container(
              width: 1.sw,
              height: 140.w,
            ).withOnTap(onTap: (){
              Get.to(() => FixedNavPage(),arguments: {
                'image':'life_ylsc',
                'navColor':const Color(0xffEBF3EF),
                'background':Colors.white,
                'title':'页面跳转提示'
              });
            })),

            Positioned(top: 260.w + 180.w,child:Container(
              width: 1.sw,
              height: 230.w,
            ).withOnTap(onTap: (){
              Get.to(() => FixedNavPage(),arguments: {
                'image':'life_dyp',
                'navColor':const Color(0xffEBF3EF),
                'background':Colors.white,
                'title':'页面跳转提示'
              });
            })),


            Positioned(top: 260.w + 180.w + 290.w,child:Container(
              width: 1.sw,
              height: 100.w,
            ).withOnTap(onTap: (){
              Get.to(() => FixedNavPage(),arguments: {
                'image':'kqzx',
                'background':Colors.white,
                'title':'卡券中心'
              });
            })),


            Positioned(top: 260.w + 180.w + 290.w + 140.w,child:Container(
              width: 1.sw,
              height: 200.w,
            ).withOnTap(onTap: (){
              Get.to(() => FixedNavPage(),arguments: {
                'image':'zhutika',
                'title':'无界文旅卡申请'
              });

            })),
          ],
        )
      ];
    }
    if(index == 1){
      return [
        Image(image: 'lift_content$index'.png3x),
      ];
    }
    if(index == 2){
      return [
        Image(image: 'lift_content$index'.png3x),
      ];
    }
    if(index == 3){
      return [
        Image(image: 'lift_content$index'.png3x),
      ];
    }
    return [];
  }
}
