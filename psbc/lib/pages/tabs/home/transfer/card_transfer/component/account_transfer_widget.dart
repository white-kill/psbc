import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

class Transfer {
  static InputDecoration normalDecoration(
    String hintText,
    bool isM, {
    Color? hintColor,
  }) {
    return InputDecoration(
      hintText: hintText,
      contentPadding: EdgeInsets.zero,
      hintStyle: TextStyle(
          fontSize: isM ? 19.sp : 15.sp,
          fontWeight: isM ?FontWeight.w500:FontWeight.normal,
          color: hintColor ?? const Color(0xffCACACA)),
      filled: true,
      fillColor: Colors.transparent,
      border: InputBorder.none,
    );
  }

  static Widget itemCellWidget({
    required String title,
    required String hintText,
    Widget? rightWidget,
    TextEditingController? controller,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    FocusNode? focusNode,
    TextStyle? style,
    Color? hintColor,
    Color? textColor,
    TextAlign? textAlign,
    double? leftWidth,
    Function()? onTap,
    VoidCallback? onEditingComplete,
  }) {
    bool isM = title == '¥';
    return Row(
      crossAxisAlignment:
          isM ? CrossAxisAlignment.end : CrossAxisAlignment.center,
      children: [
        BaseText(
          text: title,
          fontSize: isM ? 30.sp : 15.sp,
        ).withContainer(
            width: isM ? 50.w : leftWidth??108.w,
            height: 44.w,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 15.w, top:  isM ?5.w:2.w)),
        SizedBox(
            width: isM
                ? 250.w
                : 210.w,
            height: 44.w,
            child: TextField(
              focusNode: focusNode,
              onChanged: onChanged,
              onSubmitted: onSubmitted,
              controller: controller,
              keyboardType: keyboardType,
              inputFormatters: inputFormatters,
              onEditingComplete: onEditingComplete,
              onTap: onTap,
              textAlign: textAlign??TextAlign.start,
              style: style ??
                  TextStyle(
                    fontSize: isM ? 25.sp : 16.sp,
                    color: textColor??const Color(0xff5C5C5C),
                  ),
              decoration: normalDecoration(
                hintText,
                isM,
                hintColor: hintColor
              ),
            ))
      ],
    );
  }

  static Widget itemInputMoneyWidget({
    required String title,
    required String hintText,
    Widget? rightWidget,
    TextEditingController? controller,
    ValueChanged<String>? onChanged,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    Color? bgColor,
    TextStyle? style,
  }) {
    bool isM = title == '¥';
    return Row(
      crossAxisAlignment:
          isM ? CrossAxisAlignment.end : CrossAxisAlignment.center,
      children: [
        BaseText(
          text: title,
          fontSize: isM ? 25.sp : 15.sp,
        ).withContainer(
            width: isM ? 44.w : 110.w,
            height: 45.w,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 20.w, top: 2.w)),
        SizedBox(
            width: isM
                ? 250.w
                : title == '转账用途'
                    ? 200.w
                    : 180.w,
            height: 45.w,
            child: TextField(
              // focusNode: state.nameLastFocusNode,
              onChanged: onChanged,
              controller: controller,
              keyboardType: keyboardType,
              inputFormatters: inputFormatters,
              style: style ??
                  TextStyle(
                    fontSize: isM ? 25.sp : 16.sp,
                  ),
              decoration: normalDecoration(hintText, isM),
            ))
      ],
    );
  }


  static Widget abcTextField({
    required String title,
    required String hintText,
    Widget? rightWidget,
    TextEditingController? controller,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    FocusNode? focusNode,
    TextStyle? style,
    Color? hintColor,
    Color? textColor,
    TextAlign? textAlign,
    Function()? onTap,
    VoidCallback? onEditingComplete,
  }) {
    return Row(
      children: [
        BaseText(
          text: title,
          fontSize:  15.sp,
        ).withContainer(
            width:110.w,
            height: 44.w,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 15.w, top: 2.w)),
        SizedBox(
            width: 250.w,
            height: 44.w,
            child: TextField(
              focusNode: focusNode,
              onChanged: onChanged,
              onSubmitted: onSubmitted,
              controller: controller,
              keyboardType: keyboardType,
              inputFormatters: inputFormatters,
              onEditingComplete: onEditingComplete,
              onTap: onTap,
              textAlign: textAlign??TextAlign.start,
              style: style ??
                  TextStyle(
                    fontSize:16.sp,
                    color: textColor??const Color(0xff5C5C5C),
                  ),
              decoration: normalDecoration(
                  hintText,
                  false,
                  hintColor: hintColor
              ),
            ))
      ],
    );
  }

}
