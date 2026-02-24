import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:psbc/pages/other/customer_service/customer_service_view.dart';
import 'package:psbc/routes/app_pages.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';

class RightWidget {

 static List<Widget> widget1({Color? color}){
    return [
      SizedBox(
        width: 10.w,
      ),
      Image(
        width: 37.w,
        height: 37.w,
        image: 'home_right_khfw'.png3x,
      ).withOnTap(onTap:() => Get.to(() => CustomerServicePage())),
      SizedBox(
        width: 12.w,
      ),
      Image(
          width: 22.w,
          height: 22.w,
          color: color,
          image: 'right_tag1'.png3x,).withOnTap(onTap: () => Get.offAllNamed(Routes.tabs)),
      SizedBox(
        width: 16.w,
      ),
    ];
  }

}