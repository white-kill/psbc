import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:psbc/pages/tabs/home/scan_widget/scan_widget_view.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../pages/other/fixed_nav/fixed_nav_view.dart';
import '../pages/tabs/home/transfer/transfer_myself/transfer_myself_view.dart';
import '../routes/app_pages.dart';

class ScalePointWidget extends StatefulWidget {
  final double? width;
  final double? left;
  final double? dx;
  final double? dy;
  final Widget? content;
  final Color icColor;
  final double icSize;
  final String? text;
  final String? image;
  final ChangeScalePointController? controller;

  const ScalePointWidget({
    super.key,
    this.width,
    this.left,
    this.content,
    this.controller,
    this.icColor = Colors.black,
    this.icSize = 20,
    this.dx,
    this.dy,
    this.text,
    this.image,
  });

  @override
  State<ScalePointWidget> createState() => _ScalePointWidgetState();
}

class _ScalePointWidgetState extends State<ScalePointWidget> {
  Color color1 = Colors.white;

  @override
  void initState() {
    super.initState();
    widget.controller?.addListener(_onController);
  }

  _onController() {
    if (mounted) {
      if (widget.controller?.type == "changeColor") {
        color1 = widget.controller!.newColor;
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => scalePoint(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: widget.image == null
                    ? 'home_right_add'.png3x
                    : (widget.image ?? '').png3x,
                width: widget.icSize.w,
                height: widget.icSize.w,
                color: widget.icColor,
              ),
              widget.text == null
                  ? const SizedBox.shrink()
                  : BaseText(text: widget.text ?? '')
            ],
          ),
        ),
      );
    });
  }

  void scalePoint(BuildContext context) {
    SmartDialog.showAttach(
      targetContext: context,
      targetBuilder: (targetOffset, targetSize) {
        return Offset(targetOffset.dx - (widget.dx ?? 0),
            targetOffset.dy - (widget.dy ?? 0));
      },
      alignment: Alignment.bottomCenter,
      animationType: SmartAnimationType.scale,
      builder: (_) {
        return SizedBox(
          width: widget.width ?? 100.w,
          child: Stack(children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: widget.left ?? 50.w),
              child: Container(
                width: 14.w,
                height: 14.w,
                color: Colors.white,
                transform: Matrix4.rotationZ(pi / 4),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 7),
              width: widget.width ?? 240.w,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              alignment: Alignment.center,
              child: widget.content ??
                  Column(
                    children: [
                      Row(
                        children: [
                          Image(
                            image: 'ic_qhbb'.png3x,
                            width: 24.w,
                            height: 24.w,
                          ).withPadding(
                            left: 2.w,
                            right: 8.w,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BaseText(
                                text: '切换版本',
                                color: Colors.black,
                              ),
                              Image(
                                image: 'ic_qhbb1'.png3x,
                                width: 50.w,
                                height: 16.w,
                              )
                            ],
                          )
                        ],
                      ).withContainer(
                        onTap: () {
                          SmartDialog.dismiss();
                          Get.to(() => FixedNavPage(),
                              arguments: {'image': 'qhbb', 'title': '切换版本'});
                        },
                        height: 42.w,
                        alignment: Alignment.centerLeft,
                      ),
                      Container(
                        width: 110.w,
                        height: 0.5.w,
                        color: Color(0xffdedede),
                      ),
                      Row(
                        children: [
                          Image(
                            image: 'ic_sys'.png3x,
                            width: 24.w,
                            height: 24.w,
                          ).withPadding(
                            left: 2.w,
                            right: 8.w,
                          ),
                          BaseText(
                            text: '扫一扫',
                            color: Colors.black,
                          ),
                        ],
                      ).withContainer(
                        onTap: () {
                          SmartDialog.dismiss();
                          Get.to(() => ScanWidgetPage());
                        },
                        height: 42.w,
                        alignment: Alignment.centerLeft,
                      ),
                      Container(
                        width: 110.w,
                        height: 0.5.w,
                        color: Color(0xffdedede),
                      ),
                      Row(
                        children: [
                          Image(
                            image: 'ic_ztzx'.png3x,
                            width: 24.w,
                            height: 24.w,
                          ).withPadding(
                            left: 2.w,
                            right: 8.w,
                          ),
                          BaseText(
                            text: '主题中心',
                            color: Colors.black,
                          ),
                        ],
                      ).withContainer(
                        onTap: () {
                          SmartDialog.dismiss();
                          Get.to(() => FixedNavPage(), arguments: {
                            'image': 'ztzx',
                            'title': '主题中心',
                            'navColor': const Color(0xff9CCEFF),
                            'titleColor': Colors.white
                          });
                        },
                        height: 42.w,
                        alignment: Alignment.centerLeft,
                      ),
                      Container(
                        width: 110.w,
                        height: 0.5.w,
                        color: Color(0xffdedede),
                      ),
                      Row(
                        children: [
                          Image(
                            image: 'ic_skm'.png3x,
                            width: 24.w,
                            height: 24.w,
                          ).withPadding(
                            left: 2.w,
                            right: 8.w,
                          ),
                          BaseText(
                            text: '收款码',
                            color: Colors.black,
                          ),
                        ],
                      ).withContainer(
                        onTap: () {
                          SmartDialog.dismiss();
                          Get.to(() => FixedNavPage(), arguments: {
                            'image': 'skm',
                            'title': '收款码',
                            'navColor': const Color(0xffD9EDE1),
                            'titleColor': Colors.white
                          });
                        },
                        height: 39.w,
                        alignment: Alignment.centerLeft,
                      ),
                      Container(
                        width: 110.w,
                        height: 0.5.w,
                        color: Color(0xffdedede),
                      ),
                      Row(
                        children: [
                          Image(
                            image: 'ic_xwzz'.png3x,
                            width: 24.w,
                            height: 24.w,
                          ).withPadding(
                            left: 2.w,
                            right: 8.w,
                          ),
                          BaseText(
                            text: '向我转账',
                            color: Colors.black,
                          ),
                        ],
                      ).withContainer(
                          height: 42.w,
                          alignment: Alignment.centerLeft,
                          onTap: () {
                            SmartDialog.dismiss();
                            Get.to(() => TransferMyselfPage());
                          }),
                      Container(
                        width: 110.w,
                        height: 0.5.w,
                        color: Color(0xffdedede),
                      ),
                      Row(
                        children: [
                          Image(
                            image: 'ic_yqhy'.png3x,
                            width: 24.w,
                            height: 24.w,
                          ).withPadding(
                            left: 2.w,
                            right: 8.w,
                          ),
                          BaseText(
                            text: '邀请好友',
                            color: Colors.black,
                          ),
                        ],
                      ).withContainer(
                          height: 42.w,
                          alignment: Alignment.centerLeft,
                          onTap: () {
                            SmartDialog.dismiss();
                            Get.to(() => FixedNavPage(), arguments: {
                              'image': 'yqhy',
                              'title': '邀请好友',
                              'navColor': const Color(0xffC4D3F0),
                              'titleColor': Colors.white
                            });
                          }),
                    ],
                  ).withPadding(left: 12.w,),
            ),
          ]),
        );
      },
    );
  }
}

class ChangeScalePointController extends ChangeNotifier {
  String type = '';
  Color newColor = Colors.black;

  upDataColor(Color color) {
    type = 'changeColor';
    newColor = color;
    notifyListeners();
  }
}
