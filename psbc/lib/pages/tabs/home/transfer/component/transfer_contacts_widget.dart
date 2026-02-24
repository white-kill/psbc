import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:psbc/config/app_config.dart';
import 'package:psbc/utils/color_util.dart';
import 'package:wb_base_widget/extension/string_extension.dart';
import 'package:wb_base_widget/extension/widget_extension.dart';
import 'package:wb_base_widget/text_widget/bank_text.dart';

import '../../../../../../config/dio/network.dart';
import '../../../../../../config/net_config/apis.dart';
import '../../../../../config/model/contacts_model.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../utils/widget_util.dart';
import '../card_transfer/card_transfer_view.dart';
import '../contacts_list/contants_list_view.dart';

class TransferContactsWidget extends StatefulWidget {
  const TransferContactsWidget({super.key});

  @override
  State<TransferContactsWidget> createState() => _TransferContactsWidgetState();
}

class _TransferContactsWidgetState extends State<TransferContactsWidget>
    with SingleTickerProviderStateMixin {
  List<ContactsModel> contactList = [];
  bool showAll = false;

  @override
  void initState() {
    super.initState();

    Http.get(Apis.contactsList).then((v) {
      if (v is List) {
        contactList = v.map((e) => ContactsModel.fromJson(e)).toList();
        print("最近联系人$v");
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 12.w,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10.w))),
      child: Column(
        children: [
          Container(
            height: 45.w,
            padding: EdgeInsets.only(left: 15.w, right: 15.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BaseText(
                  text: "最近收款人",
                  style:
                      TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
                ),
                BaseText(
                  text: "全部",
                  color: Color(0xff4444444),
                  fontSize: 12,
                ).withContainer(
                    alignment: Alignment.center,
                    width: 46.w,
                    height: 24.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15.w)),
                      color: Color(0xffdedede),
                    ),
                    onTap: () {
                      Get.to(() => ContactsListPage());
                    }),
              ],
            ),
          ),
          Container(
            height: 55.w,
            padding: EdgeInsets.only(left: 15.w, right: 15.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image(
                      image: 'mine_head_img'.png3x,
                      width: 38.w,
                      height: 38.w,
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    BaseText(
                      text: AppConfig.config.abcLogic.memberInfo.realName,
                      color: Color(0xff333333),
                      fontSize: 17,
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    Container(
                      width: 70.w,
                      height: 22.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Color(0xff999999), width: 0.8.w),
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.w))),
                      child: BaseText(
                        text: '分享账号',
                        fontSize: 12,
                      ),
                    )
                  ],
                ),

                Row(
                  children: [
                    Container(
                      width: 18.w,
                      height: 18.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: BColors.mainColor.withOpacity(0.2),
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.w))),
                      child: BaseText(
                        text: '0',
                        fontSize: 11,
                        color: BColors.mainColor,
                      ),
                    ),

                    AnimatedRotation(
                      turns: showAll ? 0.25 : 0.0,
                      duration: Duration(milliseconds: 100),
                      child: Image(
                        image: 'ic_jt_right'.png3x,
                        width: 24.w,
                        height: 24.w,
                      ).withPadding(left: 2.w).withOnTap(onTap: () {
                        setState(() {
                          showAll = !showAll;
                        });
                      }),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            height: 3.w,
            color: Color(0xffF8F9FA),
          ),
          ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              ContactsModel model = contactList[index];
              return Container(
                height: 75.w,
                // margin: EdgeInsets.only(left: 17.w),
                padding: EdgeInsets.only(left: 15.w, right: 15.w),
                child: Row(
                  children: [
                    netImage(url: model.icon, width: 30.w, height: 30.w),
                    SizedBox(width: 8.w),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            BaseText(
                              text: model.name,
                              color: Color(0xff333333),
                              fontSize: 16,
                            ).withContainer(width: 260.w),
                            SizedBox(
                              width: 5.w,
                            ),
                          ],
                        ).withContainer(width: 268.w),
                        SizedBox(height: 10.w),
                        BaseText(
                          text:
                              '借记卡｜${model.bankName}(${model.bankCard.getLastFourByList()})',
                          color: Color(0xff666666),
                          fontSize: 12,
                        ),
                      ],
                    ),
                  ],
                ),
              ).withOnTap(onTap: () {
                Get.to(() => CardTransferPage(), arguments: {
                  'icon': model.icon,
                  'bankName': model.bankName,
                  'id': model.bankId,
                  'name': model.name,
                  'bankCard': model.bankCard,
                });
              });
            },
            separatorBuilder: (context, index) {
              return Container(
                color: Color(0xffE5E5E5),
                width: 1.sw,
                height: 1.w,
                padding: EdgeInsets.only(left: 12.w, right: 12.w),
              );
            },
            itemCount: contactList.length,
          ),
        ],
      ),
    );
  }
}
