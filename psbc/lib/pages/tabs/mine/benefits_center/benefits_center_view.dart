import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:psbc/pages/other/customer_service/customer_service_view.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';

import 'benefits_center_logic.dart';
import 'benefits_center_state.dart';

class BenefitsCenterPage extends StatefulWidget {
  const BenefitsCenterPage({Key? key}) : super(key: key);

  @override
  State<BenefitsCenterPage> createState() => _BenefitsCenterPageState();
}

class _BenefitsCenterPageState extends State<BenefitsCenterPage> {
  final BenefitsCenterLogic logic = Get.put(BenefitsCenterLogic());
  final BenefitsCenterState state = Get.find<BenefitsCenterLogic>().state;

  // 根据等级获取导航颜色
  Color _getNavColorByLevel(int level) {
    switch (level) {
      case 1:
        return Color(0xFFCAEAD2);
      case 2:
        return Color(0xFFFDEBE2);
      case 3:
        return Color(0xFFECF5FC);
      case 4:
        return Color(0xFFFFF2E1);
      case 5:
        return Color(0xFFCACEF0);
      case 6:
        return Color(0xFFCCCCE8);
      case 7:
        return Color(0xFFFFDCBB);
      case 8:
        return Color(0xFF14183D);
      default:
        return Color(0xFFCCCCE8);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      Color navColor = _getNavColorByLevel(state.currentLevel.value);
      return Scaffold(
        appBar: AppBar(
          backgroundColor: navColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20.w),
            onPressed: () => Get.back(),
          ),
          title: Text(
            '权益中心',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          actions: [
            SizedBox(width: 10.w),
            Image(
              width: 37.w,
              height: 37.w,
              image: 'home_right_khfw'.png3x,
            ).withOnTap(onTap: () => Get.to(() => CustomerServicePage())),
            SizedBox(width: 12.w),
            Image(
              width: 24.w,
              height: 24.w,
              image: 'bill_more'.png3x,
            ).withOnTap(onTap: () {
              // TODO: 处理更多按钮点击事件
            }),
            SizedBox(width: 16.w),
          ],
        ),
        body: PageView.builder(
          controller: state.pageController,
          onPageChanged: logic.onPageChanged,
          itemCount: 8,
          itemBuilder: (context, index) {
            int level = index + 1;
            return ListView(
              padding: EdgeInsets.zero,
              children: [
                Image(
                  image: 'xinji$level'.png3x,
                  width: 1.sw,
                  fit: BoxFit.fitWidth,
                ),
              ],
            );
          },
        ),
      );
    });
  }

  @override
  void dispose() {
    Get.delete<BenefitsCenterLogic>();
    super.dispose();
  }
}
