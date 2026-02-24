import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wb_base_widget/component/grid_view_widget.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';


class CardTopBannerWidget extends StatefulWidget {
  const CardTopBannerWidget({super.key});

  @override
  State<CardTopBannerWidget> createState() => _CardTopBannerWidgetState();
}

class _CardTopBannerWidgetState extends State<CardTopBannerWidget> {

  @override
  Widget build(BuildContext context) {

    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        return Image(
          image: 'card_top_$index'.png3x,
          width: 1.sw,
          height: 320.h,
        );
      },
      itemCount: 10,
      autoplay: true,
    ).withContainer(
      width: 1.sw,
      height: 320.w
    );
  }
}
