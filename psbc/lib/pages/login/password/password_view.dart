import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:psbc/pages/other/customer_service/customer_service_view.dart';
import 'package:psbc/utils/color_util.dart';
import 'package:wb_base_widget/extension/string_extension.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/state_widget/state_less_widget.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import 'password_logic.dart';
import 'password_state.dart';

class PasswordPage extends BaseStateless {
  PasswordPage({Key? key}) : super(key: key);

  final PasswordLogic logic = Get.put(PasswordLogic());
  final PasswordState state = Get.find<PasswordLogic>().state;

  @override
  Color? get background => Colors.white;

  // @override
  // Widget? get leftItem => Icon(
  //       Icons.clear,
  //       size: 24.w,
  //       color: Color(0xFF607483),
  //     ).withOnTap(onTap: () {
  //       Get.back();
  //     });

  @override
  List<Widget>? get rightAction => [
    SizedBox(
      width: 10.w,
    ),
    Image(
      width: 37.w,
      height: 37.w,
      image: 'home_right_khfw'.png3x,
    ).withOnTap(onTap: () => Get.to(() => CustomerServicePage())),
    SizedBox(
      width: 12.w,
    ),
  ];

  @override
  Widget initBody(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.white,
          child: Stack(children: [
            SizedBox(
              height: 1.sh,
              width: 1.sw,
            ),

            Positioned(
              top: 50.w,
              left: 20.w,
              child:Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BaseText(text: logic.getGreeting(),style: TextStyle(
                    fontSize: 23.sp,
                    color: Color(0xff333333),
                  ),),
                  BaseText(text: '请输入${logic.phone.desensitize()}的登录密码',style: TextStyle(
                    fontSize: 16.sp,
                    color: Color(0xff333333),
                  ),),
                ],
              )
            ),
            Positioned(
              top: 110.w + ScreenUtil().statusBarHeight + 30.w, // 调整垂直位置
              left: 20.w, // 调整水平位置
              right: 20.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15.w,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: state.psdTextController,
                          onChanged: (value) {
                            logic.passwordText.value = value;
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            border: InputBorder.none, // 隐藏边框
                            hintText: '请输入密码',
                            hintStyle: TextStyle(
                              color: Color(0xff676767), // 设置提示文字颜色
                              fontSize:16.0, // 可选：调整字体大小
                            ),
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          '忘记密码',
                          style: TextStyle(
                            color: Color(0xff3333333),
                            fontSize: 15.sp,
                          ),
                        ),
                      ),
                    ],
                  ),

                  Divider(
                    color: BColors.mainColor,
                    height: 1,
                    thickness: 1,
                  ),
                  SizedBox(height: 40.w), // 调整下划线与输入框之间的间距
                  // 添加登录按钮
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.w),
                    child: SizedBox(
                      width: double.infinity, // 使按钮宽度和下划线一样长
                      height: 44.w,
                      child: Obx(() {
                        bool isEnabled = logic.passwordText.value.length >= 6;
                        return ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color>(
                                isEnabled
                                    ? BColors.mainColor
                                    : Color(0xffCBE5DA)),
                            elevation: WidgetStateProperty.all(0),
                          ),
                          onPressed: () {
                            // 处理登录点击事件
                            if (logic.passwordText.value.length >= 6) {
                              logic.goLogin();
                            }
                          },
                          child: Text('登录',style: TextStyle(
                            fontSize: 18.sp
                          ),),
                        );
                      }),
                    ),
                  ),
              Padding(padding: EdgeInsets.only(top: 25.w)),
              SizedBox(
                  width: double.infinity, // 使按钮宽度和下划线一样长
                  height: 20.w,
                  child: Text(
                    textAlign: TextAlign.center,
                    "帮助",
                    style: TextStyle(
                        color: Color(0xff333333), fontSize: 15.sp),
                  )),
              SizedBox(height: 25.w,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(image: "alipay".png3x, width: 30.w,),
                  SizedBox(width: 25.w,),
                  Image(image: "wechat".png3x, width: 30.w,),
                ],
              )
                ],
              ),
            ),
          ])),
    );
  }
}
