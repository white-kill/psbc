import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SwiperHorizontal extends StatefulWidget {
  final int itemCount;
  final Color activeColor;
  final Color color;
  final bool? loop;
  final bool? autoplay;
  final Widget Function(BuildContext context, int index) widgetBuilder;

  const SwiperHorizontal({
    super.key,
    required this.itemCount,
    required this.widgetBuilder,
    required this.activeColor,
    required this.color,
    this.loop,
    this.autoplay,
  });

  @override
  State<SwiperHorizontal> createState() => _SwiperHorizontalState();
}

class _SwiperHorizontalState extends State<SwiperHorizontal> {
  List widgetIndexList = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.itemCount; i++) {
      widgetIndexList.add(i);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Swiper(
        itemBuilder: widget.widgetBuilder,
        itemCount: widget.itemCount,
        loop:widget.loop?? false,
        autoplay: widget.autoplay??false,
        pagination: SwiperPagination(
            builder: SwiperCustomPagination(builder: (context, config) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widgetIndexList.map((e) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 1.w),
                width: config.activeIndex == e ? 12.w : 3.5.w,
                height: 3.5.w,
                decoration: BoxDecoration(
                  color: config.activeIndex == e
                      ? widget.activeColor
                      : widget.color,
                  borderRadius: BorderRadius.circular(4.w),
                ),
              );
            }).toList(),
          );
        })),
        // control: const SwiperControl(),
      ),
    );
  }
}
