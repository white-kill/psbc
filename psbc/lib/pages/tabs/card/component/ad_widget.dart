import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:psbc/utils/color_util.dart';
import 'package:wb_base_widget/wb_base_widget.dart';

class AdWidget extends StatefulWidget {
  const AdWidget({super.key});

  @override
  State<AdWidget> createState() => _AdWidgetState();
}

class _AdWidgetState extends State<AdWidget> {
  List<String> dataList = [
   'card_ad1',
   'card_ad2',
  ];

  void jumpPage(String name) {
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 128.w,
      width: 1.sw,
      color: Colors.white,
      child: SwiperHorizontal(
          itemCount: dataList.length,
          activeColor: BColors.mainColor,
          loop: true,
          autoplay: true,
          color: const Color(0xffEAEAEE),
          widgetBuilder: (_, index) {
            return Container(
              padding: EdgeInsets.only(bottom: 12.w,left: 12.w,right: 12.w),
              child: Image(image: dataList[index].png3x,width: 1.sw,height: 105.w,),
            );
          }),
    );
  }

}
